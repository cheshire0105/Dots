//
//  ProfileInfoViewController.swift
//  Dots
//
//  Created by cheshire on 11/5/23.
//

import UIKit

class ProfileInfoViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UIGestureRecognizerDelegate {
    // UI Components
    private let userIdLabel = UILabel()
    private let userIdTextField = UITextField()
    private let usernameLabel = UILabel()
    private let usernameTextField = UITextField()
    private let introductionLabel = UILabel()
    private let introductionTextView = UITextView()
    private let favoriteMuseumLabel = UILabel()
    private let favoriteMuseumTextField = UITextField()
    private let favoriteArtistLabel = UILabel()
    private let favoriteArtistTextField = UITextField()
    private let favoriteArtworkLabel = UILabel()
    private let favoriteArtworkTextField = UITextField()
    private let saveButton = UIButton()
    private weak var activeTextField: UITextField? // 여기에 추가됨


    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true

        userIdTextField.delegate = self
        usernameTextField.delegate = self
        favoriteMuseumTextField.delegate = self
        favoriteArtistTextField.delegate = self
        favoriteArtworkTextField.delegate = self
        introductionTextView.delegate = self
        setupLabels()
        setupViews()
        layoutViews()
        setupKeyboardNotifications()
        setupCustomBackButton()

    }

    private func setupCustomBackButton() {
        let backImage = UIImage(named: "backButton") // 'back_icon'은 이미지 에셋의 이름입니다.
        let backButton = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(backButtonTapped))
        backButton.tintColor = .white
        navigationItem.leftBarButtonItem = backButton
    }

    @objc func backButtonTapped() {
        // 네비게이션 스택에서 이전 뷰 컨트롤러로 이동
        navigationController?.popViewController(animated: true)
    }

    private func setupLabels() {
        userIdLabel.text = "아이디"
        userIdLabel.textColor = .white
        usernameLabel.text = "닉네임"
        usernameLabel.textColor = .white
        introductionLabel.text = "소개글"
        introductionLabel.textColor = .white
        favoriteMuseumLabel.text = "자주 가는 미술관"
        favoriteMuseumLabel.textColor = .white
        favoriteArtistLabel.text = "가장 좋아하는 아티스트"
        favoriteArtistLabel.textColor = .white
        favoriteArtworkLabel.text = "가장 좋아하는 그림"
        favoriteArtworkLabel.textColor = .white
    }

    private func setupViews() {
        view.backgroundColor = .black

        // Setup text field styles
        let textFieldStyle: (UITextField) -> Void = { textField in
            textField.borderStyle = .roundedRect
            textField.backgroundColor = .lightGray
            textField.textColor = .white
            textField.attributedPlaceholder = NSAttributedString(
                string: textField.placeholder ?? "",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
            )
        }

        // Apply style and set up each text field
        [userIdTextField, usernameTextField, favoriteMuseumTextField, favoriteArtistTextField, favoriteArtworkTextField].forEach { textField in
            textFieldStyle(textField)
        }

        // Configure Text View
        introductionTextView.backgroundColor = .lightGray
        introductionTextView.textColor = .white
        introductionTextView.layer.borderColor = UIColor.lightGray.cgColor
        introductionTextView.layer.borderWidth = 1.0
        introductionTextView.layer.cornerRadius = 5.0



        // Configure Text View
        introductionTextView.layer.borderColor = UIColor.gray.cgColor
        introductionTextView.layer.borderWidth = 1.0
        introductionTextView.layer.cornerRadius = 5.0

        // Configure Save Button
        saveButton.setTitle("저장하기", for: .normal)
        saveButton.backgroundColor = .darkGray
        saveButton.layer.cornerRadius = 5
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)

        // Add all labels and fields to the view
        // (You would add each one individually, similar to the layoutViews method below)
    }

    private func layoutViews() {
        // Layout for Labels and Fields, you can use a vertical stack view for each label/field pair
        let userInfoStackView = UIStackView(arrangedSubviews: [userIdLabel, userIdTextField])
        let userNameStackView = UIStackView(arrangedSubviews: [usernameLabel, usernameTextField])
        let introStackView = UIStackView(arrangedSubviews: [introductionLabel, introductionTextView])
        let museumStackView = UIStackView(arrangedSubviews: [favoriteMuseumLabel, favoriteMuseumTextField])
        let artistStackView = UIStackView(arrangedSubviews: [favoriteArtistLabel, favoriteArtistTextField])
        let artworkStackView = UIStackView(arrangedSubviews: [favoriteArtworkLabel, favoriteArtworkTextField])

        // Common stack view setup
        let stackViews = [userInfoStackView, userNameStackView, introStackView, museumStackView, artistStackView, artworkStackView]
        for stackView in stackViews {
            stackView.axis = .vertical
            stackView.spacing = 4
            view.addSubview(stackView)
            stackView.snp.makeConstraints { make in
                make.left.right.equalTo(view.safeAreaLayoutGuide).inset(20)
            }
        }

        // Specific field setup, like setting textView's height
        introductionTextView.snp.makeConstraints { make in
            make.height.equalTo(100)
        }

        // Save Button Layout
        view.addSubview(saveButton)
        saveButton.snp.makeConstraints { make in
            make.left.right.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.height.equalTo(50)
        }

        // Align stack views
        userInfoStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
        }

        userNameStackView.snp.makeConstraints { make in
            make.top.equalTo(userInfoStackView.snp.bottom).offset(20)
        }

        introStackView.snp.makeConstraints { make in
            make.top.equalTo(userNameStackView.snp.bottom).offset(20)
        }

        museumStackView.snp.makeConstraints { make in
            make.top.equalTo(introductionTextView.snp.bottom).offset(20)
        }

        artistStackView.snp.makeConstraints { make in
            make.top.equalTo(museumStackView.snp.bottom).offset(20)
        }

        artworkStackView.snp.makeConstraints { make in
            make.top.equalTo(artistStackView.snp.bottom).offset(20)
            make.bottom.lessThanOrEqualTo(saveButton.snp.top).offset(-20)
        }
    }

    @objc private func saveButtonTapped() {
        // UserDefaults에 로그인 상태를 true로 저장합니다.
        UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
        UserDefaults.standard.synchronize()

        // 현재 프로필 정보 뷰 컨트롤러를 닫고 메인 화면으로 이동합니다.
        dismiss(animated: true, completion: {
            if let delegate = self.view.window?.windowScene?.delegate as? SceneDelegate, let window = delegate.window {
                let mainTabBar = GlassTabBar()
                window.rootViewController = mainTabBar
                window.makeKeyAndVisible()
            }
        })
    }



    private func setupKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
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
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        if let activeTextField = activeTextField {
            let bottomOfTextField = activeTextField.convert(activeTextField.bounds, to: self.view).maxY
            let topOfKeyboard = self.view.frame.height - keyboardSize.height
            if bottomOfTextField > topOfKeyboard {
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.frame.origin.y = 0 - (bottomOfTextField - topOfKeyboard + 10) // Adjust the value as needed
                })
            }
        }
    }

    // Adjust the view back when the keyboard is hidden
    @objc private func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.3, animations: {
            self.view.frame.origin.y = 0
        })
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
struct ProfileInfoViewControllerPreview: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ProfileInfoViewController {
        return ProfileInfoViewController()
    }

    func updateUIViewController(_ uiViewController: ProfileInfoViewController, context: Context) {
    }
}

// Xcode 프리뷰 제공을 위한 구조체
struct ProfileInfoViewController_Previews: PreviewProvider {
    static var previews: some View {
        ProfileInfoViewControllerPreview()
            .edgesIgnoringSafeArea(.all)
    }
}
