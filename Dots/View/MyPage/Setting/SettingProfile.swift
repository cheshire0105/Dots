import UIKit
import Toast_Swift
import SnapKit
import Firebase
import GoogleSignIn
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

class 프로필변경_화면 : UIViewController, UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    var 활성화된텍스트필드: UITextField?
    var imageURL: URL?
    
    
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
     let 새_닉네임_백 = {
        let uiView = UIView()
        uiView.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
        uiView.layer.cornerRadius = 10
        return uiView
    }()
    
     let 새_닉네임_텍스트필드 = { ()
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
    override func viewWillAppear(_ animated: Bool) {
        현재_유저_프로필이미지_적용하기()
    }
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
                } else if 유저정보.providerID == "apple.com" {
                    // Apple에 연동된 계정일 경우 알림 표시
                    showAlert(message: "애플 연동 계정입니다")
                    break
                }
            }
        }
        캐시된_유저_데이터_마이페이지_적용하기()
        
        
        UI레이아웃()
        버튼_클릭()
        새_닉네임_텍스트필드.delegate = self
        
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
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}






