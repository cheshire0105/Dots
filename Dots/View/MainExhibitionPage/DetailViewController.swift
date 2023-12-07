//
//  DetailViewController.swift
//  Dots
//
//  Created by cheshire on 11/13/23.
//  [최신화] : 2023년 11월 23일
//  새 브랜치 생성 - 2023년 11월 23일
//  [최신화] : 2023년 11월 28일 오후 2:45
//  [브랜치 생성] : 2023년 11월 29일 오전 9시 16분
// 최신화
// 최신화

import Foundation

import MapKit // MapKit 프레임워크를 임포트합니다.
import Firebase
import FirebaseStorage

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MKMapViewDelegate {

    let segmentControl = UISegmentedControl(items: ["후기", "상세정보"])
    var reviewsTableView = UITableView()
//    var reviews: [String] = []
    var reviews = [Review]() // 클래스 프로퍼티로 리뷰 배열을 선언합니다.

    var detailScrollView: UIScrollView!
    var detailContentView: UIView!
    let floatingActionButton = UIButton(type: .custom)
    
    var posterImageName: String?

//    let titleLabel = UILabel()
    let exhibitionTitleLabel = UILabel()

    let galleryAddressLabel = UILabel()

    let additionalInfoLabel = UILabel()


    var labelContents = ["23.11.10 - 24.02.12", "09:00 - 17:00", "2,000원", "16점", "김구림 외 3명"]

    var mapView: MKMapView!
    let squaresStackView = UIStackView()
    var locationCoordinate: CLLocationCoordinate2D?
    var exhibitionDetail : String?

    var exhibitionTitle: String? // 클래스 프로퍼티로 전시 타이틀을 저장합니다.

//    override func viewWillAppear(_ animated: Bool) {
//           super.viewWillAppear(animated)
////           loadReviews() // 화면이 나타날 때마다 후기 목록을 새로고침합니다.
//       }
    let refreshControl = UIRefreshControl() // 새로고침 컨트롤 생성


    override func viewDidLoad() {
        super.viewDidLoad()
        loadReviews()
        view.backgroundColor = .black
        configureSegmentControl()
        configureTableView()
//        loadSampleReviews()

        configureDetailScrollView()
        configureFloatingActionButton()
        fetchExhibitionDetails() // Firestore에서 전시 상세 정보를 가져오는 함수 호출
        
        mapView.delegate = self
        configureRefreshControl() // 새로고침 컨트롤 설정 메소드 호출

    }

    // 새로고침 컨트롤 설정 메소드
      func configureRefreshControl() {
          // 새로고침 컨트롤에 대한 타겟-액션 설정
          refreshControl.addTarget(self, action: #selector(refreshReviewsData(_:)), for: .valueChanged)

          // 테이블 뷰에 새로고침 컨트롤 추가
          reviewsTableView.refreshControl = refreshControl
      }

      // 새로고침 시 호출될 메소드
      @objc private func refreshReviewsData(_ sender: UIRefreshControl) {
          // 최신 리뷰 데이터 로드
          loadReviews()

          // 로드 완료 후 새로고침 컨트롤 종료
          refreshControl.endRefreshing()
      }

    func loadReviews() {
        guard let posterName = posterImageName else {
            print("posterImageName is nil")
            return
        }

        Firestore.firestore().collection("posters").document(posterName)
            .collection("reviews")
            .order(by: "createdAt", descending: true) // 날짜 기준 내림차순 정렬
            .getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("Error getting documents: \(error)")
                    return
                }
                var newReviews: [Review] = []
                let group = DispatchGroup()

                querySnapshot?.documents.forEach { document in
                    group.enter()
                    let data = document.data()
                    let userId = document.documentID // UUID로 가정

                    Firestore.firestore().collection("유저_데이터_관리").document(userId)
                        .getDocument { (userDoc, error) in
                            if let userDoc = userDoc, userDoc.exists {
                                let userData = userDoc.data()
                                let nickname = userData?["닉네임"] as? String ?? ""
                                let profileImageUrl = userData?["프로필이미지URL"] as? String ?? ""

                                let review = Review(
                                    title: data["title"] as? String ?? "",
                                    content: data["content"] as? String ?? "",
                                    createdAt: (data["createdAt"] as? Timestamp)?.dateValue() ?? Date(),
                                    nickname: nickname,
                                    profileImageUrl: profileImageUrl,
                                    photoUrls: data["images"] as? [String] ?? []
                                )
                                newReviews.append(review)
                            }
                            group.leave()
                        }
                }

                group.notify(queue: .main) {
                    self.reviews = newReviews
                    self.reviewsTableView.reloadData()
                }
            }
    }




    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "CustomPin"

        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            // 새로운 MKAnnotationView 생성
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true // 필요한 경우 콜아웃 활성화
        } else {
            // 재사용 가능한 뷰 업데이트
            annotationView?.annotation = annotation
        }

        // 여기에서 커스텀 이미지를 설정합니다.
        annotationView?.image = UIImage(named: "place") // "customPinImage"를 프로젝트에 있는 이미지 이름으로 교체

        return annotationView
    }


    // UI를 전시 상세 정보로 업데이트하는 함수
    private func updateUIWithExhibitionDetails(_ exhibitionDetail: ExhibitionDetailModel) {
        DispatchQueue.main.async {
            // titleLabel에 전시 타이틀을 설정
//            self.titleLabel.text = exhibitionDetail.exhibitionTitle

            // exhibitionTitleLabel에 미술관 이름을 설정
            self.exhibitionTitleLabel.text = exhibitionDetail.museumName
            self.galleryAddressLabel.text = exhibitionDetail.museumAddress
//            self.additionalInfoLabel.text = exhibitionDetail.exhibitionDetail

            // additionalInfoLabel에 전시 상세 정보를 설정하고 줄바꿈 처리
                   let detailTextWithLineBreaks = exhibitionDetail.exhibitionDetail.replacingOccurrences(of: "\\n", with: "\n")
                   self.additionalInfoLabel.text = detailTextWithLineBreaks

            // 스택 뷰에 데이터 바인딩
            self.labelContents = [
                exhibitionDetail.exhibitionDates,
                exhibitionDetail.exhibitionHours,
                exhibitionDetail.exhibitionPrice,
                exhibitionDetail.artworkCount,
                exhibitionDetail.artistCount
            ]

            // 스택 뷰 업데이트
            self.updateStackView()
        }
    }

    // 스택 뷰 업데이트 함수
    private func updateStackView() {
        // squaresStackView에 있는 각 레이블에 새로운 값을 설정합니다.
        for (index, label) in squaresStackView.arrangedSubviews.enumerated() {
            if let containerView = label as? UIView, let label = containerView.subviews.last as? UILabel {
                label.text = labelContents[index]
            }
        }
    }





    // Firestore에서 전시 상세 정보를 가져오는 함수
    // Firestore에서 전시 상세 정보를 가져오는 함수
    // Firestore에서 전시 상세 정보를 가져오는 함수
    private func fetchExhibitionDetails() {
        guard let posterName = posterImageName else {
            print("posterImageName is nil")
            return
        }

        let documentRef = Firestore.firestore().collection("전시_상세").document(posterName)
        documentRef.getDocument { [weak self] (document, error) in
            if let document = document, document.exists {
                let data = document.data()
                print("Fetched document data: \(data ?? [:])")

                if let geoPoint = data?["전시_좌표"] as? GeoPoint {
                    // GeoPoint에서 위도와 경도를 추출합니다.
                    let location = CLLocationCoordinate2D(latitude: geoPoint.latitude, longitude: geoPoint.longitude)
                    // 지도 뷰 위치 업데이트 함수 호출
                    self?.updateMapViewWithLocation(location: location)
                }

                let exhibitionDetail = ExhibitionDetailModel(dictionary: data ?? [:])
                self?.exhibitionTitle = exhibitionDetail.exhibitionTitle // 전시 타이틀 저장

                self?.updateUIWithExhibitionDetails(exhibitionDetail)
            } else {
                print("Document does not exist or error fetching document: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
    }




//    // UI를 전시 상세 정보로 업데이트하는 함수
//    private func updateUIWithExhibitionDetails(_ exhibitionDetail: ExhibitionDetailModel) {
//        DispatchQueue.main.async {
//            // titleLabel에 전시 타이틀을 설정
//            self.titleLabel.text = exhibitionDetail.exhibitionTitle
//
//            // exhibitionTitleLabel에 미술관 이름을 설정
//            self.exhibitionTitleLabel.text = exhibitionDetail.museumName
//            self.galleryAddressLabel.text = exhibitionDetail.museumAddress
//
//        }
//    }

    // 지도 위치 업데이트 함수
    private func updateMapViewWithLocation(location: CLLocationCoordinate2D) {
        DispatchQueue.main.async {
            let region = MKCoordinateRegion(center: location, latitudinalMeters: 500, longitudinalMeters: 500)
            self.mapView.setRegion(region, animated: true)

            // 지도에 핀 추가
            let pin = MKPointAnnotation()
            pin.coordinate = location
            self.mapView.addAnnotation(pin)
        }
    }

    func configureFloatingActionButton() {
        floatingActionButton.translatesAutoresizingMaskIntoConstraints = false
        floatingActionButton.backgroundColor = .white
        floatingActionButton.setTitle("후기 작성", for: .normal)
        floatingActionButton.setTitleColor(.black, for: .normal)
        floatingActionButton.layer.cornerRadius = 23
        floatingActionButton.titleLabel?.font = UIFont.systemFont(ofSize: 13) // 타이틀 폰트 크기 설정
        // Initially hide the floating action button until the first segment is selected
//               floatingActionButton.isHidden = segmentControl.selectedSegmentIndex != 0


        // 이미지 설정
        let buttonImage = UIImage(named: "Union 2") // 'reviewIcon'은 프로젝트에 포함된 이미지 이름이어야 합니다.
        floatingActionButton.setImage(buttonImage, for: .normal)

        // 타이틀의 여백을 설정하여 이미지와 텍스트 사이에 간격을 줍니다.
        floatingActionButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)

        // 이미지의 여백을 설정하여 이미지와 버튼의 왼쪽 가장자리 사이에 간격을 줍니다.
        floatingActionButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)

        // 버튼에 액션 추가
        floatingActionButton.addTarget(self, action: #selector(floatingActionButtonTapped), for: .touchUpInside)

        view.addSubview(floatingActionButton)

        // 버튼의 제약 조건 설정
        floatingActionButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10)
            make.width.equalTo(124)
            make.height.equalTo(46)
        }
    }

    @objc func floatingActionButtonTapped() {
        let reviewWriteVC = ReviewWritePage()
        reviewWriteVC.delegate = self

        reviewWriteVC.posterName = self.posterImageName // 여기서 포스터 이름을 전달합니다.
        reviewWriteVC.reviewTitle = self.exhibitionTitle // 전시 타이틀을 ReviewWritePage에 전달합니다.


        let navController = UINavigationController(rootViewController: reviewWriteVC) // UINavigationController를 생성하고 rootViewController로 설정합니다.
        navController.modalPresentationStyle = .fullScreen // 전체 화면으로 설정
        self.present(navController, animated: true, completion: nil) // UINavigationController를 모달로 표시합니다.
    }






    func configureSegmentControl() {

//        // 타이틀 레이블을 설정합니다.
//        titleLabel.text = "현대차 시리즈 2023: 정연두 - 백년여행"
//        titleLabel.textAlignment = .center
//        titleLabel.textColor = .white
//        titleLabel.numberOfLines = 2
//        titleLabel.font = UIFont(name: "Pretendard-Bold", size: 20)
//        view.addSubview(titleLabel)

        // 세그먼트 컨트롤을 설정합니다.
        segmentControl.selectedSegmentIndex = 0 // 기본 선택 인덱스를 설정합니다.
        segmentControl.backgroundColor = UIColor.black // 배경색 설정
        segmentControl.selectedSegmentTintColor = UIColor(red: 0.388, green: 0.388, blue: 0.4, alpha: 1)// 선택된 아이템의 배경색 설정

        // 텍스트 색상 변경을 위한 설정
        let normalTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let selectedTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

        segmentControl.setTitleTextAttributes(normalTextAttributes, for: .normal)
        segmentControl.setTitleTextAttributes(selectedTextAttributes, for: .selected)

        segmentControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        view.addSubview(segmentControl)

//        titleLabel.snp.makeConstraints { make in
//            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
//            make.centerX.equalTo(view.snp.centerX)
//            make.left.right.equalToSuperview().inset(20)
//        }

        segmentControl.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.centerX.equalTo(view.snp.centerX)
            make.leading.equalTo(view.snp.leading).offset(110)
            make.trailing.equalTo(view.snp.trailing).offset(-110)
        }
    }

    func configureTableView() {
        reviewsTableView.register(새로운_ReviewTableViewCell.self, forCellReuseIdentifier: "새로운_ReviewTableViewCell")
        reviewsTableView.dataSource = self
        reviewsTableView.delegate = self
        view.addSubview(reviewsTableView)

        reviewsTableView.backgroundColor = .black


        reviewsTableView.separatorStyle = .none

        // 테이블 뷰에 대한 SnapKit 레이아웃 설정
        reviewsTableView.snp.makeConstraints { make in
            make.top.equalTo(segmentControl.snp.bottom).offset(10)
            make.left.right.equalTo(view)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

    func configureDetailScrollView() {

        let totalHorizontalPadding: CGFloat = 40 // 양쪽의 여백 합계
        let spacingBetweenItems: CGFloat = 10 // 아이템 사이의 간격
        let numberOfItems: CGFloat = 5 // 스택 뷰 내의 아이템 수
        let totalSpacing: CGFloat = (numberOfItems - 1) * spacingBetweenItems // 아이템 사이의 총 간격

        // 스택 뷰의 각 요소에 대한 너비를 계산합니다.
        let itemWidth = (view.frame.width - totalHorizontalPadding - totalSpacing) / numberOfItems


        // 스크롤 뷰 초기화
        detailScrollView = UIScrollView()
        detailScrollView.backgroundColor = .black // 배경색 설정
        view.addSubview(detailScrollView)
        detailScrollView.isHidden = true // 초기 상태는 숨겨져 있음

        // 스크롤 뷰에 들어갈 컨텐츠 뷰 초기화
        detailContentView = UIView()
        detailScrollView.addSubview(detailContentView)

        // 전시 제목 레이블 초기화
        exhibitionTitleLabel.text = "갤러리바톤"
        exhibitionTitleLabel.textColor = .white
        exhibitionTitleLabel.font = UIFont(name: "Pretendard-Medium", size: 18)

        // 미술관 주소 레이블 초기화
        galleryAddressLabel.text = "서울 종로구 삼청로 30"
        galleryAddressLabel.textColor = .white
        galleryAddressLabel.numberOfLines = 2
        galleryAddressLabel.font = UIFont(name: "Pretendard-Medium", size: 16)

        // 컨텐츠 뷰에 레이블 추가
        detailContentView.addSubview(exhibitionTitleLabel)
        detailContentView.addSubview(galleryAddressLabel)

        mapView = MKMapView()
        detailContentView.addSubview(mapView)
        // 지도 뷰 모서리 둥글게 설정
        mapView.layer.cornerRadius = 10
        mapView.clipsToBounds = true
        mapView.overrideUserInterfaceStyle = .dark

        // 지도 뷰 제약 조건 설정
        mapView.snp.makeConstraints { make in
            make.top.equalTo(detailContentView.snp.top).offset(20)
            make.right.equalTo(detailContentView.snp.right).offset(-18)
            make.width.equalTo(130) // 지도 뷰의 너비를 지정합니다.
            make.height.equalTo(mapView.snp.width).multipliedBy(0.6) // 지도의 높이를 너비의 0.6배로 설정합니다.
        }



        // 스크롤 뷰 제약 조건 설정
        // 스크롤 뷰의 제약 조건 설정
        detailScrollView.snp.makeConstraints { make in
            make.top.equalTo(segmentControl.snp.bottom).offset(10) // 세그먼트 컨트롤 바로 아래에 위치
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide) // 양 옆 및 하단을 safeArea에 맞춤
        }

        // 전시 제목 레이블 레이아웃 설정
        exhibitionTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(detailContentView.snp.top).offset(30) // 상단 여백
            make.leading.equalTo(detailContentView.snp.leading).offset(20) // 좌측 여백
        }

        // 미술관 주소 레이블 레이아웃 설정
        galleryAddressLabel.snp.makeConstraints { make in
            make.top.equalTo(exhibitionTitleLabel.snp.bottom).offset(8) // 전시 제목 레이블 아래 간격
            make.leading.equalTo(exhibitionTitleLabel.snp.leading) // 좌측 정렬
            make.trailing.equalTo(mapView.snp.leading).offset(10)
        }




        // 스택 뷰 생성 및 구성
        squaresStackView.axis = .horizontal
        squaresStackView.distribution = .fillEqually
        squaresStackView.alignment = .fill
        squaresStackView.spacing = 10 // 또는 원하는 간격

        // 각 이미지 뷰에 설정할 이미지 이름 배열
        let imageNames = ["calenderE", "Group 50", "Group 48", "Union 1", "Group 125"]



        // 스택 뷰의 각 요소 내에 정사각형 검정 뷰 추가 및 그 아래 레이블 추가
        // 스택 뷰에 이미지 뷰와 레이블을 추가하는 코드
        // 상위 컨테이너 뷰와 각각의 스택을 만들어서 그 안에 이미지와 레이블을 넣습니다.
        for index in 0..<5 {
            // 컨테이너 뷰 생성
            let containerView = UIView()
            containerView.clipsToBounds = true // 모서리가 둥근 하위 뷰를 클리핑하기 위함
            squaresStackView.addArrangedSubview(containerView)

            containerView.snp.makeConstraints { make in
                make.width.equalTo(itemWidth) // 계산된 너비 설정
                make.height.equalTo(130) // 설정된 높이
            }

            // 정사각형 뷰 생성 및 설정
            let squareView = UIView()
            squareView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.2) // 20% 투명도의 흰색 배경 설정

            squareView.layer.cornerRadius = 10 // 모서리 둥글게 설정
            containerView.addSubview(squareView) // 컨테이너 뷰에 squareView 추가

            squareView.snp.makeConstraints { make in
                make.top.equalTo(containerView.snp.top) // 상단 맞춤
                make.width.equalTo(containerView.snp.width) // 너비 맞춤
                make.height.equalTo(squareView.snp.width) // 높이를 너비와 동일하게 설정하여 정사각형 만듬
                make.centerX.equalTo(containerView.snp.centerX) // 가운데 맞춤
            }

            // 이미지 뷰 설정
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.image = UIImage(named: imageNames[index])
            squareView.addSubview(imageView) // squareView에 imageView 추가

            imageView.snp.makeConstraints { make in
                make.size.equalTo(squareView.snp.size).multipliedBy(0.5) // squareView 대비 80% 크기로 설정
                make.center.equalTo(squareView.snp.center) // squareView 중앙에 위치
            }

            // 레이블 설정
            let label = UILabel()
            label.text = labelContents[index]
            label.textColor = .white
            label.textAlignment = .center
            label.font = UIFont(name: "Pretendard-Regular", size: 12)
            label.numberOfLines = 0 // 최대 두 줄로 설정
            containerView.addSubview(label) // containerView에 label 추가

            label.snp.makeConstraints { make in
                make.top.equalTo(squareView.snp.bottom).offset(10) // squareView 아래에 위치
                make.centerX.equalTo(containerView.snp.centerX) // containerView 중앙에 위치
                make.leading.trailing.equalTo(containerView) // containerView의 leading과 trailing에 맞춤
            }
        }

        // 스크롤 뷰 내 컨텐츠 뷰에 스택 뷰 추가
        detailContentView.addSubview(squaresStackView)

        // 스택 뷰의 제약 조건 설정
        // 스택 뷰의 제약 조건 설정
        squaresStackView.snp.makeConstraints { make in
            make.top.equalTo(mapView.snp.bottom).offset(20) // mapView 아래에 위치
            make.leading.equalTo(detailContentView.snp.leading).offset(20) // detailContentView의 leading에 맞춤
            make.trailing.equalTo(detailContentView.snp.trailing).offset(-20) // detailContentView의 trailing에 맞춤
        }

        // 스택 뷰 아래에 보더 라인 추가
        let borderLineView = UIView()
        borderLineView.backgroundColor = UIColor(red: 0.162, green: 0.162, blue: 0.162, alpha: 1) // 보더 라인의 색상 설정
        detailContentView.addSubview(borderLineView) // 스택 뷰를 포함하는 detailContentView에 추가

        borderLineView.snp.remakeConstraints { make in
            make.top.equalTo(squaresStackView.snp.bottom).offset(10) // 스택 뷰 바로 아래에 위치
            make.leading.equalTo(detailContentView.snp.leading)
            make.trailing.equalTo(detailContentView.snp.trailing)
            make.height.equalTo(1) // 보더 라인의 높이 설정
        }

       // 보더 라인 아래에 추가할 레이블 생성
        additionalInfoLabel.text = """
«김구림»은 실험미술의 선구자인 김구림의 예술 세계를 조명하는 개인전이다.
"""
        additionalInfoLabel.textColor = .white
        additionalInfoLabel.font = UIFont(name: "Pretendard-Regular", size: 14)
        additionalInfoLabel.numberOfLines = 0 // 제한 없이 여러 줄 표시 가능


        additionalInfoLabel.numberOfLines = 0
        additionalInfoLabel.textColor = UIColor(red: 0.733, green: 0.733, blue: 0.733, alpha: 1)
        additionalInfoLabel.font = UIFont(name: "Pretendard-Regular", size: 14)
        additionalInfoLabel.lineBreakMode = .byWordWrapping
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.02
        // Line height: 18 pt
        paragraphStyle.alignment = .justified
        let attrString = NSMutableAttributedString(string: additionalInfoLabel.text!)
        paragraphStyle.lineSpacing = 1
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
        additionalInfoLabel.attributedText = attrString

        // contentView에 추가 정보 레이블 추가
        detailContentView.addSubview(additionalInfoLabel)

        // 추가 정보 레이블에 대한 제약 조건 설정
        additionalInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(borderLineView.snp.bottom).offset(25) // 보더 라인 바로 아래에 위치
            make.leading.equalTo(detailContentView.snp.leading).offset(20) // 컨텐츠 뷰의 leading에 여백을 주어 설정
            make.trailing.equalTo(detailContentView.snp.trailing).offset(-20) // 컨텐츠 뷰의 trailing에 여백을 주어 설정
            make.bottom.equalTo(detailContentView.snp.bottom).offset(-20)


        }

        // contentView의 제약 조건 설정을 업데이트합니다.
        detailContentView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalTo(detailScrollView) // 스크롤 뷰에 맞춤
            make.width.equalTo(detailScrollView) // contentView의 너비를 스크롤 뷰의 너비와 일치시킴

            //            make.bottom.equalTo(additionalInfoLabel.snp.bottom).offset(20) // 이걸 주석 처리 했더니 스크롤 문제 해결
        }

    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let mapVC = MapViewController()
        mapVC.imageName = self.posterImageName // 필요한 데이터를 설정합니다.
        let navController = UINavigationController(rootViewController: mapVC)
        navController.modalPresentationStyle = .fullScreen // 전체 화면 설정

        // 현재 뷰 컨트롤러가 모달 방식으로 표시되었고, 네비게이션 컨트롤러가 없는 경우
        if self.presentingViewController != nil {
            self.dismiss(animated: true) {
                // 모달이 닫힌 후 새로운 네비게이션 컨트롤러를 모달로 표시
                UIApplication.shared.windows.first?.rootViewController?.present(navController, animated: true, completion: nil)
            }
        } else if let navigationController = self.navigationController {
            // 현재 뷰 컨트롤러가 네비게이션 컨트롤러에 포함되어 있는 경우
            navigationController.pushViewController(mapVC, animated: true)
        } else {
            // 다른 경우 (예: 루트 뷰 컨트롤러에서 직접 호출)
            UIApplication.shared.windows.first?.rootViewController?.present(navController, animated: true, completion: nil)
        }
    }



    @objc func segmentChanged(_ sender: UISegmentedControl) {
         // Only show the floating action button when the first segment ("Reviews") is selected
         floatingActionButton.isHidden = sender.selectedSegmentIndex != 0
         reviewsTableView.isHidden = sender.selectedSegmentIndex != 0
         detailScrollView.isHidden = sender.selectedSegmentIndex != 1
     }

    // UITableViewDataSource 메서드
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "새로운_ReviewTableViewCell", for: indexPath) as? 새로운_ReviewTableViewCell else {
            return UITableViewCell()
        }

        let review = reviews[indexPath.row]
        let timeString = convertDateToString(review.createdAt) // 리뷰 작성 시간을 문자열로 변환

        // 셀에 리뷰 정보를 설정합니다.
        cell.setReview(nikeName: review.nickname, content: review.content, profileImageUrl: review.profileImageUrl, nickname: timeString, newTitle: review.title, extraImageView1: UIImage(named: "Vector 4"), extraImageView2: UIImage(named: "streamline_interface-edit-view-eye-eyeball-open-view 1"), text123: "123", text456: "456")

        return cell
    }



    // 날짜 변환 함수 (예제)
    func convertDateToString(_ date: Date) -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.locale = Locale(identifier: "ko-KR") // 한국어로 설정
        formatter.unitsStyle = .full // 전체 스타일로 표시 ('3분 전' 등)
        return formatter.localizedString(for: date, relativeTo: Date())
    }


    // UITableViewDelegate 메서드
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension // 자동으로 셀의 높이를 계산합니다.
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100 // 추정 높이를 설정합니다. 셀의 내용에 따라 실제 높이는 달라질 수 있습니다.
    }




    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedReview = reviews[indexPath.row]
        print("Selected Review: \(selectedReview)")

        let detailViewController = ReviewDetailViewController()
        detailViewController.hidesBottomBarWhenPushed = true

        // 여기에서 전달되는 데이터를 로그로 출력합니다.
        print("Review Title: \(selectedReview.title)")
        print("Review Content: \(selectedReview.content)")
        print("Review Image URLs: \(selectedReview.photoUrls)")

        detailViewController.review = selectedReview
        detailViewController.museumName = exhibitionTitleLabel.text
        detailViewController.exhibitionTitle = exhibitionTitle

        // 이미지 URL 배열을 전달합니다.
        detailViewController.imageUrls = selectedReview.photoUrls

        let navigationController = UINavigationController(rootViewController: detailViewController)
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: true, completion: nil)
    }







    



}

extension DetailViewController: ReviewWritePageDelegate {
    func didSubmitReview() {
        loadReviews() // 리뷰를 다시 로드합니다.
    }
}
