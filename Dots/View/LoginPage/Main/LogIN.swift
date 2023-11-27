import UIKit
import FirebaseAuth
import FirebaseFirestore
import GoogleSignIn
import FirebaseCore
import SnapKit

class 로그인_뷰컨트롤러 : UIViewController, UINavigationControllerDelegate {
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
    //비밀번호 텍스트필드
    private let 로그인_비밀번호_텍스트필드 = { ()
        let textField = UITextField()
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.lightGray,
            .font: UIFont.boldSystemFont(ofSize: 14)
        ]
        textField.attributedPlaceholder = NSAttributedString(string: "비밀번호", attributes: attributes)
        textField.textColor = UIColor.white
        textField.tintColor = UIColor(named: "neon")
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 25
        //        textField.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
        textField.backgroundColor = UIColor.clear
        textField.textAlignment = .left
        textField.font = UIFont.boldSystemFont(ofSize: 14)
        textField.isSecureTextEntry = true
        
        textField.clearButtonMode = .whileEditing
        textField.rightViewMode = .whileEditing
        
        return textField
    } ()
    private let 비밀번호_표시_온오프 = {
        let button = UIButton()
        button.setImage(UIImage(named: "passwordOFF"), for: .normal)
        return button
    }()
    private let 로그인_비밀번호찾기_버튼 = {
        let button = UIButton()
        button.setTitle("비밀번호 찾기", for: .selected)
        button.setTitle("비밀번호 찾기", for: .normal)
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.setTitleColor(UIColor(named: "neon"), for: .selected)
        button.titleLabel?.font = UIFont(name: "Pretendard-Regular", size: 13)
        button.isSelected = !button.isSelected
        return button
    }()
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
        uiView.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
        uiView.layer.cornerRadius = 25
        return uiView
    }()
    private let 비밀번호_백 = {
        let uiView = UIView()
        uiView.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
        uiView.layer.cornerRadius = 25
        return uiView
    }()
    private let 간편로그인_라벨 = {
        let label = UILabel()
        label.text = " - - - - - - - - - - - - - -  간편 로그인  - - - - - - - - - - - - - - "
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
        button.layer.borderColor = UIColor(named: "neon")?.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 25
        button.contentMode = .scaleToFill
        return button
    } ()
    let 애플_버튼 = {
        let button = UIButton()
        button.setImage(UIImage(named: "apple"), for: .selected)
        button.setImage(UIImage(named: "apple"), for: .normal)
        button.isSelected = !button.isSelected
        button.backgroundColor = UIColor(named: "neon")
        button.layer.borderColor = UIColor(named: "neon")?.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 25
        button.contentMode = .scaleToFill
        
        return button
    } ()
    let 트위터_버튼 = {
        let button = UIButton()
        button.setImage(UIImage(named: "twitter"), for: .selected)
        button.setImage(UIImage(named: "twitter"), for: .normal)
        button.isSelected = !button.isSelected
        button.backgroundColor = UIColor(named: "neon")
        button.layer.borderColor = UIColor(named: "neon")?.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 25
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(키보드가올라올때), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
}


//버튼클릭
extension 로그인_뷰컨트롤러 {
    
