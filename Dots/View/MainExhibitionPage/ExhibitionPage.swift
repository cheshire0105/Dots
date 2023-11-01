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
    
    private let segmentedControl: PageSegmentedControl = {
        let items = ["후기", "전시 정보"]
        let segmentedControl = PageSegmentedControl(items: items)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        segmentedControl.setTitleTextAttributes(
            [
                NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
                .font: UIFont.systemFont(ofSize: 13, weight: .semibold)
            ],
            for: .selected
        )
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
    
    let reviewView = UIView()
    let exhibitionInformationView = UIView()

    let tableView = UITableView()

    // 더미 데이터
      let reviews = [
          Review(title: "훌륭한 전시회였어요!", content: "정말 재미있게 관람했습니다. 다음에 또 오고 싶어요.", author: "홍길동"),
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
        setupSegmentedControl()
        
        setupTableView()

    }
    
    
    
    // MARK: - 함수들
    
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
        
        // 세그먼트 컨트롤을 추가
        contentView.addSubview(segmentedControl)
        
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
        
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(exhibitionImageView.snp.bottom).offset(16)
            make.left.equalTo(contentView).offset(16)
            make.height.equalTo(40)  // 높이 지정
        }
        
    }
    
    private func setupViews() {
        contentView.addSubview(reviewView)
        contentView.addSubview(exhibitionInformationView)
        
        reviewView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(16)
            make.left.right.equalTo(contentView)
//            make.height.equalTo(1000).priority(.high) // 우선순위를 높음으로 설정
            make.bottom.equalTo(contentView).priority(.high) // 추가된 부분: redView의 하단을 contentView의 하단에 연결
        }
        
        exhibitionInformationView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(16)
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
    
    
    private func setupSegmentedControl() {
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
    }
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            reviewView.isHidden = false
            exhibitionInformationView.isHidden = true
            // 스크롤 뷰의 contentSize를 리뷰 뷰의 높이에 맞게 조정
            scrollView.contentSize = CGSize(width: view.frame.width, height: reviewView.frame.height + segmentedControl.frame.height + 16)
        case 1:
            reviewView.isHidden = true
            exhibitionInformationView.isHidden = false
            // 스크롤 뷰의 contentSize를 전시 정보 뷰의 높이에 맞게 조정
            scrollView.contentSize = CGSize(width: view.frame.width, height: exhibitionInformationView.frame.height + segmentedControl.frame.height + 16)
        default:
            break
        }
    }


    private func setupTableView() {
        reviewView.addSubview(tableView)

        tableView.backgroundColor = .white

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ReviewTableViewCell.self, forCellReuseIdentifier: "ReviewTableViewCell")

        tableView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom)
            make.left.right.equalTo(contentView)
            make.bottom.equalTo(contentView)
        }
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

}


