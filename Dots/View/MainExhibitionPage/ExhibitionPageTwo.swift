//
//  ExhibitionPageTwo.swift
//  Dots
//
//  Created by cheshire on 11/10/23.
//

import Foundation
import UIKit
import SnapKit
import UIKit

class BackgroundImageViewController: UIViewController, UIGestureRecognizerDelegate {

    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "loginBack"), for: .normal) // 버튼의 기본 상태 이미지를 설정합니다.
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside) // 버튼 액션 추가
        return button
    }()

    lazy var headsetIcon: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "headset help_"), for: .normal) // 버튼의 기본 상태 이미지를 설정합니다.
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside) // 버튼 액션 추가
        return button
    }()
    lazy var heartIcon: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "heartIcon"), for: .normal) // 버튼의 기본 상태 이미지를 설정합니다.
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside) // 버튼 액션 추가
        return button
    }()

    override func viewWillAppear(_ animated: Bool) {
        if let glassTabBar = tabBarController as? GlassTabBar {
            glassTabBar.customTabBarView.isHidden = true
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)

        presentModalViewController() // 뷰가 나타날 때 모달을 바로 표시합니다.
    }


    override func viewDidLoad() {

        view.backgroundColor = .black

        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        super.viewDidLoad()
        // 배경으로 사용할 이미지 뷰를 설정합니다.
        let backgroundImageView = UIImageView(frame: self.view.bounds)
        backgroundImageView.image = UIImage(named: "ExhibitionPageBack")
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
        self.view.addSubview(backgroundImageView)

        setupBackButton() // 백 버튼 설정 메서드 호출

    }

    private func setupBackButton() {
        view.addSubview(backButton) // 백 버튼을 뷰에 추가합니다.
        view.addSubview(headsetIcon) // 백 버튼을 뷰에 추가합니다.
        view.addSubview(heartIcon)

        backButton.snp.makeConstraints { make in // SnapKit을 사용하여 제약 조건 설정
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10) // 상단 safe area로부터 10포인트 아래에 위치
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(10) // leading edge로부터 10포인트 떨어진 곳에 위치
            make.width.height.equalTo(40) // 너비와 높이는 40포인트로 설정
        }


        heartIcon.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-10)
            make.width.height.equalTo(40)
        }

        headsetIcon.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.trailing.equalTo(heartIcon.snp.leading).offset(-10)
            make.width.height.equalTo(40)
        }
    }

    @objc func backButtonTapped() {
        // 여기에 뒤로 가기 버튼을 눌렀을 때의 동작을 구현하세요.
        navigationController?.popViewController(animated: true) // 네비게이션 컨트롤러를 사용하는 경우
    }

    @objc func presentModalViewController() {
        // 상세 내용을 담은 뷰 컨트롤러를 생성하고 모달로 표시합니다.
        let detailViewController = DetailViewController()
        presentDetailViewController(detailViewController)
    }

    private func presentDetailViewController(_ detailViewController: DetailViewController) {
        if let sheetController = detailViewController.presentationController as? UISheetPresentationController {
            // 사용자 정의 detent 생성
            let detentIdentifier = UISheetPresentationController.Detent.Identifier("customDetent")
            let customDetent = UISheetPresentationController.Detent.custom(identifier: detentIdentifier) { _ in
                // safe area bottom을 구하기 위한 선언.
                let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                let safeAreaBottom = windowScene?.windows.first?.safeAreaInsets.bottom ?? 0


                // 모든 기기에서 항상 높이가 700인 detent를 만들어낼 수 있다.
                return 700 - safeAreaBottom
            }



            // 중간 높이와 사용자 정의 높이를 포함하는 detent 설정
            sheetController.detents = [.medium(), customDetent]
            sheetController.largestUndimmedDetentIdentifier = detentIdentifier // 최대 높이를 커스텀 detent로 설정합니다.
            sheetController.prefersScrollingExpandsWhenScrolledToEdge = true // 스크롤할 때 시트가 확장되도록 설정합니다.
            sheetController.preferredCornerRadius = 30 // 둥근 모서리 설정을 유지합니다.


        }

        // 모달 표시 설정
        detailViewController.modalPresentationStyle = .pageSheet
        self.present(detailViewController, animated: true, completion: nil)
    }


}

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
        detailScrollView.backgroundColor = .gray // 배경색 설정
        view.addSubview(detailScrollView)
        detailScrollView.isHidden = true // 초기 상태는 숨겨져 있음

        // 스크롤 뷰에 들어갈 컨텐츠 뷰 초기화
        detailContentView = UIView()
        detailScrollView.addSubview(detailContentView)

        // 개별 사각형 뷰를 생성하고 detailContentView에 추가합니다.
        let squareView1 = UIView()
        squareView1.backgroundColor = .lightGray
        detailContentView.addSubview(squareView1)

        let squareView2 = UIView()
        squareView2.backgroundColor = .lightGray
        detailContentView.addSubview(squareView2)

        let squareView3 = UIView()
        squareView3.backgroundColor = .lightGray
        detailContentView.addSubview(squareView3)

        let squareView4 = UIView()
        squareView4.backgroundColor = .lightGray
        detailContentView.addSubview(squareView4)

        let squareView5 = UIView()
        squareView5.backgroundColor = .lightGray
        detailContentView.addSubview(squareView5)

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
            make.top.equalTo(detailContentView.snp.top).offset(20) // 상단 여백
            make.trailing.equalTo(detailContentView.snp.trailing).inset(10) // 여기를 조정하여 오른쪽 여백을 설정
            make.width.equalTo(130)
            make.height.equalTo(80)
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
        detailScrollView.snp.makeConstraints { make in
            make.top.equalTo(segmentControl.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }



        // 전시 제목 레이블 레이아웃 설정
        exhibitionTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(detailContentView.snp.top).offset(20) // 상단 여백
            make.leading.equalTo(detailContentView.snp.leading).offset(20) // 좌측 여백
            //               make.trailing.equalTo(detailContentView.snp.trailing).offset(-20) // 우측 여백
        }

        // 미술관 주소 레이블 레이아웃 설정
        galleryAddressLabel.snp.makeConstraints { make in
            make.top.equalTo(exhibitionTitleLabel.snp.bottom).offset(8) // 전시 제목 레이블 아래 간격
            make.leading.equalTo(exhibitionTitleLabel.snp.leading) // 좌측 정렬
            //            make.right.lessThanOrEqualTo(mapView.snp.left).offset(-40) // 지도 뷰와의 간격을 설정
        }


        // 각 사각형 뷰의 제약 조건을 설정합니다.
        squareView1.snp.makeConstraints { make in
            make.top.equalTo(mapView.snp.bottom).offset(20)
            make.leading.equalTo(detailContentView.snp.leading).offset(20)
            make.width.height.equalTo(60)
        }

        squareView2.snp.makeConstraints { make in
            make.top.width.height.equalTo(squareView1)
            make.leading.equalTo(squareView1.snp.trailing).offset(13)
        }

        squareView3.snp.makeConstraints { make in
            make.top.width.height.equalTo(squareView1)
            make.leading.equalTo(squareView2.snp.trailing).offset(13)
        }

        squareView4.snp.makeConstraints { make in
            make.top.width.height.equalTo(squareView1)
            make.leading.equalTo(squareView3.snp.trailing).offset(13)
        }

        squareView5.snp.makeConstraints { make in
            make.top.width.height.equalTo(squareView1)
            make.leading.equalTo(squareView4.snp.trailing).offset(13)
            make.trailing.lessThanOrEqualTo(detailContentView.snp.trailing).offset(-20)
        }

        // 컨텐츠 뷰의 높이를 내부 컨텐츠에 맞게 조정합니다.
        detailContentView.snp.makeConstraints { make in
            make.bottom.equalTo(squareView1.snp.bottom).offset(20)
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

class 새로운_ReviewTableViewCell: UITableViewCell {

    // UI 컴포넌트 선언
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()

    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        label.numberOfLines = 0 // 멀티라인을 허용합니다.
        return label
    }()

    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var nicknameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        return label
    }()

    private let container = UIView()


    // 초기화 메서드
    // 초기화 메서드
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        // 컨테이너 뷰 설정
        container.backgroundColor = .darkGray
        container.layer.cornerRadius = 10
        container.clipsToBounds = true

        contentView.backgroundColor = .black
        selectionStyle = .none

        // 컨테이너 뷰를 contentView에 추가합니다.
        contentView.addSubview(container)

        // 모든 서브뷰를 컨테이너 뷰에 추가합니다.
        container.addSubview(titleLabel)
        container.addSubview(contentLabel)
        container.addSubview(profileImageView)
        container.addSubview(nicknameLabel)

        // 컨테이너 뷰에 대한 제약조건을 설정합니다.
        container.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(10) // 상단에 10포인트의 여백을 추가합니다.
            make.bottom.equalTo(contentView.snp.bottom).offset(-10) // 하단에 10포인트의 여백을 추가합니다.
            make.left.equalTo(contentView.snp.left).offset(10) // 좌측에 10포인트의 여백을 추가합니다.
            make.right.equalTo(contentView.snp.right).offset(-10) // 우측에 10포인트의 여백을 추가합니다.
        }

        // 다른 UI 컴포넌트들의 레이아웃 설정을 업데이트합니다. (titleLabel, contentLabel, profileImageView, nicknameLabel 제약조건은 container 기준으로 업데이트합니다)
        setupLayout()
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // 레이아웃 설정 메서드
    private func setupLayout() {

        // 제목 레이블의 레이아웃 설정
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10) // 상단 여백 설정
            make.left.equalToSuperview().offset(10) // 좌측 여백 설정
            make.right.equalToSuperview().offset(-10) // 우측 여백 설정
        }

        // 내용 레이블의 레이아웃 설정
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5) // 제목 레이블 아래 간격을 둡니다.
            make.left.right.equalTo(titleLabel)
        }

        // 프로필 이미지 뷰의 레이아웃 설정
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(10) // 내용 레이블 아래로 간격을 둡니다.
            make.left.equalToSuperview().offset(10) // 좌측 여백 설정
            make.width.height.equalTo(30) // 이미지 크기를 30x30으로 설정
            make.bottom.lessThanOrEqualToSuperview().offset(-10) // 셀 하단 여백 설정
        }

        // 닉네임 레이블의 레이아웃 설정
        nicknameLabel.snp.makeConstraints { make in
            make.left.equalTo(profileImageView.snp.right).offset(10) // 프로필 이미지 오른쪽에 위치
            make.centerY.equalTo(profileImageView.snp.centerY) // 프로필 이미지와 중앙 정렬
            make.right.lessThanOrEqualToSuperview().offset(-10) // 우측 여백 설정, 내용이 길어질 경우를 대비하여 lessThanOrEqualTo를 사용
        }
    }

    // 셀에 리뷰 정보를 설정하는 메서드
    func setReview(title: String, content: String, profileImage: UIImage?, nickname: String) {
        titleLabel.text = title
        contentLabel.text = content
        profileImageView.image = profileImage
        nicknameLabel.text = nickname
    }
}
