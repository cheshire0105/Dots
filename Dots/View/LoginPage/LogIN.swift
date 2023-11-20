import UIKit
import FirebaseAuth
import SnapKit

class 로그인_뷰컨트롤러 : UIViewController, UINavigationControllerDelegate, UITextFieldDelegate {

    var 활성화된텍스트필드: UITextField?

    //페이지 제목
    private let 제목_라벨 = {
        let label = UILabel()
        label.text = "LOG IN"
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 40)
        
        return label
    } ()
    let 뒤로가기_버튼 = {
        let button = UIButton()
        button.setImage(UIImage(named: "loginBack"), for: .selected)
        button.setImage(UIImage(named: ""), for: .normal)
        button.isSelected = !button.isSelected
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        return button
    } ()
    //이메일 텍스트필드
    private let 로그인_이메일_텍스트필드 = { ()
        let textField = UITextField()
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.lightGray,
            .font: UIFont.boldSystemFont(ofSize: 14)
        ]
        textField.attributedPlaceholder = NSAttributedString(string: "이메일", attributes: attributes)
        textField.textColor = UIColor.white
        textField.tintColor = UIColor.lightGray
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 25
        textField.backgroundColor = .darkGray
        textField.textAlignment = .left
        textField.font = UIFont.boldSystemFont(ofSize: 14)
        return textField
    } ()
    //비밀번호 텍스트필드
    private let 로그인_비밀번호_텍스트필드 = { ()
        let textField = UITextField()
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.lightGray,
            .font: UIFont.boldSystemFont(ofSize: 14)
        ]
        textField.attributedPlaceholder = NSAttributedString(string: "비밀번호", attributes: attributes)
        textField.textColor = UIColor.white
        textField.tintColor = UIColor.lightGray
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 25
        textField.backgroundColor = .darkGray
        textField.textAlignment = .left
        textField.font = UIFont.boldSystemFont(ofSize: 14)
        return textField
    } ()
    //로그인 버튼
    private let 로그인_버튼 = {
        let button = UIButton()
        button.layer.cornerRadius = 30
        button.backgroundColor = UIColor(named: "neon")
        button.isSelected = !button.isSelected
        button.setTitle("로그인", for: .normal)
        button.setTitle("로그인", for: .selected)
        button.setTitleColor(UIColor(named: "neon"), for: .normal)
        button.setTitleColor(UIColor.black, for: .selected)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.titleLabel?.textAlignment = .center
        return button
    }()
    private let 이메일_백 = {
        let uiView = UIView()
        uiView.backgroundColor = .darkGray
        uiView.layer.cornerRadius = 25
        return uiView
    }()
    private let 비밀번호_백 = {
        let uiView = UIView()
        uiView.backgroundColor = .darkGray
        uiView.layer.cornerRadius = 25
        return uiView
    }()
    private let 간편로그인_라벨 = {
        let label = UILabel()
        label.text = "간편 로그인"
        label.textColor = UIColor.darkGray
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        
        return label
    } ()
   
    let 구글_버튼 = {
        let button = UIButton()
        button.setImage(UIImage(named: "google"), for: .selected)
        button.setImage(UIImage(named: "google"), for: .normal)
        button.isSelected = !button.isSelected
        button.backgroundColor = UIColor(named: "neon")
        button.layer.cornerRadius = 30
        button.contentMode = .scaleToFill
        return button
    } ()
    let 애플_버튼 = {
        let button = UIButton()
        button.setImage(UIImage(named: "apple"), for: .selected)
        button.setImage(UIImage(named: "apple"), for: .normal)
        button.isSelected = !button.isSelected
        button.backgroundColor = UIColor(named: "neon")
        button.layer.cornerRadius = 30
        button.contentMode = .scaleToFill

        return button
    } ()
    let 트위터_버튼 = {
        let button = UIButton()
        button.setImage(UIImage(named: "twitter"), for: .selected)
        button.setImage(UIImage(named: "twitter"), for: .normal)
        button.isSelected = !button.isSelected
        button.backgroundColor = UIColor(named: "neon")
        button.layer.cornerRadius = 30
        button.contentMode = .scaleToFill

        return button
    } ()

    override func viewDidLoad() {
        view.backgroundColor = .black
        navigationItem.hidesBackButton = true
        navigationController?.isNavigationBarHidden = true
        UI레이아웃()
        버튼_클릭()

        로그인_이메일_텍스트필드.delegate = self
               로그인_비밀번호_텍스트필드.delegate = self

               // 키보드 이벤트 리스너 등록
               NotificationCenter.default.addObserver(self, selector: #selector(키보드가올라올때), name: UIResponder.keyboardWillShowNotification, object: nil)
    }

    @objc func 키보드가올라올때(notification: NSNotification) {
        if let 키보드크기 = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue, let 활성화된텍스트필드 = 활성화된텍스트필드 {
            let 화면끝 = view.frame.size.height
            let 텍스트필드끝 = 활성화된텍스트필드.frame.origin.y + 활성화된텍스트필드.frame.size.height
            let 키보드시작 = 화면끝 - 키보드크기.height

            if 텍스트필드끝 > 키보드시작 {
                view.frame.origin.y = -텍스트필드끝 + 키보드시작
            }
        }
    }


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }


    deinit {
        NotificationCenter.default.removeObserver(self)
    }


}

