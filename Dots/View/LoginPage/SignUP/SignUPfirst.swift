import UIKit
import FirebaseDatabaseInternal
import FirebaseStorage
import FirebaseAuth
import FirebaseFirestore
import SnapKit

class 회원가입_첫번째_뷰컨트롤러 : UIViewController, UINavigationControllerDelegate {

    var 활성화된텍스트필드: UITextField?
    //페이지 제목
    private let 제목_라벨 = {
        let label = UILabel()
        label.text = "SIGN UP"
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
  
    private let 회원가입_닉네임_텍스트필드 = { ()
        let textField = UITextField()
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.lightGray,
            .font: UIFont.boldSystemFont(ofSize: 14)
        ]
        textField.attributedPlaceholder = NSAttributedString(string: "닉네임", attributes: attributes)
        textField.textColor = UIColor.white
        textField.tintColor = UIColor.lightGray
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 25
        textField.backgroundColor = .clear
        textField.textAlignment = .left
        textField.font = UIFont.boldSystemFont(ofSize: 14)
        
        return textField
    } ()
    private let 회원가입_이메일_텍스트필드 = { ()
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
        
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none


        return textField
    } ()
    private let 회원가입_중복확인_버튼 = {
        let button = UIButton()
        button.layer.cornerRadius = 30
        //button.backgroundColor = UIColor(named: "neon")
        button.isSelected = !button.isSelected
        button.setTitle("중복확인", for: .normal)
        button.setTitle("중복확인", for: .selected)
        button.setTitleColor(UIColor(named: "neon"), for: .selected)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.titleLabel?.textAlignment = .center
        return button
    }()
    private let 회원가입_비밀번호_텍스트필드 = { ()
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
        
        textField.isSecureTextEntry = true

        return textField
    } ()
    private let 회원가입_회원가입_버튼 = {
        let button = UIButton()
        button.layer.cornerRadius = 30
        button.backgroundColor = UIColor(named: "neon")
        button.isSelected = !button.isSelected
        button.setTitle("회원가입", for: .normal)
        button.setTitle("회원가입", for: .selected)
        button.setTitleColor(UIColor(named: "neon"), for: .normal)
        button.setTitleColor(UIColor.black, for: .selected)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.titleLabel?.textAlignment = .center
        return button
    }()
    private let 닉네임_백 = {
        let uiView = UIView()
        uiView.backgroundColor = .darkGray
        uiView.layer.cornerRadius = 25
        return uiView
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
        
        // 키보드 이벤트 리스너 등록
        NotificationCenter.default.addObserver(self, selector: #selector(키보드가올라올때), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        // 텍스트 필드의 delegate 설정
        회원가입_닉네임_텍스트필드.delegate = self
        회원가입_이메일_텍스트필드.delegate = self
        회원가입_비밀번호_텍스트필드.delegate = self
    }
    
    deinit {
        // 메모리 해제 시 리스너 제거
        NotificationCenter.default.removeObserver(self)
    }
    
}


//버튼클릭
extension 회원가입_첫번째_뷰컨트롤러 {
    
