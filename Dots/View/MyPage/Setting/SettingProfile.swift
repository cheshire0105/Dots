import UIKit
import SnapKit
import Firebase
import GoogleSignIn
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

class 프로필변경_화면 : UIViewController, UINavigationControllerDelegate {
    var 활성화된텍스트필드: UITextField?

    private let 뒤로가기_버튼 = {
        let button = UIButton()
        button.setImage(UIImage(named: "loginBack"), for: .selected)
        button.isSelected = !button.isSelected
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        return button
    } ()
    
    private let 페이지_제목 = {
        let label = UILabel()
        label.text = "프로필 변경"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    var 새_프로필_이미지_버튼 = {
        var imageButton = UIButton()
        imageButton.layer.cornerRadius = 44
        imageButton.backgroundColor = .clear
        imageButton.clipsToBounds = true
        imageButton.setImage(UIImage(named: "새프로필"), for: .selected)
        imageButton.setImage(UIImage(named: "새프로필"), for: .normal)
        imageButton.isSelected = !imageButton.isSelected
        return imageButton
    }()
    var 새_프로필_추가_이미지뷰 = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "새프로필사진")
        imageView.layer.cornerRadius = 10
        imageView.backgroundColor = .clear
        return imageView
    }()
    private let 새_닉네임_백 = {
        let uiView = UIView()
        uiView.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
        uiView.layer.cornerRadius = 10
        return uiView
    }()
    
    private let 새_닉네임_텍스트필드 = { ()
        let textField = UITextField()
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.lightGray,
            .font: UIFont.boldSystemFont(ofSize: 14)
        ]
        textField.attributedPlaceholder = NSAttributedString(string: "새 닉네임", attributes: attributes)
        textField.textColor = UIColor.white
        textField.tintColor = UIColor(named: "neon")
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 10
        //        textField.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
        textField.backgroundColor = UIColor.clear
        textField.textAlignment = .left
        textField.font = UIFont.boldSystemFont(ofSize: 14)
        
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        
        textField.clearButtonMode = .whileEditing
        textField.rightViewMode = .whileEditing
        
        return textField
    } ()
    var 구분선 = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "구분선")
        imageView.layer.cornerRadius = 10
        imageView.backgroundColor = .clear
        return imageView
    }()
    private let 변경_버튼 = {
        let button = UIButton()
        button.setTitle("변경", for: .selected)
        button.setTitle("변경", for: .normal)
        button.setTitleColor(UIColor(named: "neon"), for: .normal)
        button.setTitleColor(UIColor.black, for: .selected)
        button.backgroundColor = UIColor(named: "neon")
        button.isSelected = !button.isSelected
        button.layer.cornerRadius = 10
        return button
    } ()
    
    override func viewDidLoad() {
        view.backgroundColor = .black
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 0.3
        NotificationCenter.default.addObserver(self, selector: #selector(키보드가올라올때), name: UIResponder.keyboardWillShowNotification, object: nil)
        UI레이아웃()
        버튼_클릭()
        새_닉네임_텍스트필드.delegate = self
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}


extension 프로필변경_화면{
    
    private func UI레이아웃 () {
        view.addSubview(뒤로가기_버튼)
        view.addSubview(페이지_제목)
        view.addSubview(새_프로필_이미지_버튼)
        view.addSubview(새_프로필_추가_이미지뷰)
        view.addSubview(새_닉네임_백)
        view.addSubview(새_닉네임_텍스트필드)
        view.addSubview(구분선)
        view.addSubview(변경_버튼)
        
        
        뒤로가기_버튼.snp.makeConstraints { make in
            make.centerY.equalTo(페이지_제목.snp.centerY)
            make.leading.equalToSuperview().offset(16)
            make.size.equalTo(40)
        }
        페이지_제목.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.centerX.equalToSuperview()
            make.height.equalTo(44)
        }
        새_프로필_이미지_버튼.snp.makeConstraints { make in
            make.top.equalTo(페이지_제목.snp.bottom).offset(88)
            make.centerX.equalToSuperview()
            make.size.equalTo(88)
        }
        새_프로필_추가_이미지뷰.snp.makeConstraints { make in
            make.bottom.equalTo(새_프로필_이미지_버튼.snp.bottom)
            make.trailing.equalTo(새_프로필_이미지_버튼.snp.trailing)
            make.size.equalTo(24)
        }
        새_닉네임_백.snp.makeConstraints { make in
            make.top.equalTo(새_프로필_이미지_버튼.snp.bottom).offset(75)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(44)
        }
        
        새_닉네임_텍스트필드.snp.makeConstraints { make in
            make.top.equalTo(새_닉네임_백)
            make.leading.equalTo(새_닉네임_백).offset(15)
            make.trailing.equalTo(새_닉네임_백).offset(-15)
            make.height.equalTo(44)
        }
        구분선.snp.makeConstraints { make in
            make.top.equalTo(새_닉네임_텍스트필드.snp.bottom).offset(170)
        }
        변경_버튼.snp.makeConstraints { make in
            make.top.equalTo(구분선.snp.bottom).offset(15)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(32)
            make.width.equalTo(74)
        }
    }
    private func 버튼_클릭() {
        뒤로가기_버튼.addTarget(self, action: #selector(뒤로가기_버튼_클릭), for: .touchUpInside)
        새_프로필_이미지_버튼.addTarget(self, action: #selector(새_프로필_이미지_버튼_클릭), for: .touchUpInside)
    }
    @objc private func 뒤로가기_버튼_클릭() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func 새_프로필_이미지_버튼_클릭() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }

}


extension 프로필변경_화면: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == 새_닉네임_텍스트필드 {
            // 닉네임 규칙: 2~8자, 한글과 영문만 가능
            //                let 입력제한사항 = CharacterSet(charactersIn: "가-힣")
            //                let 제한사항준수 = string.rangeOfCharacter(from: 입력제한사항.inverted) == nil
            let 글자수제한 = (textField.text?.count ?? 0) + string.count
            return /*제한사항준수 &&*/ (글자수제한 <= 8)
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == 새_닉네임_텍스트필드 {
            새_닉네임_텍스트필드.becomeFirstResponder()
        }
        return true
    }
}
extension 프로필변경_화면 {
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        활성화된텍스트필드 = textField
        if textField == 새_닉네임_텍스트필드 {
            새_닉네임_백.layer.borderColor = UIColor(named: "neon")?.cgColor
            새_닉네임_백.layer.borderWidth = 1
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        활성화된텍스트필드 = nil
        if textField == 새_닉네임_텍스트필드 {
            새_닉네임_백.layer.borderColor = UIColor.clear.cgColor
        }
    }
}

