import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
import GoogleSignIn

class 이메일변경_화면 : UIViewController {
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
        label.text = "이메일 변경"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    private let 현재_이메일_백 = {
        let uiView = UIView()
        uiView.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
        uiView.layer.cornerRadius = 10
        return uiView
    }()
    private let 현재_이메일_텍스트필드 = { ()
        let textField = UITextField()
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.lightGray,
            .font: UIFont.boldSystemFont(ofSize: 14)
        ]
        textField.attributedPlaceholder = NSAttributedString(string: "사용중인 이메일", attributes: attributes)
        textField.textColor = UIColor.white
        textField.tintColor = UIColor(named: "neon")
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 25
        //        textField.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
        textField.backgroundColor = UIColor.clear
        textField.textAlignment = .left
        textField.font = UIFont.boldSystemFont(ofSize: 14)
        
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        
        textField.clearButtonMode = .whileEditing
        textField.rightViewMode = .whileEditing
        textField.isEnabled = false

        return textField
    } ()
    private let 새_이메일_백 = {
        let uiView = UIView()
        uiView.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
        uiView.layer.cornerRadius = 10
        return uiView
    }()
    
    private let 새_이메일_텍스트필드 = { ()
        let textField = UITextField()
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.lightGray,
            .font: UIFont.boldSystemFont(ofSize: 14)
        ]
        textField.attributedPlaceholder = NSAttributedString(string: "새 이메일", attributes: attributes)
        textField.textColor = UIColor.white
        textField.tintColor = UIColor(named: "neon")
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 25
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
        if let 제공업체 = Auth.auth().currentUser?.providerData {
            for 유저정보 in 제공업체 {
                if 유저정보.providerID == "google.com" {
                    // Google에 연동된 계정일 경우 알림 표시
                    showAlert(message: "구글 연동 계정입니다")
                    break
                }
            }
        }
        UI레이아웃()
        버튼_클릭()
        화면_제스쳐_실행()
        현재_이메일_텍스트필드.delegate = self
        새_이메일_텍스트필드.delegate = self
        
        if let currentLoggedInEmail = getCurrentLoggedInEmail() {
               현재_이메일_텍스트필드.text = currentLoggedInEmail
        }
    }
    private func showAlert(message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "확인", style: .default) { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(confirmAction)
        
        present(alertController, animated: true, completion: nil)
    }
    func getCurrentLoggedInEmail() -> String? {
        if let user = Auth.auth().currentUser {
               return user.email
           }
           return nil
       }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}


extension 이메일변경_화면{
    
    private func UI레이아웃 () {
        view.addSubview(뒤로가기_버튼)
        view.addSubview(페이지_제목)
        view.addSubview(현재_이메일_백)
        view.addSubview(현재_이메일_텍스트필드)
        view.addSubview(새_이메일_백)
        view.addSubview(새_이메일_텍스트필드)
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
        현재_이메일_백.snp.makeConstraints { make in
            make.top.equalTo(페이지_제목.snp.bottom).offset(86)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(44)
        }
        현재_이메일_텍스트필드.snp.makeConstraints { make in
            make.top.equalTo(현재_이메일_백)
            make.leading.equalTo(현재_이메일_백).offset(15)
            make.trailing.equalTo(현재_이메일_백).offset(-15)
            make.height.equalTo(44)
        }
        
        새_이메일_백.snp.makeConstraints { make in
            make.top.equalTo(현재_이메일_텍스트필드.snp.bottom).offset(60)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(44)
        }
        새_이메일_텍스트필드.snp.makeConstraints { make in
            make.top.equalTo(새_이메일_백)
            make.leading.equalTo(새_이메일_백).offset(15)
            make.trailing.equalTo(새_이메일_백).offset(-15)
            make.height.equalTo(44)
        }
        구분선.snp.makeConstraints { make in
            make.top.equalTo(새_이메일_텍스트필드.snp.bottom).offset(180)
        }
        변경_버튼.snp.makeConstraints { make in
            make.top.equalTo(구분선.snp.bottom).offset(15)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(32)
            make.width.equalTo(74)
        }
    }
}


extension 이메일변경_화면 {
    
    private func 버튼_클릭() {
        뒤로가기_버튼.addTarget(self, action: #selector(뒤로가기_버튼_클릭), for: .touchUpInside)
        변경_버튼.addTarget(self, action: #selector(변경_버튼_클릭), for: .touchUpInside)
        
    }
    @objc private func 뒤로가기_버튼_클릭() {
        navigationController?.popViewController(animated: true)
    }
}

extension 이메일변경_화면 {

    @objc func 변경_버튼_클릭() {
           guard let 새이메일 = 새_이메일_텍스트필드.text, !새이메일.isEmpty else {
            print("새 이메일 택스트필드 빈값")
               return
           }
           
           updateEmail(새이메일: 새이메일) { 에러 in
               if let 에러 = 에러 {
                   print("이메일 업데이트 오류: \(에러.localizedDescription)")
               } else {
                   print("이메일이 성공적으로 업데이트되었습니다.")
               }
           }
       }
}
extension 이메일변경_화면 {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
         if textField == 현재_이메일_텍스트필드 {
            // 이메일 규칙: 숫자 영문 소문자 - . _ 사용 가능
            let 입력제한사항 = CharacterSet(charactersIn: "0123456789abcdefghijklmnopqrstuvwxyz.@_-")
            let 제한사항준수 = string.rangeOfCharacter(from: 입력제한사항.inverted) == nil
            return 제한사항준수
        }
        else if textField == 새_이메일_텍스트필드 {
            // 이메일 규칙: 숫자 영문 소문자 - . _ 사용 가능
            let 입력제한사항 = CharacterSet(charactersIn: "0123456789abcdefghijklmnopqrstuvwxyz.@_-")
            let 제한사항준수 = string.rangeOfCharacter(from: 입력제한사항.inverted) == nil
            return 제한사항준수
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == 현재_이메일_텍스트필드 {
            새_이메일_텍스트필드.becomeFirstResponder()
        } else if textField == 새_이메일_텍스트필드 {
            새_이메일_텍스트필드.resignFirstResponder()
        }
        return true
    }
}

extension 이메일변경_화면: UITextFieldDelegate {
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        활성화된텍스트필드 = textField
        if textField == 현재_이메일_텍스트필드 {
            현재_이메일_백.layer.borderColor = UIColor(named: "neon")?.cgColor
            현재_이메일_백.layer.borderWidth = 1
        }
        else if textField == 새_이메일_텍스트필드 {
            새_이메일_백.layer.borderColor = UIColor(named: "neon")?.cgColor
            새_이메일_백.layer.borderWidth = 1
        }
      
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        활성화된텍스트필드 = nil
        if textField == 현재_이메일_텍스트필드 {
            새_이메일_백.layer.borderColor = UIColor.clear.cgColor
        }
        else if textField == 새_이메일_텍스트필드 {
            새_이메일_백.layer.borderColor = UIColor.clear.cgColor
        }
    }
}


extension 이메일변경_화면 {
        
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

extension 이메일변경_화면 {
    
