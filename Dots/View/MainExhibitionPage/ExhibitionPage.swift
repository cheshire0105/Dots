//
//  ExhibitionPage.swift
//  Dots
//
//  Created by cheshire on 10/27/23.
//
// pull from master branch
import UIKit
import SnapKit

class ExhibitionPage: UIViewController, UIScrollViewDelegate, UIGestureRecognizerDelegate, UITableViewDelegate, UITableViewDataSource {

    // MARK: - 변수들

    let scrollView = UIScrollView()
    let contentView = UIView()

    let exhibitionImageView = UIImageView()
    let titleLabel = UILabel()
    let galleryButtonLabel = UILabel()

    let iconImageView = UIImageView()
    let descriptionLabel = UILabel()
    let stackView = UIStackView()

    let iconImageViewTwo = UIImageView()
    let descriptionLabelTwo = UILabel()
    let stackViewTwo = UIStackView()

    let reviewView = UIView()
    let exhibitionInformationView = UIView()

    let tableView = UITableView()

    // 세그먼트 컨트롤 대신에 버튼을 사용
    let reviewsButton = UIButton()
    let exhibitionInfoButton = UIButton()

    // 테이블 뷰의 높이 제약 조건을 클래스 프로퍼티로 정의
    var tableViewHeightConstraint: Constraint?

    var reviewViewHeightConstraint: Constraint? // reviewView의 높이 제약조건을 저장할 프로퍼티


    // 더미 데이터
    let reviews = [
        Review(title: "훌륭한 전시회였어요!", content: "정말 재미있게 관람했습니다. 다음에 또 오고 싶어요.", author: "홍길동"),
        Review(title: "추천합니다", content: "전시회 분위기가 너무 좋았고 작품들도 인상적이었습니다.", author: "김영희"),
        Review(title: "추천합니다", content: "전시회 분위기가 너무 좋았고 작품들도 인상적이었습니다.", author: "김영희"),
        Review(title: "추천합니다", content: "전시회 분위기가 너무 좋았고 작품들도 인상적이었습니다.", author: "김영희"),
        Review(title: "추천합니다", content: "전시회 분위기가 너무 좋았고 작품들도 인상적이었습니다.", author: "김영희"),
        Review(title: "추천합니다", content: "전시회 분위기가 너무 좋았고 작품들도 인상적이었습니다.", author: "김영희"),
        Review(title: "추천합니다", content: "전시회 분위기가 너무 좋았고 작품들도 인상적이었습니다.", author: "김영희"),
        Review(title: "추천합니다", content: "전시회 분위기가 너무 좋았고 작품들도 인상적이었습니다.", author: "김영희"),
        Review(title: "추천합니다", content: "전시회 분위기가 너무 좋았고 작품들도 인상적이었습니다.", author: "김영희"),

    ]

    // MARK: - 뷰의 생명주기

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        if let glassTabBar = tabBarController as? GlassTabBar {
            glassTabBar.customTabBarView.isHidden = true
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true

        tableView.isScrollEnabled = false


        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.delegate = self

        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        self.view.backgroundColor = .black

        setupBackButton()
        setupRightBarButton()
        setupExhibitionImage()
        setupScrollView()
        setupViews()

        setupTableView()


    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        reloadDataAndUpdateHeight()
    }



    // MARK: - 함수들

    // 버튼을 설정하는 함수


    @objc func reviewsButtonTapped() {
        reviewView.isHidden = false
        exhibitionInformationView.isHidden = true
        updateScrollViewContentSize()
    }

    @objc func exhibitionInfoButtonTapped() {
        reviewView.isHidden = true
        exhibitionInformationView.isHidden = false
        updateScrollViewContentSizeForExhibitionInfoView()
    }

    func updateScrollViewContentSizeForExhibitionInfoView() {
        let totalHeight = exhibitionImageView.frame.height + reviewsButton.frame.height + exhibitionInformationView.frame.height + 32
        scrollView.contentSize = CGSize(width: view.frame.width, height: totalHeight)
    }