    private func 버튼_클릭() {
        뒤로가기_버튼.addTarget(self, action: #selector(뒤로가기_버튼_클릭), for: .touchUpInside)
        비밀번호_표시_온오프.addTarget(self, action: #selector(비밀번호_표시_온오프_클릭), for: .touchUpInside)
        로그인_비밀번호찾기_버튼.addTarget(self, action: #selector(로그인_비밀번호찾기_버튼_클릭), for: .touchUpInside)
        로그인_버튼.addTarget(self, action: #selector(로그인_버튼_클릭), for: .touchUpInside)
        구글_버튼.addTarget(self, action: #selector(구글_버튼_클릭), for: .touchUpInside)
    }
    //일반 화면전환 버튼
    @objc func 뒤로가기_버튼_클릭() {
        print("뒤로가기")
        let 처음화면_이동 = 로그인_회원가입_뷰컨트롤러()
        self.navigationController?.pushViewController(처음화면_이동, animated: false)
        navigationItem.hidesBackButton = true
    }
    @objc func 비밀번호_표시_온오프_클릭() {
        if 로그인_비밀번호_텍스트필드.isSecureTextEntry == true {
            비밀번호_표시_온오프.setImage(UIImage(systemName: "eye"), for: .normal)
            비밀번호_표시_온오프.tintColor = UIColor(named: "neon")
            로그인_비밀번호_텍스트필드.isSecureTextEntry = false
        } else {
            비밀번호_표시_온오프.setImage(UIImage(named: "passwordOFF"), for: .normal)
            로그인_비밀번호_텍스트필드.isSecureTextEntry = true
        }
    }
    @objc func 로그인_비밀번호찾기_버튼_클릭() {
        print("비밀번호 찾기 진행")
        let 비밀번호찾기_이동 = 유저_비밀번호찾기_뷰컨트롤러()
        self.navigationController?.pushViewController(비밀번호찾기_이동, animated: true)
    }
    
}


//로그인 관련
extension 로그인_뷰컨트롤러 {
    
    //클릭했을때
    @objc func 로그인_버튼_클릭() {
        print("메인 전시 페이지로 이동")
        guard let 이메일 = 로그인_이메일_텍스트필드.text, let 비밀번호 = 로그인_비밀번호_텍스트필드.text else {
            return
        }
        
        Auth.auth().signIn(withEmail: 이메일, password: 비밀번호) { [weak self] authResult, 에러 in
            guard let self = self else { return }
            
            if let 로그인_실패 = 에러 {
                print("로그인 실패: \(로그인_실패.localizedDescription)")
                알럿센터.알럿_메시지.경고_알럿(알럿_메세지: """
입력을 하지않았거나
기입 정보와 일치하는 계정이없습니다.
""", presentingViewController: self)
            } else {
                print("로그인 성공")
                let 파이어스토어 = Firestore.firestore()
                파이어스토어.collection("도트_유저_데이터_관리").whereField("이메일", isEqualTo: 이메일).getDocuments { [weak self] (컬렉션, 에러) in
                    guard let self = self else { return }
                    
                    if let 에러 = 에러 {
                        print("Firestore 조회 에러: \(에러.localizedDescription)")
                        알럿센터.알럿_메시지.경고_알럿(알럿_메세지: "네트워크 에러 다시 시도해주세요.", presentingViewController: self)
                    }
                    else {
                        self.이중_로그인_확인_장치(이메일: 이메일)
                    }
                }
            }
        }
    }
    // 로그인 메서드
    private func 이중_로그인_확인_장치(이메일: String) {
        let 파이어스토어 = Firestore.firestore()
        
        파이어스토어.collection("도트_유저_데이터_관리").whereField("이메일", isEqualTo: 이메일).getDocuments { [weak self] (컬렉션, 에러) in
            guard let self = self else { return }
            
            if let 에러 = 에러 {
                print("Firestore 조회 에러: \(에러.localizedDescription)")
                알럿센터.알럿_메시지.경고_알럿(알럿_메세지: "네트워크 에러 다시 시도해주세요.", presentingViewController: self)
            }
            else {
                if let 문서조회 = 컬렉션?.documents, !문서조회.isEmpty {
                    
                    let 문서 = 문서조회[0]
                    
                    if let 로그인상태 = 문서["로그인상태"] as? Bool, !로그인상태 {
                        let 현재날짜시간 = Timestamp(date: Date())
                        
                        문서.reference.updateData(["로그인상태": true,"마지막로그인": 현재날짜시간 ]) { 에러 in
                            if let 에러 = 에러 {
                                print("Firestore 업데이트 에러: \(에러.localizedDescription)")
                                알럿센터.알럿_메시지.경고_알럿(알럿_메세지: "네트워크 에러 다시 시도해주세요.", presentingViewController: self)
                            } else {
                                
                                UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                                
                                let 메인화면_이동 = TabBar()
                                self.navigationController?.pushViewController(메인화면_이동, animated: true)
                                self.navigationItem.hidesBackButton = true
                            }
                        }
                    } else {
                        print("Firestore: 이미 로그인된 상태입니다.")
                        알럿센터.알럿_메시지.경고_알럿(알럿_메세지: "타 기기에 이미 로그인되어있는 계정입니다.", presentingViewController: self)
                    }
                } else {
                    print("Firestore: 등록된 계정이 없습니다.")
                    알럿센터.알럿_메시지.경고_알럿(알럿_메세지: "등록된 계정이 없습니다.", presentingViewController: self)
                }
            }
        }
    }
    
    
}



//레이아웃 관련
extension 로그인_뷰컨트롤러 {
    func UI레이아웃() {
        view.addSubview(뒤로가기_버튼)
        view.addSubview(제목_라벨)
        view.addSubview(이메일_백)
        view.addSubview(비밀번호_백)
        view.addSubview(로그인_이메일_텍스트필드)
        view.addSubview(로그인_비밀번호_텍스트필드)
        view.addSubview(비밀번호_표시_온오프)
        view.addSubview(로그인_비밀번호찾기_버튼)
        view.addSubview(로그인_버튼)
        view.addSubview(간편로그인_라벨)
        view.addSubview(구글_버튼)
        view.addSubview(애플_버튼)
        view.addSubview(트위터_버튼)
        
        뒤로가기_버튼.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16)
            make.size.equalTo(40)
        }
        
        제목_라벨.snp.makeConstraints { make in
            make.top.equalTo(뒤로가기_버튼.snp.bottom).offset(105)
            make.leading.equalToSuperview().offset(32)
            
        }
        이메일_백.snp.makeConstraints { make in
            make.top.equalTo(제목_라벨.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(55)
        }
        로그인_이메일_텍스트필드.snp.makeConstraints { make in
            make.height.equalTo(55)
            make.top.equalTo(이메일_백)
            make.leading.equalTo(이메일_백).offset(30)
            make.trailing.equalTo(이메일_백).offset(-30)
        }
        비밀번호_백.snp.makeConstraints { make in
            make.top.equalTo(로그인_이메일_텍스트필드.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(55)
        }
        로그인_비밀번호_텍스트필드.snp.makeConstraints { make in
            make.height.equalTo(55)
            make.top.equalTo(비밀번호_백)
            make.leading.equalTo(비밀번호_백).offset(30)
            make.trailing.equalTo(비밀번호_백).offset(-30)
        }
        비밀번호_표시_온오프.snp.makeConstraints { make in
            make.centerY.equalTo(로그인_비밀번호_텍스트필드.snp.centerY)
            make.trailing.equalTo(비밀번호_백.snp.trailing).offset(-10)
            make.size.equalTo(20)
        }
        로그인_비밀번호찾기_버튼.snp.makeConstraints { make in
            make.top.equalTo(비밀번호_백.snp.bottom).offset(1)
            make.trailing.equalTo(비밀번호_백.snp.trailing).offset(-2)
        }
        로그인_버튼.snp.makeConstraints { make in
            make.top.equalTo(로그인_비밀번호_텍스트필드.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(60)
        }
        간편로그인_라벨.snp.makeConstraints { make in
            make.top.equalTo(로그인_버튼.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
        }
        구글_버튼.snp.makeConstraints { make in
            make.centerY.equalTo(애플_버튼)
            make.trailing.equalTo(애플_버튼.snp.leading).offset(-20)
            make.size.equalTo(50)
        }
        애플_버튼.snp.makeConstraints { make in
            make.top.equalTo(간편로그인_라벨.snp.bottom).offset(63)
            make.centerX.equalToSuperview()
            make.size.equalTo(50)
        }
        트위터_버튼.snp.makeConstraints { make in
            make.centerY.equalTo(애플_버튼)
            make.leading.equalTo(애플_버튼.snp.trailing).offset(20)
            make.size.equalTo(50)
        }
    }
}


extension 로그인_뷰컨트롤러 {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == 로그인_이메일_텍스트필드 {
            // 이메일 규칙: 숫자 영문 소문자 - . _ 사용 가능
            let 입력제한사항 = CharacterSet(charactersIn: "0123456789abcdefghijklmnopqrstuvwxyz.@_-")
            let 제한사항준수 = string.rangeOfCharacter(from: 입력제한사항.inverted) == nil
            return 제한사항준수
        }
        else if textField == 로그인_비밀번호_텍스트필드 {
            // 비밀번호 규칙: 숫자와 영문 소문자만 가능, 8~16자
            let 입력제한사항 = CharacterSet(charactersIn: "0123456789abcdefghijklmnopqrstuvwxyz")
            let 제한사항준수 = string.rangeOfCharacter(from: 입력제한사항.inverted) == nil
            let 글자수제한 = (textField.text?.count ?? 0) + string.count
            return 제한사항준수 && (글자수제한 <= 16)
        }
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == 로그인_이메일_텍스트필드 {
            로그인_비밀번호_텍스트필드.becomeFirstResponder()
        } else if textField == 로그인_비밀번호_텍스트필드 {
            로그인_비밀번호_텍스트필드.resignFirstResponder()
            //            회원가입_회원가입_버튼_클릭()
        }
        return true
    }
}


//키보드 관련 Extension
extension 로그인_뷰컨트롤러 : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        활성화된텍스트필드 = textField
        if textField == 로그인_이메일_텍스트필드 {
            이메일_백.layer.borderColor = UIColor(named: "neon")?.cgColor
            이메일_백.layer.borderWidth = 1
        }
        else if textField == 로그인_비밀번호_텍스트필드 {
            비밀번호_백.layer.borderColor = UIColor(named: "neon")?.cgColor
            비밀번호_백.layer.borderWidth = 1
        }
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        활성화된텍스트필드 = nil
        if textField == 로그인_이메일_텍스트필드 {
            이메일_백.layer.borderColor = UIColor.clear.cgColor
        }
        else if textField == 로그인_비밀번호_텍스트필드 {
            비밀번호_백.layer.borderColor = UIColor.clear.cgColor
        }
        
    }
}

extension 로그인_뷰컨트롤러 {
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
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        self.view.frame.origin.y = 0
    }
}
