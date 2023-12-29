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
    


    var labelContents = ["전시 기간: 23.11.10 - 24.02.12", "전시 시간: 09:00 - 17:00", "가격: 2,000원", "장르/작품수: 16점", "작가: 김구림 외 3명"]
    let alertTitles = ["전시 기간", "전시 시간", "가격", "장르/작품수", "작가"]


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
          refreshControl.tintColor = UIColor(red: 0.882, green: 1, blue: 0, alpha: 1)
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

    func makeEmptyTableViewBackgroundView() -> UIView {
        let emptyView = UIView(frame: CGRect(x: 0, y: 0, width: reviewsTableView.bounds.size.width, height: reviewsTableView.bounds.size.height))
        let messageLabel = UILabel()
        messageLabel.text = "아직 후기가 없어요."
        messageLabel.textColor = .white
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "Pretendard-Bold", size: 30)

        let messageLabelTwo = UILabel()
        messageLabelTwo.text = "회원님이 남겨주신 후기가 다른 회원의 관람에 도움이 될 수 있어요. 첫 후기를 남겨볼까요?"
        messageLabelTwo.textColor = UIColor(red: 0.757, green: 0.753, blue: 0.773, alpha: 1)
        messageLabelTwo.textAlignment = .center
        messageLabelTwo.numberOfLines = 0
        messageLabelTwo.font = UIFont(name: "Pretendard-Bold", size: 16)

        let imageView = UIImageView()
        imageView.image = UIImage(named: "내후기 1 1") // "emptyImage"는 프로젝트에 포함된 이미지 파일 이름

        let newReviewButton = UIButton(type: .system)
            newReviewButton.setTitle("후기 작성하기", for: .normal)
            newReviewButton.titleLabel?.font = UIFont(name: "Pretendard-Bold", size: 16)
            newReviewButton.backgroundColor = UIColor(red: 0.882, green: 1, blue: 0, alpha: 1)
            newReviewButton.setTitleColor(.black, for: .normal)
            newReviewButton.layer.cornerRadius = 22
            newReviewButton.addTarget(self, action: #selector(newReviewButtonTapped), for: .touchUpInside)

            emptyView.addSubview(newReviewButton)

        emptyView.addSubview(imageView)
        emptyView.addSubview(messageLabel)
        emptyView.addSubview(messageLabelTwo)


        // 이미지와 레이블 레이아웃 설정
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview() // 가로축 중앙에 배치
            make.top.equalToSuperview().offset(60)
            make.width.equalTo(100) // 이미지 크기 설정
            make.height.equalTo(imageView.snp.width) // 정사각형 이미지
        }


        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(50)
            make.left.right.equalToSuperview().inset(20)
        }

        messageLabelTwo.snp.makeConstraints { make in
            make.top.equalTo(messageLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(57)
        }

        newReviewButton.snp.makeConstraints { make in
            make.top.equalTo(messageLabelTwo.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(44)
        }


        return emptyView
    }

    @objc func newReviewButtonTapped() {
        // 후기 작성 페이지 또는 관련 액션을 여기서 처리
        let reviewWriteVC = ReviewWritePage()
        reviewWriteVC.delegate = self
        reviewWriteVC.posterName = self.posterImageName
        reviewWriteVC.reviewTitle = self.exhibitionTitle
        let navController = UINavigationController(rootViewController: reviewWriteVC)
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated: true, completion: nil)
    }

    func updateFloatingActionButtonText() {
        // 현재 사용자 ID 가져오기
        guard let currentUserID = Auth.auth().currentUser?.uid else {
            print("Current user ID not available")
            return
        }

        // 현재 사용자의 후기가 있는지 확인
        let hasCurrentUserReview = reviews.contains { $0.userId == currentUserID }

        // 플로팅 버튼의 텍스트 업데이트
        let buttonTitle = hasCurrentUserReview ? "내 후기" : "후기 작성"
        floatingActionButton.setTitle(buttonTitle, for: .normal)
    }



    func loadReviews() {
        guard let posterName = posterImageName else {
            print("posterImageName is nil")
            return
        }

        Firestore.firestore().collection("posters").document(posterName)
            .collection("reviews")
            .order(by: "createdAt", descending: true) // 날짜 기준 내림차순 정렬
            .getDocuments { [weak self] (querySnapshot, error) in
                if let error = error {
                    print("Error getting documents: \(error)")
                    return
                }

                let group = DispatchGroup()
                var newReviews: [Review] = []

                querySnapshot?.documents.forEach { document in
                    group.enter()
                    let data = document.data()
                    let userId = document.documentID // UUID로 가정
                    let likes = data["likes"] as? [String: Bool] ?? [:]


                    Firestore.firestore().collection("유저_데이터_관리").document(userId)
                        .getDocument { (userDoc, error) in
                            defer { group.leave() }

                            if let userDoc = userDoc, userDoc.exists {
                                let userData = userDoc.data()
                                let nickname = userData?["닉네임"] as? String ?? ""
                                let profileImageUrl = userData?["프로필이미지URL"] as? String ?? ""
                                let userReviewUUID = document.documentID // UUID를 가져옵니다.
                                let likesNum = data["likesNum"] as? Int ?? 0 // 'likesNum' 필드를 읽어옴



                                let review = Review(
                                    title: data["title"] as? String ?? "",
                                    content: data["content"] as? String ?? "",
                                    createdAt: (data["createdAt"] as? Timestamp)?.dateValue() ?? Date(),
                                    nickname: nickname,
                                    profileImageUrl: profileImageUrl,
                                    photoUrls: data["images"] as? [String] ?? [],
                                    userId: data["userId"] as? String ?? "", 
                                    userReviewUUID: userReviewUUID,
                                    likes: likes,
                                    likesNum: likesNum


                                )

                                newReviews.append(review)
                            }
                        }
                }

                group.notify(queue: .main) {
                    // 모든 비동기 작업이 완료된 후에 실행됩니다.
                    // newReviews 배열을 createdAt 기준으로 정렬합니다.
                    self?.reviews = newReviews.sorted(by: { $0.createdAt > $1.createdAt })
                    self?.reviewsTableView.reloadData()
                    self?.updateTableViewBackground()
                    // 플로팅 버튼 텍스트 업데이트
                       self?.updateFloatingActionButtonText() // 여기에 추가
                }
            }
    }

    // 테이블 뷰 배경 업데이트 함수
    func updateTableViewBackground() {
        if reviews.isEmpty {
            reviewsTableView.backgroundView = makeEmptyTableViewBackgroundView()
            floatingActionButton.isHidden = true // 리뷰가 없을 때 플로팅 버튼 숨김
        } else {
            reviewsTableView.backgroundView = nil
            floatingActionButton.isHidden = false // 리뷰가 있을 때 플로팅 버튼 표시
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
        for (index, view) in squaresStackView.arrangedSubviews.enumerated() {
            if let containerView = view as? UIView, let label = containerView.subviews.last as? UILabel {
                // alertTitles 배열에서 해당 인덱스의 값을 가져와 설정합니다.
                label.text = alertTitles[index]
            }
        }
    }








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

//    @objc func floatingActionButtonTapped() {
//        let reviewWriteVC = ReviewWritePage()
//        reviewWriteVC.delegate = self
//
//        reviewWriteVC.posterName = self.posterImageName // 여기서 포스터 이름을 전달합니다.
//        reviewWriteVC.reviewTitle = self.exhibitionTitle // 전시 타이틀을 ReviewWritePage에 전달합니다.
//
//
//        let navController = UINavigationController(rootViewController: reviewWriteVC) // UINavigationController를 생성하고 rootViewController로 설정합니다.
//        navController.modalPresentationStyle = .fullScreen // 전체 화면으로 설정
//        self.present(navController, animated: true, completion: nil) // UINavigationController를 모달로 표시합니다.

        @objc func floatingActionButtonTapped() {
            if let currentUserReview = findCurrentUserReview() {
                // 현재 사용자의 후기가 있을 경우 상세 페이지로 이동
                navigateToReviewDetailPage(with: currentUserReview)
            } else {
                // 현재 사용자의 후기가 없을 경우 후기 작성 페이지로 이동
                navigateToReviewWritePage()
            }
        }

    



    func navigateToReviewDetailPage(with review: Review) {
        let detailViewController = ReviewDetailViewController()
        detailViewController.review = review
        // 필요한 추가 데이터 설정
        detailViewController.museumName = exhibitionTitleLabel.text
        detailViewController.exhibitionTitle = exhibitionTitle
        detailViewController.imageUrls = review.photoUrls
        detailViewController.userReviewUUID = review.userReviewUUID

        let navigationController = UINavigationController(rootViewController: detailViewController)
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: true, completion: nil)
    }

    func navigateToReviewWritePage() {
        // 후기 작성 페이지로 이동하는 기존 코드
        let reviewWriteVC = ReviewWritePage()
        reviewWriteVC.delegate = self
        reviewWriteVC.posterName = self.posterImageName
        reviewWriteVC.reviewTitle = self.exhibitionTitle
        let navController = UINavigationController(rootViewController: reviewWriteVC)
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated: true, completion: nil)
    }




    func configureSegmentControl() {

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

        segmentControl.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.centerX.equalTo(view.snp.centerX)
            make.leading.equalTo(view.snp.leading).offset(110)
            make.trailing.equalTo(view.snp.trailing).offset(-110)
        }
    }

    func configureTableView() {
        reviewsTableView.register(ReviewTableViewCell.self, forCellReuseIdentifier: "ReviewTableViewCell")
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
          squaresStackView.spacing = 10 // 간격을 0으로 설정

        // 각 이미지 뷰에 설정할 이미지 이름 배열
          let imageNames = ["period", "period 1", "period 2"] // 이미지 이름을 세 개로 변경
          let alertTitles = ["전시 기간", "관람 시간", "입장료"] // 타이틀을 세 개로 변경


        // 스택 뷰의 각 요소 내에 버튼과 레이블 추가
        for index in 0..<3 {
            let containerView = UIView()
            containerView.clipsToBounds = true
            squaresStackView.addArrangedSubview(containerView)

            // 컨테이너 뷰 제약 조건 설정
            containerView.snp.makeConstraints { make in
                make.height.equalTo(50)
            }

            let button = UIButton()
            button.backgroundColor = .black
            button.layer.cornerRadius = 10
            button.setImage(UIImage(named: imageNames[index]), for: .normal)
            button.setTitle(alertTitles[index], for: .normal)
            button.titleLabel?.font = UIFont(name: "Pretendard-Regular", size: 14)
            button.setTitleColor(.white, for: .normal)

            // 이미지의 여백을 조절
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 10)

            // 타이틀의 여백을 조절
            button.titleEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: -10)

            containerView.addSubview(button)
            button.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }

            // 마지막 버튼이 아닐 경우 경계선 추가
            if index < 2 {
                let separator = UIView()
                separator.backgroundColor = UIColor(red: 0.219, green: 0.219, blue: 0.219, alpha: 1)
                containerView.addSubview(separator)
                separator.snp.makeConstraints { make in
                    make.trailing.equalTo(containerView.snp.trailing)
                    make.width.equalTo(1) // 경계선 두께
                    make.top.bottom.equalToSuperview().inset(20)
                }
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

    func findCurrentUserReview() -> Review? {
        guard let currentUserID = Auth.auth().currentUser?.uid else {
            print("Current user ID not available")
            return nil
        }
        return reviews.first { $0.userId == currentUserID }
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

    // 버튼 탭 액션
    @objc func buttonTapped(sender: UIButton) {
        // 버튼의 시각적 변화 (눌림 효과)
        UIView.animate(withDuration: 0.1, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { _ in
            sender.transform = .identity
        }

        // 진동 효과
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()

        // 나머지 기능 처리 (예: 얼럿 표시)
        let tag = sender.tag
        let alertTitle = alertTitles[tag]
        let labelText = labelContents[tag].replacingOccurrences(of: "\\n", with: "\n")
        showCustomAlert(title: alertTitle, message: labelText)
    }








    @objc func segmentChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 { // 후기 탭 선택 시
            reviewsTableView.isHidden = false
            detailScrollView.isHidden = true
            floatingActionButton.isHidden = reviews.isEmpty // 리뷰가 없으면 버튼 숨김
        } else { // 상세정보 탭 선택 시
            reviewsTableView.isHidden = true
            detailScrollView.isHidden = false
            floatingActionButton.isHidden = true // 상세정보 탭에서는 항상 버튼 숨김
        }
    }


    // UITableViewDataSource 메서드
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewTableViewCell", for: indexPath) as? ReviewTableViewCell else {
            return UITableViewCell()
        }

        let review = reviews[indexPath.row]
        let timeString = convertDateToString(review.createdAt) // 리뷰 작성 시간을 문자열로 변환

        // 현재 접속 중인 사용자의 ID를 가져옵니다. (Firebase Auth 사용 시)
            guard let currentUserID = Auth.auth().currentUser?.uid else {
                print("Current user ID not available")
                return cell
            }

        let isLikedByCurrentUser = review.likes[currentUserID] ?? false

        // '좋아요' 상태에 따른 이미지 설정
           let likeImageName = isLikedByCurrentUser ? "streamline_interface-edit-view-eye-eyeball-open-view 4" : "streamline_interface-edit-view-eye-eyeball-open-view 3"
           let likeImage = UIImage(named: likeImageName)


        // 셀에 리뷰 정보를 설정합니다.
        cell.setReview(nikeName: review.nickname, 
                       content: review.content,
                       profileImageUrl: review.profileImageUrl,
                       nickname: convertDateToString(review.createdAt),
                       newTitle: review.title, 
                       extraImageView1: likeImage,
                       extraImageView2: UIImage(named: ""),
                       text123: "\(review.likesNum)", // 'text123'에 좋아요 수 표시
                       text456: "")


        // SDWebImage를 사용하여 프로필 이미지 캐시 및 로드
         if let profileImageUrl = URL(string: review.profileImageUrl) {
             cell.profileImageView.sd_setImage(with: profileImageUrl, placeholderImage: UIImage(named: "defaultProfileImage"), completed: { (image, error, cacheType, url) in
                 if cacheType == .none {
                     print("Profile Image was downloaded and cached: \(url?.absoluteString ?? "Unknown URL")")
                 } else {
                     print("Profile Image was retrieved from cache")
                 }
             })
         }

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
        detailViewController.userReviewUUID = selectedReview.userReviewUUID // UUID를 전달합니다.


        // 여기에 posterName 값을 추가합니다.
            detailViewController.posterName = self.posterImageName
        print("detailViewController.posterName의 정보 \(String(describing: detailViewController.posterName))")

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

// DetailViewController.swift
extension DetailViewController {
    func showCustomAlert(title: String, message: String) {
        let customAlertVC = CustomAlertViewController()
        customAlertVC.configure(title: title, message: message)
        customAlertVC.modalPresentationStyle = .overFullScreen
        present(customAlertVC, animated: false, completion: nil)
    }
}




import SnapKit

import SnapKit

class CustomAlertView: UIView {
    var titleLabel = UILabel()
    var messageLabel = UILabel()
    var closeButton = UIButton()


    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        backgroundColor = UIColor(red: 0.153, green: 0.157, blue: 0.165, alpha: 1)
        layer.cornerRadius = 20

        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "Pretendard-SemiBold", size: 21)
        titleLabel.textColor = UIColor(red: 0.875, green: 0.871, blue: 0.886, alpha: 1)

        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "Pretendard-Medium", size: 16)
        messageLabel.textColor = UIColor(red: 0.757, green: 0.753, blue: 0.773, alpha: 1)
        messageLabel.numberOfLines = 0

        addSubview(titleLabel)
        addSubview(messageLabel)

        setupConstraints()

        // 닫기 버튼 설정
                closeButton.setTitle("닫기", for: .normal)
                closeButton.backgroundColor = UIColor(red: 0.224, green: 0.231, blue: 0.243, alpha: 1)
                closeButton.layer.cornerRadius = 20 // 모서리 둥글게
                closeButton.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 15)
                closeButton.setTitleColor(UIColor(red: 0.745, green: 0.741, blue: 0.761, alpha: 1), for: .normal) // 버튼 텍스트 색상
                closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)

                addSubview(closeButton)

                setupCloseButtonConstraints()
    }

    @objc private func closeButtonTapped() {
          // 버튼 탭 이벤트 처리. 실제로 얼럿을 닫는 동작은 CustomAlertViewController에서 구현합니다.
      }

    private func setupCloseButtonConstraints() {
            closeButton.snp.makeConstraints { make in
                make.top.equalTo(messageLabel.snp.bottom).offset(20)
                make.centerX.equalToSuperview()
                make.width.equalTo(100)
                make.height.equalTo(40)
                make.bottom.greaterThanOrEqualToSuperview().offset(-20)
            }
        }


    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }

        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