    // 스크롤 뷰의 레이아웃을 정하는 함수 - 스크롤 뷰 안에 콘텐츠 뷰를 동일하게 추가
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }

        contentView.snp.makeConstraints { make in
            make.top.bottom.equalTo(scrollView)
            make.left.right.equalTo(view)
            make.height.greaterThanOrEqualTo(view) // 콘텐츠 뷰의 높이가 뷰의 높이보다 크거나 같도록 설정
        }

    }


    // 상단의 전시 이미지를 설정 하는 함수
    private func setupExhibitionImage() {
        // 이미지 뷰를 contentView에 추가합니다.

        // 전시 이미지와 레이블을 추가
        contentView.addSubview(exhibitionImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(galleryButtonLabel)

        // 그 밑에 위치와 날짜 레이블의 스택뷰를 추가
        stackView.addArrangedSubview(iconImageView)
        stackView.addArrangedSubview(descriptionLabel)
        contentView.addSubview(stackView)

        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center

        stackViewTwo.addArrangedSubview(iconImageViewTwo)
        stackViewTwo.addArrangedSubview(descriptionLabelTwo)
        contentView.addSubview(stackViewTwo)

        stackViewTwo.axis = .horizontal
        stackViewTwo.spacing = 10
        stackViewTwo.alignment = .center



        exhibitionImageView.snp.updateConstraints { make in
            make.top.equalTo(contentView)
            make.left.equalTo(contentView)
            make.right.equalTo(contentView)
            make.height.equalTo(350)
        }

        exhibitionImageView.image = UIImage(named: "ExhibitionPageBack")
        exhibitionImageView.contentMode = .scaleAspectFill
        exhibitionImageView.clipsToBounds = true

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(200)
            make.left.equalTo(contentView).offset(16)
            make.right.equalTo(contentView).offset(-16)
        }

        titleLabel.text = "리암 길릭 : The Alterants"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textColor = .white

        galleryButtonLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(13)
            make.left.equalTo(contentView).offset(16)
            make.right.equalTo(contentView).offset(-16)
        }

        galleryButtonLabel.text = "갤러리바튼"
        galleryButtonLabel.font = UIFont.systemFont(ofSize: 16)
        galleryButtonLabel.textColor = .white

        stackView.snp.makeConstraints { make in
            make.top.equalTo(galleryButtonLabel.snp.bottom).offset(13)
            make.left.equalTo(contentView).offset(16)
            make.right.lessThanOrEqualTo(contentView).offset(-16)
        }

        iconImageView.image = UIImage(named: "exhibitionGeoIcon")
        iconImageView.contentMode = .scaleAspectFit
        descriptionLabel.text = "서울 종로구 삼청로 30"
        descriptionLabel.font = UIFont.systemFont(ofSize: 12)
        descriptionLabel.textColor = .white

        stackViewTwo.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(13)
            make.left.equalTo(contentView).offset(16)
            make.right.lessThanOrEqualTo(contentView).offset(-16)
        }

        iconImageViewTwo.image = UIImage(named: "exhibitionCalendarIcon")
        iconImageViewTwo.contentMode = .scaleAspectFit
        descriptionLabelTwo.text = "~ 2024.02.12"
        descriptionLabelTwo.font = UIFont.systemFont(ofSize: 12)
        descriptionLabelTwo.textColor = .white

        contentView.addSubview(reviewsButton)
        contentView.addSubview(exhibitionInfoButton)

        reviewsButton.setTitle("후기", for: .normal)
        reviewsButton.setTitleColor(.white, for: .normal)
        reviewsButton.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        reviewsButton.addTarget(self, action: #selector(reviewsButtonTapped), for: .touchUpInside)

        exhibitionInfoButton.setTitle("전시 정보", for: .normal)
        exhibitionInfoButton.setTitleColor(.white, for: .normal)
        exhibitionInfoButton.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        exhibitionInfoButton.addTarget(self, action: #selector(exhibitionInfoButtonTapped), for: .touchUpInside)

        reviewsButton.snp.makeConstraints { make in
            make.top.equalTo(exhibitionImageView.snp.bottom).offset(16)
            make.left.equalTo(contentView).offset(16)
            make.height.equalTo(40)
        }

        exhibitionInfoButton.snp.makeConstraints { make in
            make.top.equalTo(exhibitionImageView.snp.bottom).offset(16)
            make.left.equalTo(reviewsButton.snp.right).offset(16)
            make.height.equalTo(40)
            make.width.equalTo(reviewsButton.snp.width)  // 너비 동일하게 설정
        }

    }

    private func setupViews() {
        contentView.addSubview(reviewView)
        contentView.addSubview(exhibitionInformationView)

        reviewView.snp.makeConstraints { make in
            make.top.equalTo(reviewsButton.snp.bottom).offset(16)
            make.left.right.equalTo(contentView)
            //            make.height.equalTo(1000).priority(.high) // 우선순위를 높음으로 설정
            make.bottom.equalTo(contentView).priority(.high) // 추가된 부분: redView의 하단을 contentView의 하단에 연결
        }

        exhibitionInformationView.snp.makeConstraints { make in
            make.top.equalTo(reviewsButton.snp.bottom).offset(16)
            make.left.right.equalTo(contentView)
            make.height.equalTo(2000).priority(.high) // 우선순위를 높음으로 설정
            make.bottom.equalTo(contentView) // 추가된 부분: blueView의 하단을 contentView의 하단에 연결
        }


        reviewView.backgroundColor = .red
        exhibitionInformationView.backgroundColor = .blue

        // 초기 상태 설정
        reviewView.isHidden = false
        exhibitionInformationView.isHidden = true
    }


    private func setupBackButton() {
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true

        let backButtonImage = UIImage(named: "backButton")
        let backButton = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(backButtonTapped))
        backButton.tintColor = .white
        navigationItem.leftBarButtonItem = backButton
    }


    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

    private func setupRightBarButton() {
        let rightButtonImage = UIImage(named: "audioGuide")
        let rightButton = UIBarButtonItem(image: rightButtonImage, style: .plain, target: self, action: #selector(rightButtonTapped))
        rightButton.tintColor = .white
        navigationItem.rightBarButtonItem = rightButton
    }

    @objc func rightButtonTapped() {

    }







    private func setupTableView() {
        reviewView.addSubview(tableView)
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ReviewTableViewCell.self, forCellReuseIdentifier: "ReviewTableViewCell")

        // 초기 높이를 0으로 설정하지 않고, 테이블 뷰의 데이터에 따라 높이가 결정되도록 합니다.
        tableView.snp.makeConstraints { make in
            make.top.equalTo(reviewsButton.snp.bottom).offset(16)
            make.left.right.equalTo(contentView)
            make.bottom.equalTo(reviewView)
        }

        // reviewView의 높이 제약조건을 저장합니다.
        reviewView.snp.makeConstraints { make in
            self.reviewViewHeightConstraint = make.height.equalTo(0).constraint
        }

        reloadDataAndUpdateHeight()

        // 데이터 로드 및 테이블 뷰의 높이 업데이트
        reloadDataAndUpdateHeight()
    }

    func reloadDataAndUpdateHeight() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.tableView.layoutIfNeeded()
            let tableViewHeight = self.tableView.contentSize.height
            self.reviewViewHeightConstraint?.update(offset: tableViewHeight)
            self.updateScrollViewContentSize()
        }
    }


    func updateTableViewHeight() {
        // 테이블 뷰에 행이 있는지 확인한 후 높이 업데이트
        guard tableView.numberOfSections > 0, tableView.numberOfRows(inSection: 0) > 0 else {
            return
        }

        tableView.layoutIfNeeded()
        tableViewHeightConstraint?.update(offset: tableView.contentSize.height)
        updateScrollViewContentSize()
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewTableViewCell", for: indexPath) as! ReviewTableViewCell
        let review = reviews[indexPath.row]
        cell.configure(with: review)
        return cell
    }

    func updateScrollViewContentSize() {
        let totalHeight = exhibitionImageView.frame.height + reviewsButton.frame.height + reviewView.frame.height + 32
        if scrollView.contentSize.height != totalHeight {
            scrollView.contentSize = CGSize(width: view.frame.width, height: totalHeight)
        }
    }




    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == reviews.count - 1 {
            updateTableViewHeight()
        }




    }


}