extension 프로필변경_화면 {
        
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
            self.view.frame.origin.y = 0
        }
        
        @objc func 키보드가올라올때(notification: NSNotification) {
            guard let 키보드크기 = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
                  let 활성화된텍스트필드 = 활성화된텍스트필드 else {
                return
            }
            
            let 텍스트필드끝 = 활성화된텍스트필드.frame.origin.y + 활성화된텍스트필드.frame.size.height
            let 키보드시작 = view.frame.size.height - 키보드크기.height
            
            if 텍스트필드끝 > 키보드시작 {
                let 이동거리 = 키보드시작 - 텍스트필드끝
                view.frame.origin.y = 이동거리
            }
        }
    }



    private func 회원가입_이미지_업로드(_ 이미지: UIImage, completion: @escaping (Result<URL, Error>) -> Void) {
        guard let 이미지데이터 = 이미지.jpegData(compressionQuality: 0.5) else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to convert image to data"])))
            return
        }

        let 이미지생성 = "\(UUID().uuidString).jpg"

        let 스토리지_참조 = Storage.storage().reference().child("profile_images/\(이미지생성)")
        스토리지_참조.putData(이미지데이터, metadata: nil) { (metadata, 에러) in
            if let 이미지업로드실패 = 에러 {
                completion(.failure(이미지업로드실패))
            } else {
                스토리지_참조.downloadURL { (url, error) in
                    if let url = url {
                        completion(.success(url))
                    } else {
                        completion(.failure(error ?? NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to get image URL"])))
                    }
                }
            }
        }
    }







//사진라이브러리 접근관련 Extension
extension 프로필변경_화면: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            새_프로필_이미지_버튼.setImage(selectedImage, for: .selected)
        }

        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

class 사진_라이브러리: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
}


