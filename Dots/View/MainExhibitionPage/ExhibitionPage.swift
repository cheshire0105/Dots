////
////  ExhibitionPage.swift
////  Dots
////
////  Created by cheshire on 10/27/23.
////
//// pull from master branch
//import UIKit
//import SnapKit
//
//class ExhibitionPage: UIViewController, UIScrollViewDelegate, UIGestureRecognizerDelegate, UITableViewDelegate, UITableViewDataSource {
//
//    // MARK: - 변수
//
//    let scrollView = UIScrollView()
//    let contentView = UIView()
//
//    let exhibitionImageView = UIImageView()
//    let titleLabel = UILabel()
//    let galleryButtonLabel = UILabel()
//
//    let iconImageView = UIImageView()
//    let descriptionLabel = UILabel()
//    let stackView = UIStackView()
//
//    let iconImageViewTwo = UIImageView()
//    let descriptionLabelTwo = UILabel()
//    let stackViewTwo = UIStackView()
//
//    let reviewView = UIView()
//    let exhibitionInformationView = UIView()
//
//    let tableView = UITableView()
//
//    let reviewsButton = UIButton()
//    let exhibitionInfoButton = UIButton()
//    let borderView = UIView()
//    let reviewsButtonBorder = UIView()
//    let exhibitionInfoButtonBorder = UIView()
//
//    var reviewTableViewHeightConstraint: Constraint?
//    var exhibitionInfoViewHeightConstraint: Constraint?
//
//    let exhibitionInfoTextView = UILabel()
//    let museumHomepageButton = UIButton(type: .system)
//
//    // 더미 데이터
//    let reviews = [
//        Review(title: "훌륭한 전시회였어요!", content: "정말 재미있게 관람했습니다. 다음에 또 오고 싶어요.", author: "홍길동", imageName: "morningStar"),
//        Review(title: "추천합니다", content: "전시회 분위기가 너무 좋았고 작품들도 인상적이었습니다.", author: "김영희", imageName: "morningStar"),
//        Review(title: "추천합니다", content: "전시회 분위기가 너무 좋았고 작품들도 인상적이었습니다.", author: "김영희", imageName: "morningStar"),
//        Review(title: "추천합니다", content: "전시회 분위기가 너무 좋았고 작품들도 인상적이었습니다.", author: "김영희", imageName: "morningStar"),
//        Review(title: "추천합니다", content: "전시회 분위기가 너무 좋았고 작품들도 인상적이었습니다.", author: "김영희", imageName: "morningStar"),
//        Review(title: "추천합니다", content: "전시회 분위기가 너무 좋았고 작품들도 인상적이었습니다.", author: "김영희", imageName: "morningStar"),
//        Review(title: "추천합니다", content: "전시회 분위기가 너무 좋았고 작품들도 인상적이었습니다.", author: "김영희", imageName: "morningStar"),
//        Review(title: "추천합니다", content: "전시회 분위기가 너무 좋았고 작품들도 인상적이었습니다.", author: "김영희", imageName: "morningStar"),
//        Review(title: "추천합니다", content: "전시회 분위기가 너무 좋았고 작품들도 인상적이었습니다.", author: "김영희", imageName: "morningStar"),
//    ]
//
//    // MARK: - 뷰의 생명주기
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.setNavigationBarHidden(false, animated: animated)
//        if let glassTabBar = tabBarController as? GlassTabBar {
//            glassTabBar.customTabBarView.isHidden = true
//        }
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        navigationController?.interactivePopGestureRecognizer?.delegate = self
//        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
//
//        tableView.isScrollEnabled = false
//
//        scrollView.contentInsetAdjustmentBehavior = .never
//        scrollView.delegate = self
//
//        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        navigationController?.navigationBar.shadowImage = UIImage()
//        navigationController?.navigationBar.isTranslucent = true
//        self.view.backgroundColor = .black
//
//        setupBackButton()
//        setupRightBarButton()
//        setupExhibitionImage()
//        setupScrollView()
//        setupViews()
//        setupTableView()
//        setupButtonBorders()
//        setupExhibitionInfoTextView()
//
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        reloadDataAndUpdateHeight()
//    }
//
//    // MARK: - 함수들
//
//    private func setupExhibitionInfoTextView() {
//        
//        let exhibitionInfoLabel = UILabel()
//        exhibitionInfoLabel.numberOfLines = 0
//        exhibitionInfoLabel.font = UIFont.systemFont(ofSize: 14)
//        exhibitionInfoLabel.textColor = .white
//        exhibitionInfoLabel.backgroundColor = .black
//
//        exhibitionInfoLabel.onToggleExpansion = { [weak self] in
//            self?.updateScrollViewContentSizeForExhibitionInfoView()
//        }
//
//
//
//        // 이 부분에 "더보기" 및 "접기" 기능을 적용합니다.
//        // 'longText'는 전시에 대한 전체 설명입니다.
//        let longText = """
//«김구림»은 실험미술의 선구자인 김구림의 예술 세계를 조명하는 개인전이다. 이번 전시는 1950년대부터 현재까지 다양한 매체, 장르, 주제를 넘나들며 예술의 최전선에서 독자적인 영역을 구축해 온 작가의 전위적인 면모를 확인할 수 있다. 비디오 아트, 설치, 판화, 퍼포먼스, 회화 등 미술의 범주를 넘어 무용, 연극, 영화, 음악에 이르기까지 다양한 분야에서 활발한 활동을 펼쳐 온 작가를 입체적으로 만나볼 수 있는 자리이기도 하다. 한국 현대미술사에서 중요한 위치를 차지하는 작가임에도 불구하고 김구림의 작품을 설명하거나 깊이 있게 경험할 기회는 충분치 않았기에 이번 전시를 통해 김구림의 미술사적 성과를 재확인하고, 현재진행형 작가로서 오늘날 그의 행보를 살펴보고자 한다. 전시는 1960년대 초 한국전쟁 이후 실존적인 문제에 매달리며 제작한 초기 회화, 1960-70년대 한국 실험미술의 중심에서 발표했던 퍼포먼스와 설치, 1980년대 중반부터 지속하는 <음과 양> 시리즈 등을 고루 소개한다. 또한 김구림 작가의 동시대적 면모를 확인할 수 있는 대형 설치와 함께 영화-무용-음악-연극을 한데 모은 공연을 새롭게 선보인다. 1950년대부터 이어진 김구림의 전방위적 활동과 거침없는 도전은 시대에 대한 반응이었고, 관습에 대한 저항이었던 바 그와 다른 시간대를 영위하는 이들이 단숨에 파악하기에는 어려운 낯선 영역일 것이다. 따라서 이번 전시는 부분적으로 밖에 파악할 수밖에 없었던 김구림의 세계를 최대한 온전하게 전달하는 데 초점을 두었다. 김구림과 함께 그의 결정적 순간들을 재방문해 보길 바라며, 김구림의 발자취를 경유하는 가운데 한국 미술사에 대한 이해의 폭을 넓히는 기회가 되길 바란다.
//"""
//        exhibitionInfoLabel.setTruncatedText(longText) // 여기에서 확장 기능을 사용하여 텍스트를 설정합니다.
//
//        // exhibitionInfoLabel의 레이아웃을 설정합니다.
//        exhibitionInformationView.addSubview(exhibitionInfoLabel)
//        exhibitionInfoLabel.snp.makeConstraints { make in
//            make.top.equalTo(reviewsButton.snp.bottom).offset(10)
//            make.left.equalTo(exhibitionInformationView.snp.left).offset(10)
//            make.right.equalTo(exhibitionInformationView.snp.right).offset(-10)
//        }
//
//
//        // 라인을 추가하기 위한 UIView 생성
//        let lineView = UIView()
//        lineView.backgroundColor = .lightGray  // 라인 색상 설정
//        exhibitionInformationView.addSubview(lineView)  // 라인 뷰를 상위 뷰에 추가
//
//        // 라인 뷰의 레이아웃 제약 조건 설정
//        lineView.snp.makeConstraints { make in
//            make.top.equalTo(exhibitionInfoLabel.snp.bottom).offset(10)  // 텍스트뷰의 바닥에서 10 포인트 아래에 위치
//            make.left.right.equalTo(exhibitionInformationView)  // 텍스트뷰의 좌우에 맞춤
//            make.height.equalTo(1)  // 높이를 1로 설정하여 얇은 선 만들기
//        }
//
//        // "관람 정보"를 표시하기 위한 UILabel 생성
//        let infoLabel = UILabel()
//        infoLabel.text = "관람 정보"
//        infoLabel.textColor = .lightGray  // 글자 색상 설정
//        infoLabel.font = .boldSystemFont(ofSize: 16)  // 폰트와 크기 설정
//        exhibitionInformationView.addSubview(infoLabel)  // 레이블을 상위 뷰에 추가
//
//        // 레이블의 레이아웃 제약 조건 설정
//        infoLabel.snp.makeConstraints { make in
//            make.top.equalTo(lineView.snp.bottom).offset(15)  // 라인 뷰의 바닥에서 10 포인트 아래에 위치
//            make.left.equalTo(exhibitionInformationView)  // 텍스트뷰의 왼쪽에 맞춤
//            make.right.equalTo(exhibitionInformationView)  // 텍스트뷰의 오른쪽에 맞춤
//        }
//
//        // "기간" 레이블 생성
//        let periodLabel = UILabel()
//        periodLabel.text = "기간"
//        periodLabel.textColor = .white
//        periodLabel.font = .systemFont(ofSize: 14)
//
//        // "2023.1.1 ~ 2023.1.1" 텍스트를 가진 레이블 생성
//        let dateLabel = UILabel()
//        dateLabel.text = "2023.1.1 ~ 2023.1.1"
//        dateLabel.textColor = .white
//        dateLabel.font = .systemFont(ofSize: 14)
//
//        // 레이블들을 수평으로 배치하기 위한 스택 뷰 생성
//        let stackView = UIStackView(arrangedSubviews: [periodLabel, dateLabel])
//        stackView.axis = .horizontal
//        stackView.spacing = 50  // 레이블 사이의 간격
//        stackView.alignment = .center
//        exhibitionInformationView.addSubview(stackView)
//
//        // 스택 뷰의 레이아웃 제약 조건 설정
//        stackView.snp.makeConstraints { make in
//            make.top.equalTo(infoLabel.snp.bottom).offset(15)  // "관람 정보" 레이블의 바닥에서 10 포인트 아래에 위치
//            make.left.equalTo(exhibitionInformationView)  // 텍스트뷰의 좌우에 맞춤
//
//        }
//
//        // "장소" 레이블 생성
//        let locationLabel = UILabel()
//        locationLabel.text = "장소"
//        locationLabel.textColor = .white
//        locationLabel.font = .systemFont(ofSize: 14)
//
//        // "국립현대미술관" 레이블 생성
//        let museumLabel = UILabel()
//        museumLabel.text = "국립현대미술관"
//        museumLabel.textColor = .white
//        museumLabel.font = .systemFont(ofSize: 14)
//
//        // 세로 선을 표현하기 위한 레이블 생성
//        let separatorLabel = UILabel()
//        separatorLabel.text = "|"
//        separatorLabel.textColor = .white
//        separatorLabel.font = .systemFont(ofSize: 14)
//
//        // "지하 1층 6, 7 전시실" 레이블 생성
//        let exhibitionRoomLabel = UILabel()
//        exhibitionRoomLabel.text = "지하 1층 6, 7 전시실"
//        exhibitionRoomLabel.textColor = .white
//        exhibitionRoomLabel.font = .systemFont(ofSize: 14)
//
//        // "국립현대미술관", "|", "지하 1층 6, 7 전시실"을 묶기 위한 스택 뷰
//        let museumDetailsStackView = UIStackView(arrangedSubviews: [museumLabel, separatorLabel, exhibitionRoomLabel])
//        museumDetailsStackView.axis = .horizontal
//        museumDetailsStackView.spacing = 10  // 간격 조절
//        museumDetailsStackView.alignment = .center
//
//        // "장소" 레이블과 위에서 생성한 스택 뷰를 묶기 위한 스택 뷰
//        let locationStackView = UIStackView(arrangedSubviews: [locationLabel, museumDetailsStackView])
//        locationStackView.axis = .horizontal
//        locationStackView.spacing = 50  // 간격 조절
//        locationStackView.alignment = .center
//        exhibitionInformationView.addSubview(locationStackView)
//
//        locationStackView.snp.makeConstraints { make in
//            make.top.equalTo(stackView.snp.bottom).offset(15)
//            make.left.equalTo(exhibitionInformationView)
//        }
//
//        // 버튼 생성
//        let button = UIButton(type: .system)
//        button.backgroundColor = .darkGray // 배경색 설정
//        exhibitionInformationView.addSubview(button)
//
//        // 버튼의 레이아웃 설정
//        button.snp.remakeConstraints { make in
//            make.top.equalTo(museumDetailsStackView.snp.bottom).offset(15)
//            make.left.equalTo(museumDetailsStackView)
//            make.right.equalTo(museumDetailsStackView).offset(40)
//            make.height.equalTo(33)
//        }
//
//        // 버튼 안에 들어갈 레이블 생성
//        let buttonLabel = UILabel()
//        buttonLabel.text = "길찾기" // 버튼 안에 들어갈 텍스트
//        buttonLabel.textColor = .white // 텍스트 색상 설정
//        buttonLabel.font = .systemFont(ofSize: 13) // 원하는 폰트 크기로 설정
//        button.layer.cornerRadius = 5
//        button.layer.borderColor = UIColor.white.cgColor
//        button.layer.borderWidth = 1
//        button.addSubview(buttonLabel)
//
//        // 버튼 안의 레이블 레이아웃 설정
//        buttonLabel.snp.makeConstraints { make in
//            make.center.equalTo(button) // 버튼의 중앙에 위치
//        }
//
//        // 버튼 안에 들어갈 이미지 아이콘 생성
//        let buttonIcon = UIImageView(image: UIImage(named: "Union")) // SF Symbols에서 제공하는 이미지 사용
//        buttonIcon.tintColor = .white // 이미지 색상 설정
//        button.addSubview(buttonIcon)
//
//        // 버튼 안의 이미지 아이콘 레이아웃 설정
//        buttonIcon.snp.makeConstraints { make in
//            make.centerY.equalTo(button) // 버튼의 세로 중앙에 위치
//            make.right.equalTo(buttonLabel.snp.left).offset(-10) // 버튼 안의 레이블 왼쪽에서 10 포인트 떨어진 곳에 위치
//        }
//
//        // 경계선 생성
//        let bottomLineView = UIView()
//        bottomLineView.backgroundColor = .lightGray
//        exhibitionInformationView.addSubview(bottomLineView)
//
//        // 경계선 레이아웃 설정
//        bottomLineView.snp.makeConstraints { make in
//            make.top.equalTo(button.snp.bottom).offset(15)
//            make.left.right.equalTo(exhibitionInformationView)
//            make.height.equalTo(1)
//        }
//
//        // "관람료" 레이블 생성
//        let admissionFeeLabel = UILabel()
//        admissionFeeLabel.text = "관람료"
//        admissionFeeLabel.textColor = .white
//        admissionFeeLabel.font = .systemFont(ofSize: 14)
//
//        // "2000원" 레이블 생성
//        let feeLabel = UILabel()
//        feeLabel.text = "2000원"
//        feeLabel.textColor = .white
//        feeLabel.font = .systemFont(ofSize: 14)
//
//        // 관람료 정보를 담을 스택 뷰 생성
//        let admissionFeeStackView = UIStackView(arrangedSubviews: [admissionFeeLabel, feeLabel])
//        admissionFeeStackView.axis = .horizontal
//        admissionFeeStackView.spacing = 40
//        admissionFeeStackView.alignment = .center
//        exhibitionInformationView.addSubview(admissionFeeStackView)
//
//        // 관람료 스택 뷰 레이아웃 설정
//        admissionFeeStackView.snp.makeConstraints { make in
//            make.top.equalTo(bottomLineView.snp.bottom).offset(15)
//            make.left.equalTo(exhibitionInformationView)
//        }
//
//        // "영업시간" 레이블 생성
//        let openingHoursLabel = UILabel()
//        openingHoursLabel.text = "영업시간"
//        openingHoursLabel.textColor = .white
//        openingHoursLabel.font = .systemFont(ofSize: 14)
//
//        // "9:00 ~ 6:00" 레이블 생성
//        let hoursLabel = UILabel()
//        hoursLabel.text = "9:00 ~ 6:00"
//        hoursLabel.textColor = .white
//        hoursLabel.font = .systemFont(ofSize: 14)
//
//        // 영업시간 정보를 담을 스택 뷰 생성
//        let openingHoursStackView = UIStackView(arrangedSubviews: [openingHoursLabel, hoursLabel])
//        openingHoursStackView.axis = .horizontal
//        openingHoursStackView.spacing = 28
//        openingHoursStackView.alignment = .center
//        exhibitionInformationView.addSubview(openingHoursStackView)
//
//        // 영업시간 스택 뷰 레이아웃 설정
//        openingHoursStackView.snp.makeConstraints { make in
//            make.top.equalTo(admissionFeeStackView.snp.bottom).offset(15)
//            make.left.equalTo(exhibitionInformationView)
//        }
//
//        // 영업시간 스택 뷰 밑에 경계선 추가
//        let secondLineView = UIView()
//        secondLineView.backgroundColor = .lightGray
//        exhibitionInformationView.addSubview(secondLineView)
//
//        secondLineView.snp.makeConstraints { make in
//            make.top.equalTo(openingHoursStackView.snp.bottom).offset(15)
//            make.left.right.equalTo(exhibitionInformationView)
//            make.height.equalTo(1)
//        }
//
//        museumHomepageButton.backgroundColor = .black
//        museumHomepageButton.setTitle("미술관 홈페이지로 가기", for: .normal)
//        museumHomepageButton.setTitleColor(.white, for: .normal)
//        museumHomepageButton.titleLabel?.font = .systemFont(ofSize: 14)
//        exhibitionInformationView.addSubview(museumHomepageButton)
//
//        museumHomepageButton.snp.makeConstraints { make in
//            make.top.equalTo(secondLineView.snp.bottom).offset(15)
//            make.left.equalTo(exhibitionInformationView)
//            make.height.equalTo(40)
//        }
//
//    }
//
//    // 전시 후기 버튼
//    @objc func reviewsButtonTapped() {
//        reviewView.isHidden = false
//        exhibitionInformationView.isHidden = true
//        updateScrollViewContentSize()
//
//        // 애니메이션을 사용하여 테두리 색상 변경
//        UIView.animate(withDuration: 0.25) { // 0.25초 동안의 애니메이션 지속 시간
//            self.reviewsButtonBorder.backgroundColor = .white
//            self.exhibitionInfoButtonBorder.backgroundColor = .clear
//        }
//    }
//
//    // 전시 정보 버튼
//    @objc func exhibitionInfoButtonTapped() {
//        reviewView.isHidden = true
//        exhibitionInformationView.isHidden = false
//        updateScrollViewContentSizeForExhibitionInfoView()
//
//        // 애니메이션을 사용하여 테두리 색상 변경
//        UIView.animate(withDuration: 0.25) { // 0.25초 동안의 애니메이션 지속 시간
//            self.reviewsButtonBorder.backgroundColor = .clear
//            self.exhibitionInfoButtonBorder.backgroundColor = .white
//        }
//    }
//
//    // 버튼 하단 테두리 설정
//    private func setupButtonBorders() {
//        contentView.addSubview(reviewsButtonBorder)
//        contentView.addSubview(exhibitionInfoButtonBorder)
//
//        // 초기 상태에서는 후기 버튼이 선택된 것으로 가정하고 테두리를 흰색으로 설정합니다.
//        reviewsButtonBorder.backgroundColor = .white
//        exhibitionInfoButtonBorder.backgroundColor = .clear
//
//        reviewsButtonBorder.snp.makeConstraints { make in
//            make.bottom.equalTo(reviewsButton.snp.bottom)
//            make.left.right.equalTo(reviewsButton)
//            make.height.equalTo(2)
//        }
//
//        exhibitionInfoButtonBorder.snp.makeConstraints { make in
//            make.bottom.equalTo(exhibitionInfoButton.snp.bottom)
//            make.left.right.equalTo(exhibitionInfoButton)
//            make.height.equalTo(2)
//        }
//    }
//
//
//    // 스크롤 뷰의 레이아웃을 정하는 함수 - 스크롤 뷰 안에 콘텐츠 뷰를 동일하게 추가
//    private func setupScrollView() {
//
//        view.addSubview(scrollView)
//
//        scrollView.snp.makeConstraints { make in
//            make.edges.equalTo(view)
//        }
//
//        scrollView.addSubview(contentView)
//
//        contentView.snp.makeConstraints { make in
//            make.top.bottom.equalTo(scrollView)
//            make.left.right.equalTo(view)
//            make.height.greaterThanOrEqualTo(view)
//            // 콘텐츠 뷰의 높이가 뷰의 높이보다 크거나 같도록 설정
//        }
//
//    }
//
//    // 스크롤 뷰의 사이즈를 재조정 하는 함수
//    // 스크롤 뷰의 사이즈를 재조정하는 함수
//    func updateScrollViewContentSizeForExhibitionInfoView() {
//        // UILabel의 현재 높이를 계산합니다.
//        let labelSize = exhibitionInfoTextView.sizeThatFits(CGSize(width: exhibitionInfoTextView.frame.width, height: CGFloat.greatestFiniteMagnitude))
//
//        // 전체 뷰의 높이를 계산할 때 UILabel의 높이를 포함합니다.
//        let totalHeight = exhibitionImageView.frame.height + reviewsButton.frame.height + museumHomepageButton.frame.maxY + labelSize.height + 32 + 16 // 16은 버튼과 스크롤 뷰 하단의 여백
//
//        scrollView.contentSize = CGSize(width: view.frame.width, height: totalHeight)
//    }
//
//
//    private func setupBackButton() {
//        navigationController?.interactivePopGestureRecognizer?.delegate = nil
//        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
//
//        let backButtonImage = UIImage(named: "backButton")
//        let backButton = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(backButtonTapped))
//        backButton.tintColor = .white
//        navigationItem.leftBarButtonItem = backButton
//    }
//
//
//    @objc func backButtonTapped() {
//        navigationController?.popViewController(animated: true)
//
//    }
//
//
//    private func setupRightBarButton() {
//        let rightButtonImage = UIImage(named: "audioGuide")
//        let rightButton = UIBarButtonItem(image: rightButtonImage, style: .plain, target: self, action: #selector(rightButtonTapped))
//        rightButton.tintColor = .white
//        navigationItem.rightBarButtonItem = rightButton
//
//
//    }
//
//    @objc func rightButtonTapped() {
//        // UserDefaults에서 로그인 상태를 false로 설정합니다.
//        UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
//        UserDefaults.standard.synchronize()
//
//        // 로그인 화면으로 전환합니다.
//        switchToLoginScreen()
//    }
//
//    func switchToLoginScreen() {
//        // 메인 스레드에서 UI 작업을 수행합니다.
//        DispatchQueue.main.async {
//            // 로그인 뷰 컨트롤러를 생성합니다.
//            let signUpVC = 로그인_뷰컨트롤러()
//            let navigationController = UINavigationController(rootViewController: signUpVC)
//
//            // SceneDelegate의 window를 가져옵니다.
//            if let delegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate, let window = delegate.window {
//                // 로그인 뷰 컨트롤러를 rootViewController로 설정합니다.
//                window.rootViewController = navigationController
//                window.makeKeyAndVisible()
//            }
//        }
//    }
//
//
//
//
//
//
//    // 상단의 전시 이미지를 설정 하는 함수
//    private func setupExhibitionImage() {
//        // 이미지 뷰를 contentView에 추가합니다.
//
//        // 전시 이미지와 레이블을 추가
//        contentView.addSubview(exhibitionImageView)
//        contentView.addSubview(titleLabel)
//        contentView.addSubview(galleryButtonLabel)
//
//        // 그 밑에 위치와 날짜 레이블의 스택뷰를 추가
//        stackView.addArrangedSubview(iconImageView)
//        stackView.addArrangedSubview(descriptionLabel)
//        contentView.addSubview(stackView)
//
//        stackView.axis = .horizontal
//        stackView.spacing = 10
//        stackView.alignment = .center
//
//        stackViewTwo.addArrangedSubview(iconImageViewTwo)
//        stackViewTwo.addArrangedSubview(descriptionLabelTwo)
//        contentView.addSubview(stackViewTwo)
//        contentView.addSubview(borderView)
//
//
//        stackViewTwo.axis = .horizontal
//        stackViewTwo.spacing = 10
//        stackViewTwo.alignment = .center
//
//        exhibitionImageView.snp.updateConstraints { make in
//            make.top.equalTo(contentView)
//            make.left.equalTo(contentView)
//            make.right.equalTo(contentView)
//            make.height.equalTo(350)
//        }
//
//        exhibitionImageView.image = UIImage(named: "ExhibitionPageBack")
//        exhibitionImageView.contentMode = .scaleAspectFill
//        exhibitionImageView.clipsToBounds = true
//
//        titleLabel.snp.makeConstraints { make in
//            make.top.equalTo(contentView).offset(200)
//            make.left.equalTo(contentView).offset(16)
//            make.right.equalTo(contentView).offset(-16)
//        }
//
//        titleLabel.text = "리암 길릭 : The Alterants"
//        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
//        titleLabel.textColor = .white
//
//        galleryButtonLabel.snp.makeConstraints { make in
//            make.top.equalTo(titleLabel.snp.bottom).offset(13)
//            make.left.equalTo(contentView).offset(16)
//            make.right.equalTo(contentView).offset(-16)
//        }
//
//        galleryButtonLabel.text = "갤러리바튼"
//        galleryButtonLabel.font = UIFont.systemFont(ofSize: 16)
//        galleryButtonLabel.textColor = .white
//
//        stackView.snp.makeConstraints { make in
//            make.top.equalTo(galleryButtonLabel.snp.bottom).offset(13)
//            make.left.equalTo(contentView).offset(16)
//            make.right.lessThanOrEqualTo(contentView).offset(-16)
//        }
//
//        iconImageView.image = UIImage(named: "exhibitionGeoIcon")
//        iconImageView.contentMode = .scaleAspectFit
//        descriptionLabel.text = "서울 종로구 삼청로 30"
//        descriptionLabel.font = UIFont.systemFont(ofSize: 12)
//        descriptionLabel.textColor = .white
//
//        stackViewTwo.snp.makeConstraints { make in
//            make.top.equalTo(stackView.snp.bottom).offset(13)
//            make.left.equalTo(contentView).offset(16)
//            make.right.lessThanOrEqualTo(contentView).offset(-16)
//        }
//
//        iconImageViewTwo.image = UIImage(named: "exhibitionCalendarIcon")
//        iconImageViewTwo.contentMode = .scaleAspectFit
//        descriptionLabelTwo.text = "~ 2024.02.12"
//        descriptionLabelTwo.font = UIFont.systemFont(ofSize: 12)
//        descriptionLabelTwo.textColor = .white
//
//        contentView.addSubview(reviewsButton)
//        contentView.addSubview(exhibitionInfoButton)
//
//        reviewsButton.setTitle("후기", for: .normal)
//        reviewsButton.setTitleColor(.white, for: .normal)
//        reviewsButton.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
//        reviewsButton.addTarget(self, action: #selector(reviewsButtonTapped), for: .touchUpInside)
//
//        exhibitionInfoButton.setTitle("전시 정보", for: .normal)
//        exhibitionInfoButton.setTitleColor(.white, for: .normal)
//        exhibitionInfoButton.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
//        exhibitionInfoButton.addTarget(self, action: #selector(exhibitionInfoButtonTapped), for: .touchUpInside)
//
//        reviewsButton.snp.makeConstraints { make in
//            make.top.equalTo(exhibitionImageView.snp.bottom).offset(16)
//            make.left.equalTo(contentView).offset(16)
//            make.height.equalTo(40)
//        }
//
//        exhibitionInfoButton.snp.makeConstraints { make in
//            make.top.equalTo(exhibitionImageView.snp.bottom).offset(16)
//            make.left.equalTo(reviewsButton.snp.right).offset(16)
//            make.height.equalTo(40)
//            make.width.equalTo(reviewsButton.snp.width)  // 너비 동일하게 설정
//        }
//
//        borderView.snp.makeConstraints { make in
//            make.top.equalTo(reviewsButton.snp.bottom)
//            make.width.equalToSuperview()
//            make.height.equalTo(1) // 경계선 뷰의 너비를 1로 설정하여 얇은 선 만들기
//        }
//
//        borderView.backgroundColor = .lightGray  // 경계선 색상 설정
//
//    }
//
//    // 버튼으로 보여지는 뷰의 레이아웃을 정하는 함수.
//    private func setupViews() {
//        contentView.addSubview(reviewView)
//        contentView.addSubview(exhibitionInformationView)
//
//        reviewView.snp.makeConstraints { make in
//            make.top.equalTo(reviewsButton.snp.bottom).offset(16)
//            make.left.right.equalTo(contentView)
//            make.bottom.equalTo(contentView).priority(.high) // 전시 리뷰 뷰의 하단을 contentView의 하단에 연결
//        }
//
//        exhibitionInformationView.snp.makeConstraints { make in
//            make.top.equalTo(reviewsButton.snp.bottom).offset(16)
//            make.left.right.equalTo(contentView)
//            make.bottom.equalTo(contentView)  // 이 부분을 추가합니다.
//            // make.height.equalTo(2000).priority(.high) // 이 부분을 제거하거나 주석 처리합니다.
//        }
//
//        reviewView.backgroundColor = .red
//        exhibitionInformationView.backgroundColor = .black
//
//
//        // 초기 상태 설정
//        reviewView.isHidden = false
//        exhibitionInformationView.isHidden = true
//
//    }
//
//    private func setupTableView() {
//        reviewView.addSubview(tableView)
//        tableView.backgroundColor = .white
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.register(ReviewTableViewCell.self, forCellReuseIdentifier: "ReviewTableViewCell")
//
//        // 초기 높이를 0으로 설정하지 않고, 테이블 뷰의 데이터에 따라 높이가 결정되도록 합니다.
//        tableView.snp.makeConstraints { make in
//            make.top.equalTo(reviewsButton.snp.bottom).offset(16)
//            make.left.right.equalTo(contentView)
//            make.bottom.equalTo(reviewView)
//        }
//
//        // reviewView의 높이 제약조건을 저장합니다.
//        reviewView.snp.makeConstraints { make in
//            self.reviewTableViewHeightConstraint = make.height.equalTo(0).constraint
//        }
//
//        reloadDataAndUpdateHeight()
//
//        // 데이터 로드 및 테이블 뷰의 높이 업데이트
//        reloadDataAndUpdateHeight()
//    }
//
//    func reloadDataAndUpdateHeight() {
//        DispatchQueue.main.async {
//            self.tableView.reloadData()
//            self.tableView.layoutIfNeeded()
//            let tableViewHeight = self.tableView.contentSize.height
//            self.reviewTableViewHeightConstraint?.update(offset: tableViewHeight)
//            self.updateScrollViewContentSize()
//        }
//    }
//
//
//    func updateTableViewHeight() {
//        // 테이블 뷰에 행이 있는지 확인한 후 높이 업데이트
//        guard tableView.numberOfSections > 0, tableView.numberOfRows(inSection: 0) > 0 else {
//            return
//        }
//
//        tableView.layoutIfNeeded()
//        reviewTableViewHeightConstraint?.update(offset: tableView.contentSize.height)
//        updateScrollViewContentSize()
//    }
//
//
//    func updateScrollViewContentSize() {
//        let totalHeight = exhibitionImageView.frame.height + reviewsButton.frame.height + reviewView.frame.height + 32
//        if scrollView.contentSize.height != totalHeight {
//            scrollView.contentSize = CGSize(width: view.frame.width, height: totalHeight)
//        }
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return reviews.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewTableViewCell", for: indexPath) as! ReviewTableViewCell
//        let review = reviews[indexPath.row]
//        cell.configure(with: review)
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if indexPath.row == reviews.count - 1 {
//            updateTableViewHeight()
//        }
//    }
//
//}
//
//// '더보기' 및 '접기' 기능을 가진 UILabel의 확장
//extension UILabel {
//
//    // 클로저를 저장할 수 있게 속성을 추가합니다.
//    private struct AssociatedKeys {
//        static var onToggleExpansion: Void?
//    }
//
//    // 클로저를 설정하고 가져오기 위한 computed property
//    var onToggleExpansion: (() -> Void)? {
//        get {
//            return objc_getAssociatedObject(self, &AssociatedKeys.onToggleExpansion) as? (() -> Void)
//        }
//        set(value) {
//            objc_setAssociatedObject(self, &AssociatedKeys.onToggleExpansion, value, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//        }
//    }
//
//    // '더보기' 텍스트와 함께 레이블에 텍스트를 설정합니다.
//    func setTruncatedText(_ text: String, readMoreText: String = "더보기", readLessText: String = "접기") {
//        let attributedString = NSMutableAttributedString(string: text)
//        let readMoreAttributedText = NSAttributedString(string: " \(readMoreText)", attributes: [.foregroundColor: UIColor.blue])
//        let readLessAttributedText = NSAttributedString(string: " \(readLessText)", attributes: [.foregroundColor: UIColor.blue])
//
//        // 현재 UI 상황에 따라 텍스트 크기를 조정합니다.
//        DispatchQueue.main.async { [weak self] in
//            guard let strongSelf = self else { return }
//            strongSelf.attributedText = attributedString
//
//            // '더보기' 텍스트를 표시할 지 결정합니다.
//            if strongSelf.isTruncated() {
//                let truncatedString = NSMutableAttributedString(attributedString: attributedString)
//                truncatedString.append(readMoreAttributedText)
//                strongSelf.attributedText = truncatedString
//                strongSelf.numberOfLines = 3 // 예를 들어 기본적으로 3줄만 표시
//            } else {
//                strongSelf.numberOfLines = 0 // 모든 줄을 표시합니다.
//                strongSelf.attributedText = attributedString
//            }
//            strongSelf.isUserInteractionEnabled = true
//            let tapGesture = UITapGestureRecognizer(target: strongSelf, action: #selector(strongSelf.toggleReadMore(gesture:)))
//            strongSelf.addGestureRecognizer(tapGesture)
//            
//        }
//    }
//
//    // '더보기' 또는 '접기'를 토글하는 메서드입니다.
//    // UILabel 확장의 '더보기'/'접기' 토글 메서드
//    @objc func toggleReadMore(gesture: UITapGestureRecognizer) {
//        guard let text = self.text else { return }
//
//        // 텍스트를 전환하고, 레이아웃을 바로 업데이트합니다.
//        if text.contains("더보기") {
//            let newLabelText = text.replacingOccurrences(of: " 더보기", with: " 접기")
//            self.numberOfLines = 0
//            self.text = newLabelText
//        } else if text.contains("접기") {
//            let newLabelText = text.replacingOccurrences(of: " 접기", with: " 더보기")
//            self.numberOfLines = 3
//            self.text = newLabelText
//        }
//
//        self.superview?.setNeedsLayout()
//        self.superview?.layoutIfNeeded()
//
//        // 스크롤 뷰의 contentSize를 조정해야 할 때 클로저를 호출합니다.
//        onToggleExpansion?()
//    }
//
//
//    // 레이블의 텍스트가 잘릴 때 true를 반환합니다.
//    func isTruncated() -> Bool {
//        guard let labelText = text else {
//            return false
//        }
//
//        let labelSize = (labelText as NSString).boundingRect(
//            with: CGSize(width: self.frame.size.width, height: .greatestFiniteMagnitude),
//            options: .usesLineFragmentOrigin,
//            attributes: [.font: self.font!],
//            context: nil).size
//
//        return labelSize.height > self.bounds.size.height
//    }
//
//    // '더보기' 텍스트를 탭했을 때의 동작을 정의합니다.
//    @objc func readMoreDidTapGesture(gesture: UITapGestureRecognizer) {
//        // 탭된 위치가 '더보기' 텍스트 영역 내에 있는지 확인합니다.
//        let tapLocation = gesture.location(in: self)
//        let tapIndex = self.indexOfAttributedTextCharacterAtPoint(point: tapLocation)
//
//        guard let text = self.text, tapIndex >= text.count - "더보기".count else { return }
//
//        // 전체 텍스트를 표시하도록 'numberOfLines'를 조정합니다.
//        self.numberOfLines = 0
//        self.text = text
//    }
//
//    // 특정 포인트에 있는 문자의 인덱스를 찾는 메서드입니다.
//    func indexOfAttributedTextCharacterAtPoint(point: CGPoint) -> Int {
//        guard let text = self.attributedText else {
//            return NSNotFound
//        }
//
//        let textStorage = NSTextStorage(attributedString: text)
//        let layoutManager = NSLayoutManager()
//        textStorage.addLayoutManager(layoutManager)
//
//        let textContainer = NSTextContainer(size: self.frame.size)
//        textContainer.lineFragmentPadding = 0
//        textContainer.lineBreakMode = self.lineBreakMode
//        textContainer.maximumNumberOfLines = self.numberOfLines
//        layoutManager.addTextContainer(textContainer)
//
//        let index = layoutManager.characterIndex(for: point, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
//        return index
//    }
//}
