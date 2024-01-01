import UIKit
import Toast_Swift
import FirebaseAuth
import FirebaseFirestore

class 비밀번호변경_화면 : UIViewController, UIGestureRecognizerDelegate {
    
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
        label.text = "비밀번호 변경"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
     let 현재_비밀번호_백 = {
        let uiView = UIView()
        uiView.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
        uiView.layer.cornerRadius = 10
        return uiView
    }()
    
    
     let 현재_비밀번호_텍스트필드 = { ()
        let textField = UITextField()
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.darkGray,
            .font: UIFont.boldSystemFont(ofSize: 14)
        ]
        textField.attributedPlaceholder = NSAttributedString(string: "현재 비밀번호", attributes: attributes)
        textField.textColor = UIColor.white
        textField.tintColor = UIColor(named: "neon")
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 10
        
        textField.backgroundColor = UIColor.clear
        textField.textAlignment = .left
        textField.font = UIFont.boldSystemFont(ofSize: 14)
        
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        
        textField.clearButtonMode = .whileEditing
        textField.rightViewMode = .whileEditing
        textField.isEnabled = false
        textField.isSecureTextEntry = true
        return textField
    } ()
    
    
     let 새_비밀번호_백 = {
        let uiView = UIView()
        uiView.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
        uiView.layer.cornerRadius = 10
        return uiView
    }()
    
    
     let 새_비밀번호_텍스트필드 = { ()
        let textField = UITextField()
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.darkGray,
            .font: UIFont.boldSystemFont(ofSize: 14)
        ]
        textField.attributedPlaceholder = NSAttributedString(string: "8~16자사이의 영문(소문자) + 숫자를 입력해주세요", attributes: attributes)
        textField.textColor = UIColor.white
        textField.tintColor = UIColor(named: "neon")
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 10
        
        textField.backgroundColor = UIColor.clear
        textField.textAlignment = .left
        textField.font = UIFont.boldSystemFont(ofSize: 14)
        
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        
//        textField.clearButtonMode = .whileEditing
        textField.rightViewMode = .whileEditing
        textField.isSecureTextEntry = true
        
        return textField
    } ()
    
    
     let 새_비밀번호_확인_백 = {
        let uiView = UIView()
        uiView.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
        uiView.layer.cornerRadius = 10
        return uiView
    }()
    
    
     let 새_비밀번호_확인_텍스트필드 = {
        let textField = UITextField()
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.darkGray,
            .font: UIFont.boldSystemFont(ofSize: 14)
        ]
        textField.attributedPlaceholder = NSAttributedString(string: "8~16자사이의 영문(소문자) + 숫자를 입력해주세요", attributes: attributes)
        textField.textColor = UIColor.white
        textField.tintColor = UIColor(named: "neon")
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 10
        
        textField.backgroundColor = UIColor.clear
        textField.textAlignment = .left
        textField.font = UIFont.boldSystemFont(ofSize: 14)
        
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        
//        textField.clearButtonMode = .whileEditing
        textField.rightViewMode = .whileEditing
        textField.isSecureTextEntry = true
        
        return textField
    } ()
    
    
    var 구분선 = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "구분선")
        imageView.layer.cornerRadius = 10
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    
     let 현재비밀번호_라벨 = {
        let label = UILabel()
        label.text = "현재 비밀번호"
        label.textColor = UIColor.darkGray
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .left
        return label
    }()
    
    
     let 새비밀번호_라벨 = {
        let label = UILabel()
        label.text = "새 비밀번호 입력"
        label.textColor = UIColor.darkGray
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .left
        return label
    }()
    
    
     let 새비밀번호확인_라벨 = {
        let label = UILabel()
        label.text = "새 비밀번호 확인"
        label.textColor = UIColor.darkGray
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .left
        return label
    }()
    
    
     let 변경_버튼 = {
        let button = UIButton()
        button.setTitle("변경", for: .selected)
        button.setTitle("변경", for: .normal)
        button.setTitleColor(UIColor(named: "neon"), for: .normal)
        button.setTitleColor(UIColor.black, for: .selected)
        button.backgroundColor = UIColor(named: "neon")
        button.isSelected = !button.isSelected
         button.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 16)

        button.layer.cornerRadius = 10
        return button
    } ()
     let 현재_비밀번호_표시_온오프 = {
        let button = UIButton()
        button.setImage(UIImage(named: "passwordOFF"), for: .normal)
        return button
    }()
     let 새_비밀번호_표시_온오프 = {
        let button = UIButton()
        button.setImage(UIImage(named: "passwordOFF"), for: .normal)
        return button
    }()
     let 새_비밀번호_확인_표시_온오프 = {
        let button = UIButton()
        button.setImage(UIImage(named: "passwordOFF"), for: .normal)
        return button
    }()
    override func viewDidLoad() {
        view.backgroundColor = .black
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 0.3
        tabBarController?.tabBar.isHidden = true

        NotificationCenter.default.addObserver(self, selector: #selector(키보드가올라올때), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        if let 제공업체 = Auth.auth().currentUser?.providerData {
            for 유저정보 in 제공업체 {
                if 유저정보.providerID == "google.com" {
                    // Google 연동 계정이면 알럿을 바로 띄우고 되돌려보냄
                    showAlert(message: "구글 연동 계정입니다")
                    break
                }
            }
        }
        
        UI레이아웃()
        버튼_클릭()
        
        새_비밀번호_텍스트필드.delegate = self
        현재_비밀번호_텍스트필드.delegate = self
        새_비밀번호_확인_텍스트필드.delegate = self
        
        if let 유저 = Auth.auth().currentUser {
            for profile in 유저.providerData {
                // 계정의 제공업체를 출력하기위함
                let 제공업체UID = profile.providerID
                print("Provider ID: \(제공업체UID)")
            }
        }
        
        현재_비밀번호_실시간_조회_불러오기()
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        
    }
     func showAlert(message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "확인", style: .default) { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(confirmAction)
        
        present(alertController, animated: true, completion: nil)
    }
     func 확인알럿(message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "확인", style: .default)
        alertController.addAction(confirmAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    deinit {
        // 메모리 해제 시 리스너 제거
        NotificationCenter.default.removeObserver(self)
    }
}