//            make.bottom.greaterThanOrEqualToSuperview().offset(-20)
        }
    }

    func configure(title: String, message: String) {
         titleLabel.text = title
         messageLabel.text = message

         // 내용에 따라 크기를 조정하기 위해 레이아웃을 업데이트합니다.
         layoutIfNeeded()

         // 내용에 맞게 얼럿 창의 크기를 조정합니다.
         adjustSizeToFitContent()
     }

     private func adjustSizeToFitContent() {
         // 내용에 따라 얼럿 창의 크기를 재계산합니다.
         let targetSize = CGSize(width: 250, height: UIView.layoutFittingCompressedSize.height)
         let fittingSize = systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
         frame.size = CGSize(width: 250, height: fittingSize.height)
     }
}

// CustomAlertViewController.swift
import UIKit

class CustomAlertViewController: UIViewController {
    var titleLabelText: String?
    var messageText: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        let blurEffect = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = self.view.bounds
        view.addSubview(blurView)

        let alertView = CustomAlertView()
               alertView.configure(title: titleLabelText ?? "", message: messageText ?? "")
               alertView.closeButton.addTarget(self, action: #selector(dismissAlert), for: .touchUpInside)
        alertView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(alertView)

        NSLayoutConstraint.activate([
            alertView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            alertView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            alertView.widthAnchor.constraint(equalToConstant: 250)
        ])
    }

    @objc private func dismissAlert() {
          dismiss(animated: false, completion: nil)
      }

    func configure(title: String, message: String) {
        titleLabelText = title
        messageText = message
    }
}
