import UIKit
import FirebaseDatabaseInternal
import FirebaseStorage
import FirebaseAuth
import FirebaseFirestore
import SnapKit

class 회원가입_첫번째_뷰컨트롤러 : UIViewController, UINavigationControllerDelegate {
    var 이메일: String = ""
    var 활성화된텍스트필드: UITextField?
    
    //페이지 제목
    private let 제목_라벨 = {
        let label = UILabel()
        label.text = "기본 정보를 입력해주세요"
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 24)
        
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
    
    var 회원가입_이미지_선택_버튼 = {
        var imageButton = UIButton()
        imageButton.layer.cornerRadius = 60
        imageButton.backgroundColor = .darkGray
        imageButton.clipsToBounds = true
        imageButton.setTitle("사진", for: .normal)
        imageButton.setTitle("사진", for: .selected)
        imageButton.setTitleColor(UIColor.white, for: .selected)
        imageButton.setTitleColor(UIColor.darkGray, for: .normal)
        imageButton.setImage(UIImage(named: ""), for: .selected)
        imageButton.setImage(UIImage(named: ""), for: .normal)
        imageButton.isSelected = !imageButton.isSelected
        return imageButton
    }()
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
        return textField
    } ()
    private let 회원가입_다음_버튼 = {
        let button = UIButton()
        button.layer.cornerRadius = 30
        button.backgroundColor = UIColor.white
        button.isSelected = !button.isSelected
        button.setTitle("다음", for: .normal)
        button.setTitle("다음", for: .selected)
        button.setTitleColor(UIColor.white, for: .normal)
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

extension 회원가입_첫번째_뷰컨트롤러 {
    
    func UI레이아웃 () {
        view.addSubview(뒤로가기_버튼)
        view.addSubview(제목_라벨)
        view.addSubview(닉네임_백)
        view.addSubview(이메일_백)
        view.addSubview(비밀번호_백)
        view.addSubview(회원가입_이미지_선택_버튼)
        view.addSubview(회원가입_닉네임_텍스트필드)
        view.addSubview(회원가입_이메일_텍스트필드)
        view.addSubview(회원가입_중복확인_버튼)
        view.addSubview(회원가입_비밀번호_텍스트필드)
        view.addSubview(회원가입_다음_버튼)
        
        뒤로가기_버튼.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16)
            make.size.equalTo(40)
        }
        제목_라벨.snp.makeConstraints { make in
            make.top.equalTo(뒤로가기_버튼.snp.bottom).offset(25)
            make.leading.equalToSuperview().offset(24)
            
        }
        회원가입_이미지_선택_버튼.snp.makeConstraints { make in
            make.top.equalTo(제목_라벨.snp.bottom).offset(75)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(124)
        }
        닉네임_백.snp.makeConstraints { make in
            make.top.equalTo(회원가입_이미지_선택_버튼.snp.bottom).offset(35)
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
            make.top.equalTo(회원가입_닉네임_텍스트필드.snp.bottom).offset(24)
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
            make.top.equalTo(회원가입_이메일_텍스트필드.snp.bottom).offset(24)
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
        회원가입_다음_버튼.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(60)
            
        }
    }
}

//버튼클릭
extension 회원가입_첫번째_뷰컨트롤러 {
    
    private func 버튼_클릭() {
        뒤로가기_버튼.addTarget(self, action: #selector(뒤로가기_버튼_클릭), for: .touchUpInside)
        회원가입_다음_버튼.addTarget(self, action: #selector(회원가입_다음_버튼_클릭), for: .touchUpInside)
        회원가입_이미지_선택_버튼.addTarget(self, action: #selector(회원가입_이미지_선택_버튼_클릭), for: .touchUpInside)
        회원가입_중복확인_버튼.addTarget(self, action: #selector(회원가입_중복확인_버튼_클릭), for: .touchUpInside)
        
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
    private func 회원가입_유저정보_업로드(닉네임: String, 이메일: String, 비밀번호: String, /*로그인상태: Bool,*/ 프로필이미지URL: String) {
        let 데이터베이스 = Firestore.firestore()
        let 유저컬렉션 = 데이터베이스.collection("유저_데이터_관리")
        
        let userData: [String: Any] = [
            "닉네임": 닉네임,
            "이메일": 이메일,
            "비밀번호": 비밀번호,
//            "로그인상태": 로그인상태,
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
        guard let 이메일 = 회원가입_이메일_텍스트필드.text, !이메일.isEmpty else {
              showAlert(message: "이메일을 입력하세요.")
              return
          }
           let 데이터베이스 = Firestore.firestore()
           let 유저컬렉션 = 데이터베이스.collection("유저_데이터_관리")
           
           유저컬렉션.whereField("이메일", isEqualTo: 이메일).getDocuments { [weak self] (snapshot, error) in
               guard let self = self else { return }

               if let error = error {
                   print("Firestore에서 이메일 중복 확인 실패: \(error.localizedDescription)")
                   self.showAlert(message: "이메일 중복 확인 실패")
                   return
               }

               if snapshot?.isEmpty == false {
                   self.showAlert(message: "중복된 이메일입니다.")
               } else {
                   self.showAlert(message: "사용 가능한 이메일입니다.")
               }
           }
       }
       
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "경고", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    @objc func 회원가입_다음_버튼_클릭() {
        let 다음화면_이동 = 회원가입_두번째_뷰컨트롤러()
        self.navigationController?.pushViewController(다음화면_이동, animated: true)
        self.navigationItem.hidesBackButton = true
        print("다음 페이지로 이동")
        guard let 이메일 = 회원가입_이메일_텍스트필드.text,
              let 비밀번호 = 회원가입_비밀번호_텍스트필드.text,
              let 닉네임 = 회원가입_닉네임_텍스트필드.text,
//              let 로그인상태 = false,
              let 프로필이미지 = 회원가입_이미지_선택_버튼.image(for: .normal) else {
            return
        }
        회원가입_이미지_업로드(프로필이미지) { [weak self] 결과 in
            guard let self = self else { return }
            
            switch 결과 {
            case .success(let 이미지Url):
                Auth.auth().createUser(withEmail: 이메일, password: 비밀번호) { (authResult, 에러) in
                    if let 회원가입_실패 = 에러 {
                        print("회원가입 실패: \(회원가입_실패.localizedDescription)")
                        
                        return
                    }
                    
                    print("회원가입 성공")
                    
                    self.회원가입_유저정보_업로드(닉네임: 닉네임, 이메일: 이메일, 비밀번호: 비밀번호,/* 로그인상태: 로그인상태,*/ 프로필이미지URL: 이미지Url.absoluteString)
                    
                    let 다음화면_이동 = 회원가입_두번째_뷰컨트롤러()
                    self.navigationController?.pushViewController(다음화면_이동, animated: true)
                    self.navigationItem.hidesBackButton = true
                }
            case .failure(let 업로드_실패):
                print("이미지 업로드 실패: \(업로드_실패.localizedDescription)")
                
            }
        }
        
    }
    
    @objc func 회원가입_이미지_선택_버튼_클릭() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
}




//사진라이브러리 접근관련 Extension
extension 회원가입_첫번째_뷰컨트롤러: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            회원가입_이미지_선택_버튼.setImage(selectedImage, for: .normal)
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
