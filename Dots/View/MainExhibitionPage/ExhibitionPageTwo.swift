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


class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let segmentControl = UISegmentedControl(items: ["후기", "상세정보"])
    var reviewsTableView = UITableView()
       var reviews: [String] = [] // 후기 데이터 배열


    override func viewDidLoad() {
            super.viewDidLoad()
        view.backgroundColor = .black
            isModalInPresentation = true

        // 세그먼트 컨트롤 설정
                configureSegmentControl()

                // 테이블 뷰 설정
                configureTableView()
        loadSampleReviews()


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

        // 테이블 뷰에 대한 SnapKit 레이아웃 설정
        reviewsTableView.snp.makeConstraints { make in
            make.top.equalTo(segmentControl.snp.bottom).offset(10)
            make.left.right.equalTo(view).inset(10)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

    @objc func segmentChanged(_ sender: UISegmentedControl) {
          reviewsTableView.isHidden = sender.selectedSegmentIndex != 0
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


    private func loadSampleReviews() {
           reviews = ["정말 좋았어요!", "멋진 전시였습니다.", "다시 방문하고 싶어요.", "추천합니다!", "생각보다 별로였어요.", "인상적인 작품이 많았습니다.", "전시가 너무 혼잡했어요.", "작품 설명이 잘 되어 있어서 좋았습니다.", "아이와 같이 가기 좋은 전시였어요.", "주차 공간이 넉넉해서 좋았어요.","정말 좋았어요!", "멋진 전시였습니다.", "다시 방문하고 싶어요.", "추천합니다!", "생각보다 별로였어요.", "인상적인 작품이 많았습니다.", "전시가 너무 혼잡했어요.", "작품 설명이 잘 되어 있어서 좋았습니다.", "아이와 같이 가기 좋은 전시였어요.", "주차 공간이 넉넉해서 좋았어요."]
           reviewsTableView.reloadData()
       }

}






class 새로운_ReviewTableViewCell: UITableViewCell {
    private let containerView = UIView()
    private let titleLabel = UILabel()
    private let contentLabel = UILabel()
    private let profileImageView = UIImageView()
    private let nicknameLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .black // contentView 배경색을 검은색으로 설정
        setupLayout()
    }


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        // containerView 설정
        containerView.layer.cornerRadius = 10
        containerView.clipsToBounds = true
        containerView.backgroundColor = .gray
        contentView.addSubview(containerView)

        // titleLabel 설정
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.textColor = .white

        // contentLabel 설정
        contentLabel.font = UIFont.systemFont(ofSize: 14)
        contentLabel.textColor = .white
        contentLabel.numberOfLines = 0

        // profileImageView 설정
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 15 // 이미지의 둥근 모서리 반경 설정

        // nicknameLabel 설정
        nicknameLabel.font = UIFont.systemFont(ofSize: 12)
        nicknameLabel.textColor = .white

        // 컨테이너 뷰에 추가
        containerView.addSubview(titleLabel)
        containerView.addSubview(contentLabel)
        containerView.addSubview(profileImageView)
        containerView.addSubview(nicknameLabel)

        // Auto Layout 설정
        profileImageView.snp.makeConstraints { make in
            make.top.left.equalTo(containerView).offset(8) // 상단과 왼쪽에 여백을 줍니다.
            make.width.height.equalTo(30) // 프로필 이미지의 너비와 높이 설정
        }

        nicknameLabel.snp.makeConstraints { make in
            make.left.equalTo(profileImageView.snp.right).offset(8) // 프로필 이미지 오른쪽에 위치
            make.centerY.equalTo(profileImageView.snp.centerY) // 프로필 이미지와 중앙을 맞춥니다.
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(8) // 프로필 이미지 아래에 위치
            make.left.right.equalTo(containerView).inset(8) // 좌우 여백 설정
        }

        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4) // 타이틀 레이블 아래에 위치
            make.left.right.bottom.equalTo(containerView).inset(8) // 컨테이너 뷰의 내부 여백 설정
        }

        containerView.snp.makeConstraints { make in
            make.edges.equalTo(contentView).inset(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        }
    }

    // 셀의 데이터를 설정하는 메서드
    func setReview(title: String, content: String, profileImage: UIImage?, nickname: String) {
        titleLabel.text = title
        contentLabel.text = content
        profileImageView.image = profileImage
        nicknameLabel.text = nickname
    }
}
