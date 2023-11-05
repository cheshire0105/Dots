//
//  signUpPage.swift
//  Dots
//
//  Created by cheshire on 11/5/23.
//

import UIKit
import SnapKit

class SignUpViewController: UIViewController {
    // UI 컴포넌트 선언
    private let emailTextField = UITextField()
    private let passwordTextField = UITextField()
    private let signUpButton = UIButton()
    private let sloganLable = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        layoutViews()
    }

    private func setupViews() {
        view.backgroundColor = .black

        emailTextField.borderStyle = .roundedRect
        emailTextField.placeholder = "이메일을 입력하세요"
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none
        emailTextField.backgroundColor = .lightGray

        passwordTextField.borderStyle = .roundedRect
        passwordTextField.placeholder = "비밀번호를 입력하세요"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.autocapitalizationType = .none
        passwordTextField.backgroundColor = .lightGray

        signUpButton.setTitle("가입하기", for: .normal)
        signUpButton.backgroundColor = .darkGray
        signUpButton.layer.cornerRadius = 5
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)

        sloganLable.text = "전시의 시작은 당신의 눈길, 깊이는 우리의 목소리"
        sloganLable.backgroundColor = .black
        sloganLable.textColor = .darkGray
        sloganLable.font = .boldSystemFont(ofSize: 30)
        sloganLable.textAlignment = .center
        sloganLable.numberOfLines = 0 // 무제한 줄 수를 허용합니다.
        sloganLable.lineBreakMode = .byWordWrapping // 단어 단위로 줄 바꿈합니다.


    }

    private func layoutViews() {

        view.addSubview(sloganLable)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signUpButton)

        sloganLable.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(120)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)

        }

        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(sloganLable.safeAreaLayoutGuide.snp.bottom).offset(120)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }

        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(12)
            make.left.right.equalTo(emailTextField)
            make.height.equalTo(44)
        }

        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.left.right.equalTo(passwordTextField)
            make.height.equalTo(50)
        }

    }

    // 가입 버튼이 탭되었을 때 실행할 메소드
    @objc private func signUpButtonTapped() {
        // 여기에 가입 로직을 구현하거나, 현재는 단순히 입력값을 출력해볼 수 있습니다.
        print("이메일: \(emailTextField.text ?? "")")
        print("비밀번호: \(passwordTextField.text ?? "")")
    }
}

import SwiftUI

// SwiftUI 뷰에서 UIViewController를 사용하기 위한 구조체
struct SignUpViewControllerPreview: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> SignUpViewController {
        // ViewController 인스턴스를 생성하고 반환합니다.
        return SignUpViewController()
    }

    func updateUIViewController(_ uiViewController: SignUpViewController, context: Context) {
        // 뷰 컨트롤러를 업데이트할 때 필요한 작업을 여기에 구현합니다.
    }
}

// Xcode 프리뷰 제공을 위한 구조체
struct SignUpViewController_Previews: PreviewProvider {
    static var previews: some View {
        SignUpViewControllerPreview()
            .edgesIgnoringSafeArea(.all) // 전체 화면을 사용하는 경우
    }
}
