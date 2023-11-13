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
        segmentControl.selectedSegmentTintColor = UIColor.white // 선택된 아이템의 배경색 설정

        // 텍스트 색상 변경을 위한 설정
        let normalTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        let selectedTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.darkGray]

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
            make.leading.equalTo(view.snp.leading).offset(50)
            make.trailing.equalTo(view.snp.trailing).offset(-50)
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
        // 스크롤 뷰 초기화
        detailScrollView = UIScrollView()
        detailScrollView.backgroundColor = .black // 배경색 설정
        view.addSubview(detailScrollView)
        detailScrollView.isHidden = true // 초기 상태는 숨겨져 있음

        // 스크롤 뷰에 들어갈 컨텐츠 뷰 초기화
        detailContentView = UIView()
        detailScrollView.addSubview(detailContentView)

        // 개별 사각형 뷰를 생성하고 detailContentView에 추가합니다.
        let squareView1 = UIView()
        squareView1.backgroundColor = .darkGray
        squareView1.layer.cornerRadius = 10
        squareView1.clipsToBounds = true
        let imageView1 = UIImageView(image: UIImage(named: "calenderE"))
        imageView1.contentMode = .scaleAspectFill
        squareView1.addSubview(imageView1)
        detailContentView.addSubview(squareView1)
        imageView1.snp.makeConstraints { make in
            make.center.equalTo(squareView1) // 사각형 뷰의 중앙에 배치
            make.width.height.lessThanOrEqualTo(squareView1).multipliedBy(0.8) // 사각형 뷰 크기의 80%를 최대 크기로 설정
        }


        let squareView2 = UIView()
        squareView2.backgroundColor = .darkGray
        squareView2.layer.cornerRadius = 10
        squareView2.clipsToBounds = true
        let imageView2 = UIImageView(image: UIImage(named: "Group 50"))
        imageView2.contentMode = .scaleAspectFill
        squareView2.addSubview(imageView2)
        detailContentView.addSubview(squareView2)
        imageView2.snp.makeConstraints { make in
            make.center.equalTo(squareView2) // 사각형 뷰의 중앙에 배치
            make.width.height.lessThanOrEqualTo(squareView2).multipliedBy(0.8) // 사각형 뷰 크기의 80%를 최대 크기로 설정
        }

        let squareView3 = UIView()
        squareView3.backgroundColor = .darkGray
        squareView3.layer.cornerRadius = 10
        squareView3.clipsToBounds = true
        let imageView3 = UIImageView(image: UIImage(named: "Group 48"))
        imageView3.contentMode = .scaleAspectFill
        squareView3.addSubview(imageView3)
        detailContentView.addSubview(squareView3)
        // 이미지 뷰의 제약 조건 설정
        imageView3.snp.makeConstraints { make in
            make.center.equalTo(squareView3) // 사각형 뷰의 중앙에 배치
            make.width.height.lessThanOrEqualTo(squareView3).multipliedBy(0.8) // 사각형 뷰 크기의 80%를 최대 크기로 설정
        }

        let squareView4 = UIView()
        squareView4.backgroundColor = .darkGray
        squareView4.layer.cornerRadius = 10
        squareView4.clipsToBounds = true
        let imageView4 = UIImageView(image: UIImage(named: "Union 1"))
        imageView4.contentMode = .scaleAspectFill
        squareView4.addSubview(imageView4)
        detailContentView.addSubview(squareView4)
        // 이미지 뷰의 제약 조건 설정
        imageView4.snp.makeConstraints { make in
            make.center.equalTo(squareView4) // 사각형 뷰의 중앙에 배치
            make.width.height.lessThanOrEqualTo(squareView4).multipliedBy(0.8) // 사각형 뷰 크기의 80%를 최대 크기로 설정
        }

        let squareView5 = UIView()
        squareView5.backgroundColor = .darkGray
        squareView5.layer.cornerRadius = 10
        squareView5.clipsToBounds = true
        let imageView5 = UIImageView(image: UIImage(named: "Group 125"))
        imageView5.contentMode = .scaleAspectFill
        squareView5.addSubview(imageView5)
        detailContentView.addSubview(squareView5)
        // 이미지 뷰의 제약 조건 설정
        imageView5.snp.makeConstraints { make in
            make.center.equalTo(squareView5) // 사각형 뷰의 중앙에 배치
            make.width.height.lessThanOrEqualTo(squareView5).multipliedBy(0.8) // 사각형 뷰 크기의 80%를 최대 크기로 설정
        }

        // 스택뷰 초기화 및 설정
        let stackView = UIStackView(arrangedSubviews: [squareView1, squareView2, squareView3, squareView4, squareView5])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 13
        stackView.alignment = .center

        detailContentView.addSubview(stackView)



        // 전시 제목 레이블 초기화
        let exhibitionTitleLabel = UILabel()
        exhibitionTitleLabel.text = "갤러리바톤"
        exhibitionTitleLabel.textColor = .white
        exhibitionTitleLabel.font = UIFont.boldSystemFont(ofSize: 22)

        // 미술관 주소 레이블 초기화
        let galleryAddressLabel = UILabel()
        galleryAddressLabel.text = "서울 종로구 삼청로 30"
        galleryAddressLabel.textColor = .white
        galleryAddressLabel.font = UIFont.systemFont(ofSize: 18)

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
            make.top.equalTo(detailContentView.snp.top).offset(20) // 상단 여백
            make.leading.equalTo(detailContentView.snp.leading).offset(20) // 좌측 여백
        }

        // 미술관 주소 레이블 레이아웃 설정
        galleryAddressLabel.snp.makeConstraints { make in
            make.top.equalTo(exhibitionTitleLabel.snp.bottom).offset(8) // 전시 제목 레이블 아래 간격
            make.leading.equalTo(exhibitionTitleLabel.snp.leading) // 좌측 정렬
        }

        // 스택뷰의 제약 조건 설정
        stackView.snp.makeConstraints { make in
            make.top.equalTo(mapView.snp.bottom).offset(20)
            make.left.right.equalTo(detailContentView).inset(16)
            make.height.equalTo(stackView.snp.width).dividedBy(5 + (4 * stackView.spacing / view.frame.size.width)) // 여백을 고려한 높이 설정
        }


        // contentView의 bottom constraint를 마지막 사각형 뷰에 맞춰 설정합니다.
        detailContentView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(detailScrollView) // 스크롤 뷰에 맞춤
            make.width.equalTo(detailScrollView) // contentView의 너비를 스크롤 뷰의 너비와 동일하게 설정
        }

        // 사각형 뷰들을 스택뷰에 추가하기 전에 제약 조건을 설정합니다.
        let squareViews = [squareView1, squareView2, squareView3, squareView4, squareView5]
        for squareView in squareViews {
            squareView.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(squareView)

            // 정사각형 뷰의 너비와 높이 제약 조건을 설정합니다.
            squareView.snp.makeConstraints { make in
                make.width.height.equalTo(60) // 또는 특정 비율에 따른 제약 조건으로 변경 가능
            }
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
