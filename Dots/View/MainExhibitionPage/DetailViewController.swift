//
//  DetailViewController.swift
//  Dots
//
//  Created by cheshire on 11/13/23.
//

import Foundation

import MapKit // MapKit 프레임워크를 임포트합니다.


class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let segmentControl = UISegmentedControl(items: ["후기", "상세정보"])
    var reviewsTableView = UITableView()
    var reviews: [String] = [] // 후기 데이터 배열
    // 새로운 스크롤 뷰 프로퍼티 추가
    var detailScrollView: UIScrollView!
    var detailContentView: UIView!

    var mapView: MKMapView! // MKMapView 프로퍼티 추가


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        isModalInPresentation = true

        // 세그먼트 컨트롤 설정
        configureSegmentControl()

        // 테이블 뷰 설정
        configureTableView()
        loadSampleReviews()

        configureDetailScrollView()

    }

    func configureSegmentControl() {

        // 타이틀 레이블을 설정합니다.
        let titleLabel = UILabel()
        titleLabel.text = "현대차 시리즈 2023: 정연두 - 백년여행"
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 16)
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

        // SnapKit을 사용하여 레이아웃을 적용합니다.
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.centerX.equalTo(view.snp.centerX)
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


        reviewsTableView.separatorStyle = .none  // 셀 사이의 구분선을 없애고 싶다면 이 속성을 설정합니다.

        // 테이블 뷰에 대한 SnapKit 레이아웃 설정
        reviewsTableView.snp.makeConstraints { make in
            make.top.equalTo(segmentControl.snp.bottom).offset(10)
            make.left.right.equalTo(view) // 여기에서 양쪽에 20포인트의 inset을 추가합니다.
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
        let exhibitionTitleLabel = UILabel()
        exhibitionTitleLabel.text = "갤러리바톤"
        exhibitionTitleLabel.textColor = .white
        exhibitionTitleLabel.font = UIFont.boldSystemFont(ofSize: 22)

        // 미술관 주소 레이블 초기화
        let galleryAddressLabel = UILabel()
        galleryAddressLabel.text = "서울 종로구 삼청로 30"
        galleryAddressLabel.textColor = .white
        galleryAddressLabel.font = UIFont.systemFont(ofSize: 16)

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


        // contentView의 bottom constraint를 마지막 사각형 뷰에 맞춰 설정합니다.
        detailContentView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(detailScrollView) // 스크롤 뷰에 맞춤
            make.width.equalTo(detailScrollView) // contentView의 너비를 스크롤 뷰의 너비와 동일하게 설정
        }

        // 스택 뷰 생성 및 구성
          let squaresStackView = UIStackView()
        squaresStackView.axis = .horizontal
        squaresStackView.distribution = .fillEqually
        squaresStackView.alignment = .fill
        squaresStackView.spacing = 10 // 또는 원하는 간격

        let labelContents = ["23.11.10 - 24.02.12", "09:00 - 17:00", "2,000원", "16점", "김구림 외 3명"]
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
                make.height.equalTo(150) // 설정된 높이
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
            label.font = UIFont.systemFont(ofSize: 14)
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



    }


    @objc func segmentChanged(_ sender: UISegmentedControl) {
        reviewsTableView.isHidden = sender.selectedSegmentIndex != 0
        detailScrollView.isHidden = sender.selectedSegmentIndex != 1
        // 상세 정보 뷰의 표시 상태를 업데이트하는 코드를 여기에 추가합니다.
    }

    // UITableViewDataSource 메서드
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count // 후기 배열의 길이 반환
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

import SwiftUI

// SwiftUI에서 UIKit 뷰 컨트롤러를 표현할 수 있게 해주는 구조체를 정의합니다.
struct DetailViewControllerPreview: UIViewControllerRepresentable {
    // UIViewControllerRepresentable 프로토콜을 준수하기 위한 메서드를 구현합니다.
    func makeUIViewController(context: Context) -> DetailViewController {
        // 여기서 DetailViewController의 인스턴스를 생성하고 설정합니다.
        return DetailViewController()
    }

    func updateUIViewController(_ uiViewController: DetailViewController, context: Context) {
        // 뷰 컨트롤러를 업데이트할 때 필요한 코드를 여기에 작성합니다.
        // 프리뷰에서는 일반적으로 필요하지 않습니다.
    }
}

// Xcode 프리뷰를 위한 구조체를 정의합니다.
struct DetailViewControllerPreview_Previews: PreviewProvider {
    static var previews: some View {
        DetailViewControllerPreview().edgesIgnoringSafeArea(.all) // 모든 안전 영역을 무시하고 뷰를 확장합니다.
    }
}
