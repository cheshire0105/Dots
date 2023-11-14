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

    lazy var recordButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Union 4"), for: .normal) // 버튼의 기본 상태 이미지를 설정합니다.
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
        view.addSubview(recordButton)



        backButton.snp.makeConstraints { make in // SnapKit을 사용하여 제약 조건 설정
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10) // 상단 safe area로부터 10포인트 아래에 위치
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(10) // leading edge로부터 10포인트 떨어진 곳에 위치
            make.width.height.equalTo(40) // 너비와 높이는 40포인트로 설정
        }
        
        recordButton.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-10)
            make.width.height.equalTo(40)
        }

        heartIcon.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.trailing.equalTo(recordButton.snp.leading).offset(-10)
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
            make.top.equalToSuperview().offset(15) // 상단 여백 설정
            make.left.equalToSuperview().offset(10) // 좌측 여백 설정
            make.right.equalToSuperview().offset(-10) // 우측 여백 설정
        }

        // 내용 레이블의 레이아웃 설정
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(10) // 제목 레이블 아래 간격을 둡니다.
            make.left.right.equalTo(titleLabel)
            make.bottom.lessThanOrEqualToSuperview().offset(-10) // 셀 하단 여백 설정 // 유동적으로 늘어나야 할 때 사용 하는 메서드.

        }

        // 프로필 이미지 뷰의 레이아웃 설정
        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10) // 좌측 여백 설정
            make.width.height.equalTo(30) // 이미지 크기를 30x30으로 설정
        }

        // 닉네임 레이블의 레이아웃 설정
        nicknameLabel.snp.makeConstraints { make in
            make.right.equalTo(profileImageView.snp.left).offset(-10) // 프로필 이미지 오른쪽에 위치
            make.centerY.equalTo(profileImageView.snp.centerY) // 프로필 이미지와 중앙 정렬
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
