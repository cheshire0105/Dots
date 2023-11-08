// 23. 11. 8  12:28 pm dev에서 풀 완료 - 최신화 커밋 - > 로그인 페이지 작업 시작 

import UIKit
import SnapKit

class SignUpViewController: UIViewController, UITextFieldDelegate {
    // UI 컴포넌트 선언
    private let emailTextField = UITextField()
    private let passwordTextField = UITextField()
    private let signUpButton = UIButton()
    private let sloganLable = UILabel()
    private weak var activeTextField: UITextField?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        layoutViews()
        setupKeyboardNotifications()
        
    }
    
    private func setupViews() {
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
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
        print("이메일: \(emailTextField.text ?? "")")
        print("비밀번호: \(passwordTextField.text ?? "")")
        // Assuming you're within a navigation controller, push the new view controller
        let profileInfoVC = ProfileInfoViewController()
        self.navigationController?.pushViewController(profileInfoVC, animated: true)
    }
    
    // Set up the keyboard notification observers
    private func setupKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    // Text Field Delegate methods to track the active text field
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        activeTextField = nil
    }
    
    // Adjust the view when the keyboard is shown
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let bottomOfButton = signUpButton.frame.origin.y + signUpButton.frame.size.height
            let topOfKeyboard = self.view.frame.height - keyboardSize.height
            
            if bottomOfButton > topOfKeyboard {
                if self.view.frame.origin.y == 0 {
                    self.view.frame.origin.y -= (bottomOfButton - topOfKeyboard + 20)
                }
            }
        }
    }
    
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

import SwiftUI

// SwiftUI 뷰에서 UIViewController를 사용하기 위한 구조체
struct SignUpViewControllerPreview: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> SignUpViewController {
        return SignUpViewController()
    }
    
    func updateUIViewController(_ uiViewController: SignUpViewController, context: Context) {
    }
}

// Xcode 프리뷰 제공을 위한 구조체
struct SignUpViewController_Previews: PreviewProvider {
    static var previews: some View {
        SignUpViewControllerPreview()
            .edgesIgnoringSafeArea(.all)
    }
}
