import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
import GoogleSignIn

class 이메일변경_화면 : UIViewController, UIGestureRecognizerDelegate {
    var 활성화된텍스트필드: UITextField?

     let 뒤로가기_버튼 = {
        let button = UIButton()
        button.setImage(UIImage(named: "loginBack"), for: .selected)
        button.isSelected = !button.isSelected
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        return button
    } ()
    
     let 페이지_제목 = {
        let label = UILabel()
        label.text = "이메일 변경"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
     let 현재_이메일_백 = {
        let uiView = UIView()
        uiView.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
        uiView.layer.cornerRadius = 10
        return uiView
    }()
     let 현재_이메일_텍스트필드 = { ()
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
     let 새_이메일_백 = {
        let uiView = UIView()
        uiView.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
        uiView.layer.cornerRadius = 10
        return uiView
    }()
    
     let 새_이메일_텍스트필드 = { ()
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
     let 변경_버튼 = {
        let button = UIButton()
        button.setTitle("변경", for: .selected)
        button.setTitle("변경", for: .normal)
        button.setTitleColor(UIColor(named: "neon"), for: .normal)
        button.setTitleColor(UIColor.black, for: .selected)
         button.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 16)

        button.backgroundColor = UIColor(named: "neon")
        button.isSelected = !button.isSelected
        button.layer.cornerRadius = 10
        return button
    } ()
    override func viewDidLoad() {
        view.backgroundColor = .black
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 0.3
        tabBarController?.tabBar.isHidden = true

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
        현재_이메일_텍스트필드.delegate = self
        새_이메일_텍스트필드.delegate = self
        
        if let currentLoggedInEmail = getCurrentLoggedInEmail() {
               현재_이메일_텍스트필드.text = currentLoggedInEmail
        }
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        
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



