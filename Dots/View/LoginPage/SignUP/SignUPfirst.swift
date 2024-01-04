import UIKit
import FirebaseDatabaseInternal
import FirebaseStorage
import FirebaseAuth
import FirebaseFirestore
import Firebase
import SnapKit

class 회원가입_첫번째_뷰컨트롤러 : UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

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
        textField.tintColor = UIColor(named: "neon")
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 25
        //        textField.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
        textField.backgroundColor = UIColor.clear
        textField.textAlignment = .left
        textField.font = UIFont.boldSystemFont(ofSize: 14)
        
        textField.clearButtonMode = .whileEditing
        textField.rightViewMode = .whileEditing
        
        
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
    
    private let 이메일_리프레쉬 = {
        let button = UIButton()
        button.setImage(UIImage(named: "Refresh"), for: .normal)
        button.isHidden = true
        return button
    } ()
    private let 회원가입_중복확인_버튼 = {
        let button = UIButton()
        button.layer.cornerRadius = 30
        //button.backgroundColor = UIColor(named: "neon")
        button.isSelected = !button.isSelected
        button.setTitle("중복 확인", for: .normal)
        button.setTitle("중복 확인", for: .selected)
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
        uiView.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
        uiView.layer.cornerRadius = 25
        return uiView
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
        
        // 키보드 이벤트 리스너 등록
        NotificationCenter.default.addObserver(self, selector: #selector(키보드가올라올때), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        // 텍스트 필드의 delegate 설정
        회원가입_닉네임_텍스트필드.delegate = self
        회원가입_이메일_텍스트필드.delegate = self
        회원가입_비밀번호_텍스트필드.delegate = self
        
        화면_제스쳐_실행()
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
        비밀번호_표시_온오프.addTarget(self, action: #selector(비밀번호_표시_온오프_클릭), for: .touchUpInside)
        구글_버튼.addTarget(self, action: #selector(구글_버튼_클릭), for: .touchUpInside)
        애플_버튼.addTarget(self, action: #selector(애플_버튼_클릭), for: .touchUpInside)
        이메일_리프레쉬.addTarget(self, action: #selector(이메일_리프레쉬_클릭), for: .touchUpInside)
    }
    
    @objc func 뒤로가기_버튼_클릭() {
        print("뒤로가기")
        let 처음화면_이동 = 로그인_회원가입_뷰컨트롤러()
        self.navigationController?.pushViewController(처음화면_이동, animated: false)
        navigationItem.hidesBackButton = true
        
    }
    
    @objc func 비밀번호_표시_온오프_클릭() {
        if 회원가입_비밀번호_텍스트필드.isSecureTextEntry == true {
            비밀번호_표시_온오프.setImage(UIImage(systemName: "eye"), for: .normal)
            비밀번호_표시_온오프.tintColor = UIColor(named: "neon")
            회원가입_비밀번호_텍스트필드.isSecureTextEntry = false
        } else {
            비밀번호_표시_온오프.setImage(UIImage(named: "passwordOFF"), for: .normal)
            회원가입_비밀번호_텍스트필드.isSecureTextEntry = true
        }
    }
    
    @objc func 이메일_리프레쉬_클릭() {
        회원가입_이메일_텍스트필드.text = ""
        회원가입_중복확인_버튼.setTitle("중복 확인", for: .selected)
        이메일_리프레쉬.isHidden = true
        self.회원가입_이메일_텍스트필드.isEnabled = true
        self.회원가입_중복확인_버튼.setTitleColor(UIColor(named: "neon"), for: .selected)
        self.회원가입_이메일_텍스트필드.textColor = UIColor.white
        self.회원가입_회원가입_버튼.setTitle("회원가입", for: .selected)
        self.회원가입_회원가입_버튼.setTitleColor(UIColor.black, for: .selected)
        self.회원가입_회원가입_버튼.isUserInteractionEnabled = true
        self.회원가입_회원가입_버튼.isEnabled = true
        self.회원가입_중복확인_버튼.isUserInteractionEnabled = true
    }
    
    
    
    
}

//이메일 중복확인 관련
extension 회원가입_첫번째_뷰컨트롤러 {
    @objc func 회원가입_중복확인_버튼_클릭() {
        guard let 이메일 = 회원가입_이메일_텍스트필드.text else {
            return
        }
        
        Auth.auth().fetchSignInMethods(forEmail: 이메일) { (methods, error) in
            if let error = error {
                print("이메일 중복 확인 에러: \(error.localizedDescription)")
                self.이메일_백.layer.borderColor = UIColor.red.cgColor
                return
            }
            
            if let signInMethods = methods, signInMethods.isEmpty {
              
            } else {
              
                let 데이터베이스 = Firestore.firestore()
                let 유저데이터컬렉션 = 데이터베이스.collection("유저_데이터_관리")
                
                유저데이터컬렉션.whereField("이메일", isEqualTo: 이메일).getDocuments { (snapshot, error) in
                    if let error = error {
                        print("Firestore 이메일 중복 확인 에러: \(error.localizedDescription)")
                        return
                    }
                    
                    if let documents = snapshot?.documents, !documents.isEmpty {
                        self.회원가입_이메일_텍스트필드.isEnabled = false
                        self.회원가입_이메일_텍스트필드.textColor = UIColor.red
                        self.회원가입_회원가입_버튼.isUserInteractionEnabled = false
                        self.회원가입_회원가입_버튼.setTitle("이미 사용중인 이메일입니다.", for: .selected)
                        self.회원가입_회원가입_버튼.setTitleColor(UIColor.red, for: .selected)
                        self.회원가입_중복확인_버튼.setTitle("사용 불가", for: .selected)
                        self.회원가입_중복확인_버튼.setTitleColor(UIColor.red, for: .selected)
                        self.회원가입_중복확인_버튼.isUserInteractionEnabled = false
                        self.이메일_백.layer.borderColor = UIColor.red.cgColor
                        self.이메일_리프레쉬.isHidden = false

                    } else {
                        self.회원가입_이메일_텍스트필드.isEnabled = false
                        self.회원가입_이메일_텍스트필드.textColor = UIColor(named: "neon")
                        self.회원가입_회원가입_버튼.isEnabled = true
                        self.회원가입_회원가입_버튼.isUserInteractionEnabled = true
                        self.회원가입_회원가입_버튼.setTitle("회원가입", for: .selected)
                        self.회원가입_회원가입_버튼.setTitleColor(UIColor.black, for: .selected)
                        self.회원가입_중복확인_버튼.setTitle("사용 가능", for: .selected)
                        self.회원가입_중복확인_버튼.isUserInteractionEnabled = false
                        self.이메일_백.layer.borderColor = UIColor(named: "neon")?.cgColor
                        self.이메일_리프레쉬.isHidden = false
                    }
                }
            }
        }
    }
}
// 회원가입 유저 정보 업로드 관련
extension 회원가입_첫번째_뷰컨트롤러 {
    
    private func 회원가입_유저정보_업로드(유저ID: String, 회원가입_타입: String, 닉네임: String, 이메일: String, 비밀번호: String, 로그인상태: Bool, 프로필이미지URL: String, 마지막로그인: String, 마지막로그아웃: String) {
        let 데이터베이스 = Firestore.firestore()
        let userData: [String: Any] = [
            "회원가입_타입": 회원가입_타입,
            "닉네임": 닉네임,
            "이메일": 이메일,
            "비밀번호": 비밀번호,
            "로그인상태": 로그인상태,
            "프로필이미지URL": 프로필이미지URL,
            "마지막로그인": 마지막로그인,
            "마지막로그아웃": 마지막로그아웃
        ]
        
        데이터베이스.collection("유저_데이터_관리").document(유저ID).setData(userData) { 에러 in
            if let 에러 = 에러 {
                print("Firestore에 사용자 정보 저장 실패: \(에러.localizedDescription)")
            } else {
                print("Firestore에 사용자 정보 저장 성공")
            }
        }
    }
    
    
    private func 유저_프로필_저장(유저ID: String, 닉네임: String, 프로필이미지URL: String) {
        let 데이터베이스 = Firestore.firestore()
        let 유저프로필컬렉션 = 데이터베이스.collection("유저_프로필")
        
        let userProfileData: [String: Any] = [
            "닉네임": 닉네임,
            "프로필이미지URL": 프로필이미지URL
        ]
        
        유저프로필컬렉션.document(유저ID).setData(userProfileData) { 에러 in
            if let 에러 = 에러 {
                print("유저 프로필 정보 저장 실패: \(에러.localizedDescription)")
            } else {
                print("유저 프로필 정보 저장 성공")
            }
        }
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
        
        Auth.auth().createUser(withEmail: 이메일, password: 비밀번호) { [weak self] (authResult, 에러) in
            guard let self = self else { return }
            
            if let 에러 = 에러 {
                print("회원가입 실패: \(에러.localizedDescription)")
                return
            }
            
            print("회원가입 성공")
            
            // 생성된 UUID를 가져옵니다.
            guard let 유저ID = authResult?.user.uid else { return }
            
            // Firestore에 사용자 정보 저장
            self.회원가입_유저정보_업로드(유저ID: 유저ID, 회원가입_타입: "도트", 닉네임: 닉네임, 이메일: 이메일, 비밀번호: 비밀번호, 로그인상태: false, 프로필이미지URL: 기본프로필이미지URL, 마지막로그인: "로그인 기록이 없음", 마지막로그아웃: "로그아웃 기록이 없음")
            
            // 다음 화면으로 이동
            let 다음화면_이동 = 회원가입_네번째_뷰컨트롤러()
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
        view.addSubview(회원가입_닉네임_텍스트필드)
        view.addSubview(회원가입_이메일_텍스트필드)
        view.addSubview(회원가입_중복확인_버튼)
        view.addSubview(회원가입_비밀번호_텍스트필드)
        view.addSubview(비밀번호_표시_온오프)
        view.addSubview(회원가입_회원가입_버튼)
        view.addSubview(간편로그인_라벨)
        view.addSubview(구글_버튼)
        view.addSubview(애플_버튼)
        view.addSubview(트위터_버튼)
        view.addSubview(이메일_리프레쉬)
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
            make.trailing.equalTo(닉네임_백).offset(-30)
            make.height.equalTo(50)
        }
        이메일_백.snp.makeConstraints { make in
            make.top.equalTo(회원가입_닉네임_텍스트필드.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(50)
        }
        이메일_리프레쉬.snp.makeConstraints { make in
            make.centerY.equalTo(이메일_백.snp.centerY)
            make.leading.equalTo(회원가입_중복확인_버튼.snp.trailing).offset(5)
            make.size.equalTo(15)
        }
        회원가입_이메일_텍스트필드.snp.makeConstraints { make in
            make.top.equalTo(이메일_백)
            make.leading.equalTo(이메일_백).offset(30)
            make.trailing.equalTo(이메일_백).offset(-30)
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
            make.trailing.equalTo(비밀번호_백).offset(-30)
            make.height.equalTo(50)
        }
        비밀번호_표시_온오프.snp.makeConstraints { make in
            make.centerY.equalTo(회원가입_비밀번호_텍스트필드.snp.centerY)
            make.trailing.equalTo(비밀번호_백.snp.trailing).offset(-10)
            make.size.equalTo(20)
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
        if textField == 회원가입_닉네임_텍스트필드 {
            // 닉네임 규칙: 2~8자, 한글과 영문만 가능
            //                let 입력제한사항 = CharacterSet(charactersIn: "가-힣")
            //                let 제한사항준수 = string.rangeOfCharacter(from: 입력제한사항.inverted) == nil
            let 글자수제한 = (textField.text?.count ?? 0) + string.count
            return /*제한사항준수 &&*/ (글자수제한 <= 8)
        }
        else if textField == 회원가입_이메일_텍스트필드 {
            // 이메일 규칙: 숫자 영문 소문자 - . _ 사용 가능
            let 입력제한사항 = CharacterSet(charactersIn: "0123456789abcdefghijklmnopqrstuvwxyz.@_-")
            let 제한사항준수 = string.rangeOfCharacter(from: 입력제한사항.inverted) == nil
            return 제한사항준수
        }
        else if textField == 회원가입_비밀번호_텍스트필드 {
            // 비밀번호 규칙: 숫자와 영문 소문자만 가능, 8~16자
            let 입력제한사항 = CharacterSet(charactersIn: "0123456789abcdefghijklmnopqrstuvwxyz")
            let 제한사항준수 = string.rangeOfCharacter(from: 입력제한사항.inverted) == nil
            let 글자수제한 = (textField.text?.count ?? 0) + string.count
            return 제한사항준수 && (글자수제한 <= 16)
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == 회원가입_닉네임_텍스트필드 {
            회원가입_이메일_텍스트필드.becomeFirstResponder()
        } else if textField == 회원가입_이메일_텍스트필드 {
            회원가입_비밀번호_텍스트필드.becomeFirstResponder()
        } else if textField == 회원가입_비밀번호_텍스트필드 {
            회원가입_비밀번호_텍스트필드.resignFirstResponder()
            //            회원가입_회원가입_버튼_클릭()
        }
        return true
    }
    
}


//키보드관련 Extension
extension 회원가입_첫번째_뷰컨트롤러: UITextFieldDelegate {
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        활성화된텍스트필드 = textField
        if textField == 회원가입_닉네임_텍스트필드 {
            닉네임_백.layer.borderColor = UIColor(named: "neon")?.cgColor
            닉네임_백.layer.borderWidth = 1
        }
        else if textField == 회원가입_이메일_텍스트필드 {
            이메일_백.layer.borderColor = UIColor(named: "neon")?.cgColor
            이메일_백.layer.borderWidth = 1
        }
        else if textField == 회원가입_비밀번호_텍스트필드 {
            비밀번호_백.layer.borderColor = UIColor(named: "neon")?.cgColor
            비밀번호_백.layer.borderWidth = 1
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        활성화된텍스트필드 = nil
        if textField == 회원가입_닉네임_텍스트필드 {
            닉네임_백.layer.borderColor = UIColor.clear.cgColor
        }
        else if textField == 회원가입_이메일_텍스트필드 {
            이메일_백.layer.borderColor = UIColor.clear.cgColor
        }
        else if textField == 회원가입_비밀번호_텍스트필드 {
            비밀번호_백.layer.borderColor = UIColor.clear.cgColor
        }
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




extension 회원가입_첫번째_뷰컨트롤러 {
    
    func 화면_제스쳐_실행 () {
        let 화면_제스쳐 = UISwipeGestureRecognizer(target: self, action: #selector(화면_제스쳐_뒤로_가기))
        화면_제스쳐.direction = .right
        view.addGestureRecognizer(화면_제스쳐)
    }
    @objc private func 화면_제스쳐_뒤로_가기() {
        navigationController?.popViewController(animated: true)
    }
    
}

import UIKit
import FirebaseAuth
import FirebaseCore
import AuthenticationServices
import FirebaseFirestore

extension 회원가입_첫번째_뷰컨트롤러: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {

    @objc func 애플_버튼_클릭() {
        print("애플 버튼 클릭")
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]

        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential, let appleIDToken = appleIDCredential.identityToken, let idTokenString = String(data: appleIDToken, encoding: .utf8) {
            let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: nil)

            Auth.auth().signIn(with: credential) { [weak self] (authResult, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                // 로그인 성공 후
                guard let self = self, let user = authResult?.user else { return }

                // 애플 로그인 완료 후 처리
                self.handleAppleSignInCompleted(user: user)
            }
        }
    }
    // 애플 로그인 완료 후 호출되는 메소드
    func handleAppleSignInCompleted(user: User) {
        // 프로필 이미지 선택 안내 얼럿
        let alert = UIAlertController(title: "프로필 이미지", message: "프로필 이미지를 선택해주세요.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary

            self.present(imagePicker, animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }



    // 사용자가 이미지를 선택했을 때 호출되는 메소드
    // UIImagePickerControllerDelegate 메소드
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else {
            picker.dismiss(animated: true, completion: nil)
            return
        }

        uploadImageToFirebaseStorage(image: selectedImage) { [weak self] imageUrl in
            picker.dismiss(animated: true) {
                guard let self = self else { return }
                if let imageUrl = imageUrl {
                    self.promptForNickname { nickname in
                        // Firestore에 사용자 정보 저장
                        self.completeSignUp(with: imageUrl, nickname: nickname)
                    }
                }
            }
        }
    }



    // 회원가입 완료 후 Firestore에 유저 데이터 저장
    // Firestore에 유저 데이터 저장
    private func completeSignUp(with imageUrl: String, nickname: String) {
        guard let 유저ID = Auth.auth().currentUser?.uid else { return }
        let 회원가입_타입 = "애플"
        let 이메일 = Auth.auth().currentUser?.email ?? "알 수 없음"

        self.회원가입_유저정보_업로드(유저ID: 유저ID,
                           회원가입_타입: 회원가입_타입,
                           닉네임: nickname,
                           이메일: 이메일,
                           비밀번호: "",
                           로그인상태: true,
                           프로필이미지URL: imageUrl,
                           마지막로그인: "로그인 기록이 없음",
                           마지막로그아웃: "로그아웃 기록이 없음")

        // 메인 화면 (TabBar)으로 전환
               let 메인화면_이동 = TabBar()
               self.navigationController?.pushViewController(메인화면_이동, animated: true)
               self.navigationItem.hidesBackButton = true
    }


    private func uploadImageToFirebaseStorage(image: UIImage, completion: @escaping (String?) -> Void) {
        // 이미지를 JPEG 데이터로 변환
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            completion(nil)
            return
        }

        // Firebase Storage 경로 설정
        let imageName = "\(UUID().uuidString).jpg"
        let storageRef = Storage.storage().reference().child("profile_images/\(imageName)")

        // 이미지 데이터를 Firebase Storage에 업로드
        storageRef.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                print("이미지 업로드 에러: \(error.localizedDescription)")
                completion(nil)
                return
            }

            // 업로드된 이미지의 URL을 가져옴
            storageRef.downloadURL { url, error in
                 if let error = error {
                     print("이미지 URL 가져오기 에러: \(error.localizedDescription)")
                     completion(nil)
                 } else if let url = url {
                     print("이미지 URL: \(url.absoluteString)")
                     completion(url.absoluteString)
                 } else {
                     print("이미지 URL 가져오기 실패: URL이 없음")
                     completion(nil)
                 }
             }
        }
    }


    // 닉네임 입력 얼럿
    private func promptForNickname(completion: @escaping (String) -> Void) {
        let alert = UIAlertController(title: "프로필 설정", message: "닉네임을 입력해주세요.", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "닉네임"
        }
        let saveAction = UIAlertAction(title: "저장", style: .default) { _ in
            let nickname = alert.textFields?.first?.text ?? "Unknown"
            completion(nickname)
        }
        alert.addAction(saveAction)
        present(alert, animated: true, completion: nil)
    }

    // Firestore에 사용자 프로필 업데이트
    private func updateUserProfile(user: User, nickname: String, profileImageUrl: String) {
        let 데이터베이스 = Firestore.firestore()
        let userData: [String: Any] = [
            "닉네임": nickname,
            "프로필이미지URL": profileImageUrl,
            // 다른 필요한 데이터 추가
        ]

        데이터베이스.collection("유저_데이터_관리").document(user.uid).updateData(userData) { 에러 in
            if let 에러 = 에러 {
                print("사용자 정보 업데이트 실패: \(에러.localizedDescription)")
            } else {
                print("사용자 정보 업데이트 성공")
                // 추가적인 작업 수행
            }
        }
    }

    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }

    func 애플계정정보_파이어스토어_업로드(회원가입_타입: String, 애플이메일: String, 애플닉네임: String, 유저UID: String, 로그인상태: Bool, 프로필이미지URL: String) {
        let 데이터베이스 = Firestore.firestore()
        let 유저컬렉션 = 데이터베이스.collection("유저_데이터_관리").document(유저UID)
        let 현재날짜시간 = Timestamp(date: Date())

        let userData: [String: Any] = [
            "회원가입_타입": 회원가입_타입,
            "로그인상태": 로그인상태,
            "닉네임": 애플닉네임,
            "이메일": 애플이메일,
            "프로필이미지URL": 프로필이미지URL,
            "마지막로그인": 현재날짜시간,
            "마지막로그아웃": "로그아웃 기록이 없음"
        ]

        유저컬렉션.setData(userData) { 에러 in
            if let 에러 = 에러 {
                print("Firestore 애플 데이터 등록 실패: \(에러.localizedDescription)")
            } else {
                print("애플 계정 auth 등록 후 필요 데이터를 Firestore에 애플 데이터 등록 성공")
            }
        }
    }
}