    func 화면_제스쳐_실행 () {
        let 화면_제스쳐 = UISwipeGestureRecognizer(target: self, action: #selector(화면_제스쳐_뒤로_가기))
        화면_제스쳐.direction = .right
        view.addGestureRecognizer(화면_제스쳐)
    }
    @objc private func 화면_제스쳐_뒤로_가기() {
        navigationController?.popViewController(animated: true)
    }
    
}
extension 이메일변경_화면 {
    
    func updateEmail(새이메일: String, completion: @escaping (Error?) -> Void) {
        if let 접속_유저 = Auth.auth().currentUser {
            접속_유저.updateEmail(to: 새이메일) { (애러) in
                if let 애러 = 애러 {
                    completion(애러)
                } else {
                    self.updateFirestoreUserEmail(uid: 접속_유저.uid, newEmail: 새이메일, completion: completion)
                }
            }
        } else {
            let error = NSError(domain: "Authentication", code: 0, userInfo: [NSLocalizedDescriptionKey: "사용자가 로그인되어 있지 않습니다."])
            completion(error)
        }
    }
    
    
    private func updateFirestoreUserEmail(uid: String, newEmail: String, completion: @escaping (Error?) -> Void) {
        let 파이어스토어 = Firestore.firestore()
        let 문서참조 = 파이어스토어.collection("유저_데이터_관리")
        
        문서참조.whereField("uid", isEqualTo: uid).getDocuments { (querySnapshot, 애러) in
            if let 애러 = 애러 {
                completion(애러)
                return
            }
            
            guard let 문서 = querySnapshot?.documents.first else {
                let error = NSError(domain: "Firestore", code: 0, userInfo: [NSLocalizedDescriptionKey: "해당 UID와 일치하는 문서를 찾을 수 없습니다."])
                completion(error)
                return
            }
            
            let documentID = 문서.documentID
            문서참조.document(documentID).updateData(["이메일": newEmail]) { (error) in
                completion(error)
            }
        }
    }
}




//    func updateEmail(newEmail: String, completion: @escaping (Error?) -> Void) {
//        // 현재 로그인된 사용자 가져오기
//        if let user = Auth.auth().currentUser {
//            // 새 이메일로 업데이트 요청
//            user.updateEmail(to: newEmail) { (error) in
//                if let error = error {
//                    // 이메일 업데이트 오류
//                    completion(error)
//                } else {
//                    // 이메일 업데이트가 성공적으로 진행됐을 때,
//                    // 새 이메일 확인 메일을 보낼 것인지를 설정
//                    let shouldSendVerificationEmail = true
//
//                    if shouldSendVerificationEmail {
//                        // 새 이메일 확인 메일을 보내는 함수 호출
//                        self.sendVerificationEmail(newEmail: newEmail, completion: completion)
//                    } else {
//                        // 별도의 확인 메일을 보내지 않는 경우
//                        // Firestore에서 사용자 정보 업데이트
//                        self.updateFirestoreUserEmail(uid: user.uid, newEmail: newEmail, completion: completion)
//                    }
//                }
//            }
//        } else {
//            let error = NSError(domain: "Authentication", code: 0, userInfo: [NSLocalizedDescriptionKey: "사용자가 로그인되어 있지 않습니다."])
//            completion(error)
//        }
//    }
//
//    private func sendVerificationEmail(newEmail: String, completion: @escaping (Error?) -> Void) {
//        if let user = Auth.auth().currentUser {
//            // 새 이메일에 대한 확인 메일을 보내는 함수 호출
//            user.sendEmailVerification { (error) in
//                if let error = error {
//                    // 확인 메일 보내기 오류
//                    completion(error)
//                } else {
//                    // 확인 메일이 성공적으로 보내졌을 때,
//                    // Firestore에서 사용자 정보 업데이트
//                    self.updateFirestoreUserEmail(uid: user.uid, newEmail: newEmail, completion: completion)
//                }
//            }
//        } else {
//            let error = NSError(domain: "Authentication", code: 0, userInfo: [NSLocalizedDescriptionKey: "사용자가 로그인되어 있지 않습니다."])
//            completion(error)
//        }
//    }
//
