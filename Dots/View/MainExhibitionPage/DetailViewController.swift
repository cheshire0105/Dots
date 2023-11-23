//
//  DetailViewController.swift
//  Dots
//
//  Created by cheshire on 11/13/23.
//  [최신화] : 2023년 11월 23일
//  새 브랜치 생성 - 2023년 11월 23일

import Foundation

import MapKit // MapKit 프레임워크를 임포트합니다.
import Firebase

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let segmentControl = UISegmentedControl(items: ["후기", "상세정보"])
    var reviewsTableView = UITableView()
    var reviews: [String] = []
    var detailScrollView: UIScrollView!
    var detailContentView: UIView!
    let floatingActionButton = UIButton(type: .custom)
    
    var posterImageName: String?

    let titleLabel = UILabel()
    let exhibitionTitleLabel = UILabel()

    let galleryAddressLabel = UILabel()

    var labelContents = ["23.11.10 - 24.02.12", "09:00 - 17:00", "2,000원", "16점", "김구림 외 3명"]

    var mapView: MKMapView!
    let squaresStackView = UIStackView()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        isModalInPresentation = true
        configureSegmentControl()
        configureTableView()
        loadSampleReviews()

        configureDetailScrollView()
        configureFloatingActionButton()
        fetchExhibitionDetails() // Firestore에서 전시 상세 정보를 가져오는 함수 호출


    }

    // UI를 전시 상세 정보로 업데이트하는 함수
    private func updateUIWithExhibitionDetails(_ exhibitionDetail: ExhibitionDetailModel) {
        DispatchQueue.main.async {
            // titleLabel에 전시 타이틀을 설정
            self.titleLabel.text = exhibitionDetail.exhibitionTitle

            // exhibitionTitleLabel에 미술관 이름을 설정
            self.exhibitionTitleLabel.text = exhibitionDetail.museumName
            self.galleryAddressLabel.text = exhibitionDetail.museumAddress

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
      private func fetchExhibitionDetails() {
          guard let posterName = posterImageName else { return }
          let documentRef = Firestore.firestore().collection("전시_상세").document(posterName)
          documentRef.getDocument { [weak self] (document, error) in
              if let document = document, document.exists {
                  let data = document.data()
                  let exhibitionDetail = ExhibitionDetailModel(dictionary: data ?? [:])
                  self?.updateUIWithExhibitionDetails(exhibitionDetail)
              } else {
                  print("Document does not exist or error fetching document: \(error?.localizedDescription ?? "")")
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
        let navController = UINavigationController(rootViewController: reviewWriteVC) // UINavigationController를 생성하고 rootViewController로 설정합니다.
        navController.modalPresentationStyle = .fullScreen // 전체 화면으로 설정
        self.present(navController, animated: true, completion: nil) // UINavigationController를 모달로 표시합니다.
    }






    func configureSegmentControl() {

        // 타이틀 레이블을 설정합니다.
        titleLabel.text = "현대차 시리즈 2023: 정연두 - 백년여행"
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 2
        titleLabel.font = UIFont(name: "Pretendard-Bold", size: 20)
        view.addSubview(titleLabel)

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

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.centerX.equalTo(view.snp.centerX)
            make.left.right.equalToSuperview().inset(20)
        }

        segmentControl.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
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
        galleryAddressLabel.font = UIFont(name: "Pretendard-Medium", size: 16)

        // 컨텐츠 뷰에 레이블 추가
        detailContentView.addSubview(exhibitionTitleLabel)
        detailContentView.addSubview(galleryAddressLabel)

        mapView = MKMapView()
        detailContentView.addSubview(mapView)
        // 지도 뷰 모서리 둥글게 설정
        mapView.layer.cornerRadius = 10
        mapView.clipsToBounds = true

        // 지도 뷰 제약 조건 설정
        mapView.snp.makeConstraints { make in
            make.top.equalTo(detailContentView.snp.top).offset(20)
            make.right.equalTo(detailContentView.snp.right).offset(-18)
            make.width.equalTo(130) // 지도 뷰의 너비를 지정합니다.
            make.height.equalTo(mapView.snp.width).multipliedBy(0.6) // 지도의 높이를 너비의 0.6배로 설정합니다.
        }

        // 지도 위치 설정
        let coordinate = CLLocationCoordinate2D(latitude: 37.582691, longitude: 127.00175) // 갤러리바톤의 위치 좌표로 가정
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        mapView.setRegion(region, animated: true)

        // 지도에 핀 추가
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        pin.title = "갤러리바톤"
        mapView.addAnnotation(pin)

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
        let additionalInfoLabel = UILabel()
        additionalInfoLabel.text = """
«김구림»은 실험미술의 선구자인 김구림의 예술 세계를 조명하는 개인전이다. 이번 전시는 1950년대부터 현재까지 다양한 매체, 장르, 주제를 넘나들며 예술의 최전선에서 독자적인 영역을 구축해 온 작가의 전위적인 면모를 확인할 수 있다. 비디오 아트, 설치, 판화, 퍼포먼스, 회화 등 미술의 범주를 넘어 무용, 연극, 영화, 음악에 이르기까지 다양한 분야에서 활발한 활동을 펼쳐 온 작가를 입체적으로 만나볼 수 있는 자리이기도 하다. 한국 현대미술사에서 중요한 위치를 차지하는 작가임에도 불구하고 김구림의 작품을 설명하거나 깊이 있게 경험할 기회는 충분치 않았기에 이번 전시를 통해 김구림의 미술사적 성과를 재확인하고, 현재진행형 작가로서 오늘날 그의 행보를 살펴보고자 한다. 전시는 1960년대 초 한국전쟁 이후 실존적인 문제에 매달리며 제작한 초기 회화, 1960-70년대 한국 실험미술의 중심에서 발표했던 퍼포먼스와 설치, 1980년대 중반부터 지속하는 <음과 양> 시리즈 등을 고루 소개한다. 또한 김구림 작가의 동시대적 면모를 확인할 수 있는 대형 설치와 함께 영화-무용-음악-연극을 한데 모은 공연을 새롭게 선보인다. 1950년대부터 이어진 김구림의 전방위적 활동과 거침없는 도전은 시대에 대한 반응이었고, 관습에 대한 저항이었던 바 그와 다른 시간대를 영위하는 이들이 단숨에 파악하기에는 어려운 낯선 영역일 것이다. 따라서 이번 전시는 부분적으로 밖에 파악할 수밖에 없었던 김구림의 세계를 최대한 온전하게 전달하는 데 초점을 두었다. 김구림과 함께 그의 결정적 순간들을 재방문해 보길 바라며, 김구림의 발자취를 경유하는 가운데 한국 미술사에 대한 이해의 폭을 넓히는 기회가 되길 바란다.
"""
        additionalInfoLabel.textColor = .white
        additionalInfoLabel.font = UIFont(name: "Pretendard-Regular", size: 14)
        additionalInfoLabel.numberOfLines = 0 // 제한 없이 여러 줄 표시 가능

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

        // 리뷰 제목, 내용, 프로필 이미지, 닉네임 설정
        let reviewTitle = "리뷰 제목" // 임시 제목
        let reviewContent = reviews[indexPath.row] // 실제 리뷰 내용
        let profileImage = UIImage(named: "morningStar") // 기본 이미지 or 실제 이미지 이름
        let nickname = "닉네임" // 임시 닉네임

        // 셀에 정보를 설정하는 부분
        cell.setReview(title: reviewTitle, content: reviewContent, profileImage: profileImage, nickname: nickname)



        return cell
    }

    // UITableViewDelegate 메서드
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension // 자동으로 셀의 높이를 계산합니다.
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100 // 추정 높이를 설정합니다. 셀의 내용에 따라 실제 높이는 달라질 수 있습니다.
    }



    private func loadSampleReviews() {
        reviews = ["이번 한국 명화 전시는 정말 감동적이었습니다. 작품들은 아름다운 색채와 섬세한 선으로 구성되어 있어 예술의 아름다움을 느낄 수 있었습니다.", "다시 방문하고 싶어요.", "추천합니다!", "생각보다 별로였어요.", "인상적인 작품이 많았습니다.", "전시장은 조용하고 아름다웠고, 명화들은 고요한 분위기를 자아냈습니다. 화가들의 정성이 느껴지는 작품들을 감상하면서 시간이 흘렀습니다.", "작품 설명이 잘 되어 있어서 좋았습니다.", "아이와 같이 가기 좋은 전시였어요.", "주차 공간이 넉넉해서 좋았어요.","정말 좋았어요!", "멋진 전시였습니다.", "다시 방문하고 싶어요.", "추천합니다!", "생각보다 별로였어요.", "전시를 통해 한국의 아름다운 풍경과 역사를 더 깊이 이해할 수 있었습니다. 명화들은 과거와 현재의 연결고리가 된 느낌이었습니다.", "전시가 너무 혼잡했어요.", "작품 설명이 잘 되어 있어서 좋았습니다. 작품 설명이 잘 되어 있어서 좋았습니다. 작품 설명이 잘 되어 있어서 좋았습니다. 작품 설명이 잘 되어 있어서 좋았습니다.", "아이와 같이 가기 좋은 전시였어요.", "주차 공간이 넉넉해서 좋았어요."]
        reviewsTableView.reloadData()
    }

}

