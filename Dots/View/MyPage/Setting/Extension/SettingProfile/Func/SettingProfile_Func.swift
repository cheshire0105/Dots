import UIKit
import Toast_Swift
import SnapKit
import Firebase
import GoogleSignIn
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage


extension 프로필변경_화면 {
     func 버튼_클릭() {
        뒤로가기_버튼.addTarget(self, action: #selector(뒤로가기_버튼_클릭), for: .touchUpInside)
        새_프로필_이미지_버튼.addTarget(self, action: #selector(새_프로필_이미지_버튼_클릭), for: .touchUpInside)
        변경_버튼.addTarget(self, action: #selector(변경_버튼_클릭), for: .touchUpInside)
    }
    @objc private func 뒤로가기_버튼_클릭() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func 새_프로필_이미지_버튼_클릭() {
        let 이미지피커_컨트롤러 = UIImagePickerController()
        이미지피커_컨트롤러.delegate = self
        이미지피커_컨트롤러.sourceType = .photoLibrary
        present(이미지피커_컨트롤러, animated: true, completion: nil)
    }
    @objc private func 변경_버튼_클릭() {
        guard let email = Auth.auth().currentUser?.email,
              let newNickname = 새_닉네임_텍스트필드.text else {
            print("현재 로그인된 이메일 또는 새 닉네임을 가져올 수 없습니다.")
            return
        }
        
        if let 제공업체 = Auth.auth().currentUser?.providerData {
            for 유저정보 in 제공업체 {
                if 유저정보.providerID == "password" {
                    
                    print("도트회원 조회완료")
                    
                    
                    guard let image = 새_프로필_이미지_버튼.image(for: .selected) else {
                        print("프로필 이미지가 선택되지 않았습니다.")
                        return
                    }
                    
                    이미지_업로드(image) { result in
                        if case .success(let url) = result {
                            print("이미지 업로드 성공. URL: \(url)")
                            self.imageURL = url
                            
                            let 데이터베이스 = Firestore.firestore()
                            let 유저컬렉션 = 데이터베이스.collection("유저_데이터_관리")
                            let 쿼리 = 유저컬렉션.whereField("이메일", isEqualTo: email)
                            
                            쿼리.getDocuments { (querySnapshot, 에러) in
                                if let 에러 = 에러 {
                                    print("유저_데이터_관리에서 문서 조회 에러: \(에러.localizedDescription)")
                                } else {
                                    guard let 문서 = querySnapshot?.documents, !문서.isEmpty else {
                                        print("유저_데이터_관리에서 문서를 찾을 수 없습니다.")
                                        return
                                    }
                                    let 문서UID = 문서[0].documentID
                                    let 업데이트필드: [String: Any] = ["프로필이미지URL": url.absoluteString,
                                                                 "닉네임": newNickname
                                    ]
                                    
                                    
                                    유저컬렉션.document(문서UID).updateData(업데이트필드) { 에러 in
                                        if let 에러 = 에러 {
                                            print("유저_데이터_관리에서 문서 업데이트 에러: \(에러.localizedDescription)")
                                        } else {
                                            print("프로필 이미지 URL 및 닉네임 업데이트 성공")
                                            DispatchQueue.main.async {
                                                var 토스트 = ToastStyle()
                                                토스트.backgroundColor = UIColor(named: "neon") ?? UIColor.white
                                                토스트.messageColor = .black
                                                토스트.cornerRadius = 20
                                                
                                                self.view.makeToast(
                                                    " 회원님의 프로필이 업데이트 되었습니다. ",
                                                    duration: 2,
                                                    position: .top,
                                                    style: 토스트
                                                )
                                            }
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                                self.navigationController?.popViewController(animated: true)
                                            }
                                        }
                                    }
                                }
                            }
                        } else if case .failure(let 에러) = result {
                            print("이미지 업로드 실패. 에러: \(에러.localizedDescription)")
                        }
                    }
                }
            }
        }
    }
    
    
    
    private func 이미지_업로드(_ 이미지: UIImage, completion: @escaping (Result<URL, Error>) -> Void) {
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
}


extension 프로필변경_화면 {
    
     func 현재_유저_프로필이미지_적용하기() {
        guard let 현재접속중인유저 = Auth.auth().currentUser else {
            return
        }
        
        let 파이어스토어 = Firestore.firestore()
        let 이메일 = 현재접속중인유저.email ?? ""
        let 유저컬렉션: CollectionReference
        
        if let providerID = 현재접속중인유저.providerData.first?.providerID, providerID == GoogleAuthProviderID {
            유저컬렉션 = 파이어스토어.collection("유저_데이터_관리")
        } else {
            유저컬렉션 = 파이어스토어.collection("유저_데이터_관리")
        }
        
        유저컬렉션.whereField("이메일", isEqualTo: 현재접속중인유저.email ?? "").getDocuments { [weak self] (querySnapshot, error) in
            guard let self = self, let documents = querySnapshot?.documents, error == nil else {
                print("컬렉션 조회 실패")
                return
            }
            
            if let userDocument = documents.first {
                let 프로필이미지URL = userDocument["프로필이미지URL"] as? String ?? ""
                let 닉네임 = userDocument["닉네임"] as? String ?? ""
                
                
                DispatchQueue.main.async {
                    if let url = URL(string: 프로필이미지URL) {
                        self.새_프로필_이미지_버튼.sd_setImage(with: url, for: .normal, completed: nil)
                        self.새_프로필_이미지_버튼.sd_setImage(with: url, for: .selected, completed: nil)
                    }
                    self.새_닉네임_텍스트필드.text = 닉네임
                    
                    
                    
                }
            }
        }
    }
     func 캐시된_유저_데이터_마이페이지_적용하기() {
        var 닉네임_캐싱: String?
        var 이메일_캐싱: String?
        if let 캐시된닉네임 = 닉네임_캐싱, let 캐시된이메일 = 이메일_캐싱 {
            캐시된_유저_닉네임_변경하기_적용하기( 닉네임: 캐시된닉네임)
            return
        }
        
        guard let 현재접속중인유저 = Auth.auth().currentUser else {
            return
        }
        
        let 파이어스토어 = Firestore.firestore()
        let 이메일 = 현재접속중인유저.email ?? ""
        let 유저컬렉션: CollectionReference
        
        if let providerID = 현재접속중인유저.providerData.first?.providerID, providerID == GoogleAuthProviderID {
            유저컬렉션 = 파이어스토어.collection("유저_데이터_관리")
        } else {
            유저컬렉션 = 파이어스토어.collection("유저_데이터_관리")
        }
        
        유저컬렉션.whereField("이메일", isEqualTo: 이메일).getDocuments { [weak self] (querySnapshot, error) in
            guard let self = self, let documents = querySnapshot?.documents, error == nil else {
                print("컬렉션 조회 실패")
                return
            }
            
            if let userDocument = documents.first {
                let 프로필이미지URL = userDocument["프로필이미지URL"] as? String ?? ""
                let 닉네임 = userDocument["닉네임"] as? String ?? ""
                let 이메일 = userDocument["이메일"] as? String ?? ""
                
                닉네임_캐싱 = 닉네임
                이메일_캐싱 = 이메일
                
                DispatchQueue.main.async {
                    self.캐시된_유저_닉네임_변경하기_적용하기(닉네임: 닉네임_캐싱)
                    if let url = URL(string: 프로필이미지URL) {
                        self.새_프로필_이미지_버튼.sd_setImage(with: url, for: .normal, completed: nil)
                        self.새_프로필_이미지_버튼.sd_setImage(with: url, for: .selected, completed: nil)
                    }
                }
            }
        }
    }
    
     func 캐시된_유저_닉네임_변경하기_적용하기( 닉네임: String?) {
        
        if let 닉네임 = 닉네임 {
            self.새_닉네임_텍스트필드.text = 닉네임
        }
    }
}