    private func 버튼_클릭() {
        뒤로가기_버튼.addTarget(self, action: #selector(뒤로가기_버튼_클릭), for: .touchUpInside)
        회원가입_회원가입_버튼.addTarget(self, action: #selector(회원가입_회원가입_버튼_클릭), for: .touchUpInside)
        회원가입_중복확인_버튼.addTarget(self, action: #selector(회원가입_중복확인_버튼_클릭), for: .touchUpInside)
        
    }
    
    private func 회원가입_유저정보_업로드(닉네임: String, 이메일: String, 비밀번호: String,로그인상태: Bool ,프로필이미지URL: String) {
        let 데이터베이스 = Firestore.firestore()
        let 유저컬렉션 = 데이터베이스.collection("유저_데이터_관리")
        
        let userData: [String: Any] = [
            "닉네임": 닉네임,
            "이메일": 이메일,
            "비밀번호": 비밀번호,
            "로그인상태": false,
            "프로필이미지URL": 프로필이미지URL
        ]
        
        유저컬렉션.addDocument(data: userData) { 에러 in
            if let 유저데이터_실패 = 에러 {
                print("Firestore에 사용자 정보 저장 실패: \(유저데이터_실패.localizedDescription)")
            } else {
                print("Firestore에 사용자 정보 저장 성공")
            }
        }
    }
    @objc func 뒤로가기_버튼_클릭() {
        print("뒤로가기")
        navigationController?.popViewController(animated: true)
        
    }
    @objc func 회원가입_중복확인_버튼_클릭() {
        //        guard let 이메일 = 회원가입_이메일_텍스트필드.text, !이메일.isEmpty else {
        //
        //            알럿센터.알럿_메시지.경고_알럿(알럿_메세지: "이메일을 입력하세요.")
        //              return
        //          }
        //           let 데이터베이스 = Firestore.firestore()
        //           let 유저컬렉션 = 데이터베이스.collection("유저_데이터_관리")
        //
        //           유저컬렉션.whereField("이메일", isEqualTo: 이메일).getDocuments { [weak self] (snapshot, error) in
        //               guard let self = self else { return }
        //
        //               if let error = error {
        //                   print("Firestore에서 이메일 중복 확인 실패: \(error.localizedDescription)")
        //
        //                   알럿센터.알럿_메시지.경고_알럿(알럿_메세지: "이메일 중복 확인 실패")
        //                   return
        //               }
        //
        //               if snapshot?.isEmpty == false {
        //                   알럿센터.알럿_메시지.경고_알럿(알럿_메세지: "중복된 이메일입니다.")
        //               } else {
        //                   알럿센터.알럿_메시지.경고_알럿(알럿_메세지: "사용 가능한 이메일입니다.")
        //               }
        //           }
    }
    
    
    @objc func 회원가입_회원가입_버튼_클릭() {
        //        let 다음화면_이동 = 회원가입_두번째_뷰컨트롤러()
        //        self.navigationController?.pushViewController(다음화면_이동, animated: true)
        //        self.navigationItem.hidesBackButton = true
        print("다음 페이지로 이동")
        guard let 이메일 = 회원가입_이메일_텍스트필드.text,
              let 비밀번호 = 회원가입_비밀번호_텍스트필드.text,
              let 닉네임 = 회원가입_닉네임_텍스트필드.text else {
            return
        }
        let 기본프로필이미지URL = "https://firebasestorage.googleapis.com/v0/b/dots-3ad09.appspot.com/o/profile_default_images%2FdotsMan.png?alt=media&token=c412cd87-160c-4ebf-bd7d-53ebac38a720"
        
        Auth.auth().createUser(withEmail: 이메일, password: 비밀번호) { (authResult, 에러) in
            if let 회원가입_실패 = 에러 {
                print("회원가입 실패: \(회원가입_실패.localizedDescription)")
                return
            }
            
            print("회원가입 성공")
            
            self.회원가입_유저정보_업로드(닉네임: 닉네임, 이메일: 이메일, 비밀번호: 비밀번호, 로그인상태: false, 프로필이미지URL: 기본프로필이미지URL)
            
            let 다음화면_이동 = 회원가입_두번째_뷰컨트롤러()
            self.navigationController?.pushViewController(다음화면_이동, animated: true)
            self.navigationItem.hidesBackButton = true
        }
    }
    
}


//레이아웃 관련
extension 회원가입_첫번째_뷰컨트롤러 {
    
    func UI레이아웃 () {
        view.addSubview(뒤로가기_버튼)
        view.addSubview(제목_라벨)
        view.addSubview(닉네임_백)
        view.addSubview(이메일_백)
        view.addSubview(비밀번호_백)
        //        view.addSubview(회원가입_이미지_선택_버튼)
        view.addSubview(회원가입_닉네임_텍스트필드)
        view.addSubview(회원가입_이메일_텍스트필드)
        view.addSubview(회원가입_중복확인_버튼)
        view.addSubview(회원가입_비밀번호_텍스트필드)
        view.addSubview(회원가입_회원가입_버튼)
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
            make.leading.equalToSuperview().offset(24)
            
        }

        닉네임_백.snp.makeConstraints { make in
            make.top.equalTo(제목_라벨.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(50)
        }
        회원가입_닉네임_텍스트필드.snp.makeConstraints { make in
            make.top.equalTo(닉네임_백)
            make.leading.equalTo(닉네임_백).offset(30)
            make.trailing.equalTo(닉네임_백).offset(-80)
            make.height.equalTo(50)
        }
        이메일_백.snp.makeConstraints { make in
            make.top.equalTo(회원가입_닉네임_텍스트필드.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(50)
        }
        회원가입_이메일_텍스트필드.snp.makeConstraints { make in
            make.top.equalTo(이메일_백)
            make.leading.equalTo(이메일_백).offset(30)
            make.trailing.equalTo(이메일_백).offset(-80)
            make.height.equalTo(50)
        }
        비밀번호_백.snp.makeConstraints { make in
            make.top.equalTo(회원가입_이메일_텍스트필드.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(50)
        }
        회원가입_중복확인_버튼.snp.makeConstraints { make in
            make.centerY.equalTo(이메일_백.snp.centerY)
            make.trailing.equalTo(이메일_백.snp.trailing).offset(-30)
        }
        회원가입_비밀번호_텍스트필드.snp.makeConstraints { make in
            make.top.equalTo(비밀번호_백)
            make.leading.equalTo(비밀번호_백).offset(30)
            make.trailing.equalTo(비밀번호_백).offset(-80)
            make.height.equalTo(50)
        }
        회원가입_회원가입_버튼.snp.makeConstraints { make in
            make.top.equalTo(비밀번호_백.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(60)
            
        }
        간편로그인_라벨.snp.makeConstraints { make in
            make.top.equalTo(회원가입_회원가입_버튼.snp.bottom).offset(25)
            make.centerX.equalToSuperview()
        }
        구글_버튼.snp.makeConstraints { make in
            make.centerY.equalTo(애플_버튼)
            make.trailing.equalTo(애플_버튼.snp.leading).offset(-20)
            make.size.equalTo(50)
        }
        애플_버튼.snp.makeConstraints { make in
            make.top.equalTo(간편로그인_라벨.snp.bottom).offset(30)
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
// 텍스트 필드 델리게이트 구현
extension 회원가입_첫번째_뷰컨트롤러 {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == 회원가입_비밀번호_텍스트필드 {
            // 비밀번호 규칙: 숫자와 영문 소문자만 가능, 8~16자
            let validCharacters = CharacterSet(charactersIn: "0123456789abcdefghijklmnopqrstuvwxyz")
            let isValid = string.rangeOfCharacter(from: validCharacters.inverted) == nil
            let newLength = (textField.text?.count ?? 0) + string.count
            return isValid && (newLength <= 16)
        } else if textField == 회원가입_닉네임_텍스트필드 {
            // 닉네임 규칙: 2~8자, 한글과 영문만 가능
            let validCharacters = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ가-힣")
            let isValid = string.rangeOfCharacter(from: validCharacters.inverted) == nil
            let newLength = (textField.text?.count ?? 0) + string.count
            return isValid && (newLength <= 8)
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 리턴 키를 눌렀을 때 다음 텍스트 필드로 포커스 이동
        if textField == 회원가입_닉네임_텍스트필드 {
            회원가입_이메일_텍스트필드.becomeFirstResponder()
        } else if textField == 회원가입_이메일_텍스트필드 {
            회원가입_비밀번호_텍스트필드.becomeFirstResponder()
        } else if textField == 회원가입_비밀번호_텍스트필드 {
            회원가입_비밀번호_텍스트필드.resignFirstResponder()  // 마지막 필드에서 리턴 키를 눌렀을 때 키보드 숨김
            회원가입_회원가입_버튼_클릭()  // 원래는 다음 버튼 클릭 메소드 호출로 변경
        }
        return true
    }
    
}


//키보드관련 Extension
extension 회원가입_첫번째_뷰컨트롤러: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        활성화된텍스트필드 = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        활성화된텍스트필드 = nil
    }
}

extension 회원가입_첫번째_뷰컨트롤러 {
    
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