//레이아웃
extension 로그인_뷰컨트롤러 {
    func UI레이아웃() {
        view.addSubview(뒤로가기_버튼)
        view.addSubview(제목_라벨)
        view.addSubview(이메일_백)
        view.addSubview(비밀번호_백)
        view.addSubview(로그인_이메일_텍스트필드)
        view.addSubview(로그인_비밀번호_텍스트필드)
        view.addSubview(로그인_버튼)
        view.addSubview(간편로그인_라벨)
        view.addSubview(구글_버튼)
        view.addSubview(애플_버튼)
        view.addSubview(트위터_버튼)
        
        뒤로가기_버튼.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(75)
            make.leading.equalToSuperview().offset(24)
            make.size.equalTo(40)
        }
        
        제목_라벨.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(264)
            make.leading.equalToSuperview().offset(32)
            
        }
        이메일_백.snp.makeConstraints { make in
            make.top.equalTo(제목_라벨.snp.bottom).offset(73)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(58)
        }
        로그인_이메일_텍스트필드.snp.makeConstraints { make in
            make.height.equalTo(58)
            make.top.equalTo(이메일_백)
            make.leading.equalTo(이메일_백).offset(30)
            make.trailing.equalTo(이메일_백).offset(-80)
        }
        비밀번호_백.snp.makeConstraints { make in
            make.top.equalTo(로그인_이메일_텍스트필드.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(58)
        }
        로그인_비밀번호_텍스트필드.snp.makeConstraints { make in
            make.height.equalTo(58)
            make.top.equalTo(비밀번호_백)
            make.leading.equalTo(비밀번호_백).offset(30)
            make.trailing.equalTo(비밀번호_백).offset(-80)
        }
        로그인_버튼.snp.makeConstraints { make in
            make.top.equalTo(로그인_비밀번호_텍스트필드.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(64)
        }
        간편로그인_라벨.snp.makeConstraints { make in
            make.top.equalTo(로그인_버튼.snp.bottom).offset(46)
            make.centerX.equalToSuperview()
        }
        구글_버튼.snp.makeConstraints { make in
            make.centerY.equalTo(애플_버튼)
            make.trailing.equalTo(애플_버튼.snp.leading).offset(-20)
            make.size.equalTo(60)
        }
        애플_버튼.snp.makeConstraints { make in
            make.top.equalTo(간편로그인_라벨.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.size.equalTo(60)
        }
        트위터_버튼.snp.makeConstraints { make in
            make.centerY.equalTo(애플_버튼)
            make.leading.equalTo(애플_버튼.snp.trailing).offset(20)
            make.size.equalTo(60)
        }
    }
}
//버튼클릭
extension 로그인_뷰컨트롤러 {
    
    private func 버튼_클릭() {
        뒤로가기_버튼.addTarget(self, action: #selector(뒤로가기_버튼_클릭), for: .touchUpInside)
        로그인_버튼.addTarget(self, action: #selector(로그인_버튼_클릭), for: .touchUpInside)
    }
    @objc func 뒤로가기_버튼_클릭() {
        print("뒤로가기")
        let 처음화면_이동 = 로그인_회원가입_뷰컨트롤러()
        self.navigationController?.pushViewController(처음화면_이동, animated: true)
        navigationItem.hidesBackButton = true
    }
    @objc func 로그인_버튼_클릭() {
        print("메인 전시 페이지로 이동")
        guard let 이메일 = 로그인_이메일_텍스트필드.text, let 비밀번호 = 로그인_비밀번호_텍스트필드.text else {
            return
        }
        
        Auth.auth().signIn(withEmail: 이메일, password: 비밀번호) { [weak self] authResult, 에러 in
            guard let self = self else { return }
            
            if let 로그인_실패 = 에러 {
                print("로그인 실패: \(로그인_실패.localizedDescription)")
            } else {
                print("로그인 성공")
                
                UserDefaults.standard.set(true, forKey: "isUserLoggedIn")

                
                let 메인화면_이동 = TabBar()
                self.navigationController?.pushViewController(메인화면_이동, animated: true)
                self.navigationItem.hidesBackButton = true
            }
        }
    }
}
