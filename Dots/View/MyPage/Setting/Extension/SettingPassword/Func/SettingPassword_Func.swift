import UIKit
import Toast_Swift
import FirebaseAuth
import FirebaseFirestore

extension 비밀번호변경_화면 {
    
    
     func 버튼_클릭() {
        뒤로가기_버튼.addTarget(self, action: #selector(뒤로가기_버튼_클릭), for: .touchUpInside)
        현재_비밀번호_표시_온오프.addTarget(self, action: #selector(현재_비밀번호_표시_온오프_클릭), for: .touchUpInside)
        새_비밀번호_표시_온오프.addTarget(self, action: #selector(새_비밀번호_표시_온오프_클릭), for: .touchUpInside)
        새_비밀번호_확인_표시_온오프.addTarget(self, action: #selector(새_비밀번호_확인_표시_온오프_클릭), for: .touchUpInside)
        변경_버튼.addTarget(self, action: #selector(변경_버튼_클릭), for: .touchUpInside)
        
    }
    @objc private func 뒤로가기_버튼_클릭() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func 변경_버튼_클릭() {
        비밀번호변경_완료_업로드_재로그인_실행_함수()
    }
    
    func 비밀번호변경_완료_업로드_재로그인_실행_함수(){
        guard let 새비밀번호 = 새_비밀번호_텍스트필드.text, !새비밀번호.isEmpty,
              let 새비밀번호확인 = 새_비밀번호_확인_텍스트필드.text, !새비밀번호확인.isEmpty else {
//            확인알럿(message: "새 비밀번호와 확인 비밀번호를 모두 입력해주세요.")
            var 토스트 = ToastStyle()
//            토스트.backgroundColor = UIColor(named: "neon") ?? UIColor.white
            토스트.backgroundColor = UIColor(red: 1, green: 0.269, blue: 0.269, alpha: 1)
            토스트.messageColor = .black
            토스트.cornerRadius = 20
            
            self.view.makeToast(
                "새/확인 비밀번호를 모두 입력해주세요.",
                duration: 2,
                position: .top,
                style: 토스트
            )
            새_비밀번호_백.layer.borderColor = UIColor.red.cgColor
            새_비밀번호_확인_백.layer.borderColor = UIColor.red.cgColor
            return
        }
        
        if 새비밀번호 != 새비밀번호확인 {
//            확인알럿(message: "새 비밀번호와 확인 비밀번호가 일치하지 않습니다.")
            var 토스트 = ToastStyle()
//            토스트.backgroundColor = UIColor(named: "neon") ?? UIColor.white
            토스트.backgroundColor = UIColor(red: 1, green: 0.269, blue: 0.269, alpha: 1)
            토스트.messageColor = .black
            토스트.cornerRadius = 20
            
            self.view.makeToast(
                "새/확인 비밀번호가 서로 일치하지 않습니다.",
                duration: 2,
                position: .top,
                style: 토스트
            )
            새_비밀번호_백.layer.borderColor = UIColor.red.cgColor
            새_비밀번호_확인_백.layer.borderColor = UIColor.red.cgColor
            return
        }
        
        if let 유저 = Auth.auth().currentUser {
            for auth에등록된계정 in 유저.providerData {
                let 제공업체 = auth에등록된계정.providerID
                if 제공업체 == "password" {
                    유저.updatePassword(to: 새비밀번호) { [weak self] (error) in
                        if let error = error {
                            self?.확인알럿(message: "비밀번호 업데이트 실패: \(error.localizedDescription)")
                        } else {
//                            self?.확인알럿(message: "비밀번호가 성공적으로 변경되었습니다.")
                            self?.새비밀번호_파이어스토어_업로드 (새비밀번호)
                          
                        }
                    }
                } else {
                    확인알럿(message: "도트회원가입 계정만 변경이 가능합니다.")
                }
            }
        } else {
            확인알럿(message: "접속중인 계정이 없습니다.")
        }
    }
    
    func 새비밀번호_파이어스토어_업로드 (_ 새비밀번호: String) {
            guard let 유저 = Auth.auth().currentUser, let 이메일 = 유저.email else {
                return
            }
            let 데이터베이스 = Firestore.firestore()
            let 유저데이터조회 = 데이터베이스.collection("유저_데이터_관리").whereField("이메일", isEqualTo: 이메일)
            
            유저데이터조회.getDocuments { [weak self] (snapshot, error) in
                guard let self = self, let 문서 = snapshot?.documents.first else {
                    return
                }
                
                if 문서.exists {
                    let 문서참조 = 데이터베이스.collection("유저_데이터_관리").document(문서.documentID)
                    문서참조.updateData(["비밀번호": 새비밀번호]) { error in
                        if let error = error {
                            self.확인알럿(message: "파이어스토어 비밀번호 업데이트 실패: \(error.localizedDescription)")
                        } else {
                            print("파이어스토어 비밀번호가 성공적으로 변경되었습니다.")
                            self.새비밀번호로_재접속시키기()
                        }
                    }
                } else {
                    print("유저 데이터를 찾을 수 없음")
                }
            }
        }
    func 새비밀번호로_재접속시키기() {
        if let 현재접속중인유저 = Auth.auth().currentUser {
            print("로그아웃한 사용자 정보:")
            print("UID: \(현재접속중인유저.uid)")
            print("이메일: \(현재접속중인유저.email ?? "없음")")
            
            let 파이어스토어 = Firestore.firestore()
            let 이메일 = 현재접속중인유저.email ?? ""
            let 유저컬렉션: CollectionReference
            
            if let providerID = 현재접속중인유저.providerData.first?.providerID, providerID == GoogleAuthProviderID {
                유저컬렉션 = 파이어스토어.collection("유저_데이터_관리")
            } else {
                유저컬렉션 = 파이어스토어.collection("유저_데이터_관리")
            }
            
            유저컬렉션.whereField("이메일", isEqualTo: 이메일).getDocuments { [weak self] (querySnapshot, 에러) in
                guard let self = self else { return }
                
                if let 에러 = 에러 {
                    print("Firestore 조회 에러: \(에러.localizedDescription)")
                } else {
                    if let 문서조회 = querySnapshot?.documents, !문서조회.isEmpty {
                        let 문서 = 문서조회[0]
                        let 현재날짜시간 = Timestamp(date: Date())
                        
                        문서.reference.updateData(["로그인상태": false, "마지막로그아웃": 현재날짜시간]) { (에러) in
                            if let 에러 = 에러 {
                                print("Firestore 업데이트 에러: \(에러.localizedDescription)")
                            } else {
                                print("Firestore: 로그인 상태 : false")
                                self.완료된_로그아웃_프로세스_시작()
                            }
                        }
                    } else {
                        print("Firestore: 일치하는 이메일이 없습니다.")
                    }
                }
            }
        }
    }

    func 완료된_로그아웃_프로세스_시작() {
        do {
            try Auth.auth().signOut()
            print("계정이 로그아웃되었습니다.")
            DispatchQueue.main.async {
                var 토스트 = ToastStyle()
                토스트.backgroundColor = UIColor(named: "neon") ?? UIColor.white
                토스트.messageColor = .black
                토스트.cornerRadius = 20
                
                self.view.makeToast(
                    " 새 비밀번호로 다시 로그인을 진행해주세요. ",
                    duration: 2,
                    position: .top,
                    style: 토스트
                )
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let 로그인_뷰컨트롤러 = 로그인_뷰컨트롤러()
            let 로그인화면_이동 = UINavigationController(rootViewController: 로그인_뷰컨트롤러)
            로그인화면_이동.modalPresentationStyle = .fullScreen
                self.dismiss(animated: false) {
                    UserDefaults.standard.removeObject(forKey: "isUserLoggedIn")
                    self.present(로그인화면_이동, animated: false, completion: nil)
                    self.새_비밀번호_텍스트필드.text = ""
                    self.새_비밀번호_확인_텍스트필드.text = ""
                }
            }
        } catch {
            print("로그아웃 실패: \(error.localizedDescription)")
        }
    }

    
    @objc func 현재_비밀번호_표시_온오프_클릭() {
        if 현재_비밀번호_텍스트필드.isSecureTextEntry == true {
            현재_비밀번호_표시_온오프.setImage(UIImage(systemName: "eye"), for: .normal)
            현재_비밀번호_표시_온오프.tintColor = UIColor(named: "neon")
            현재_비밀번호_텍스트필드.isSecureTextEntry = false
        } else if 현재_비밀번호_텍스트필드.isSecureTextEntry == false {
            현재_비밀번호_표시_온오프.setImage(UIImage(named: "passwordOFF"), for: .normal)
            현재_비밀번호_텍스트필드.isSecureTextEntry = true
        }
    }
    @objc func 새_비밀번호_표시_온오프_클릭() {
        if 새_비밀번호_텍스트필드.isSecureTextEntry == true {
            새_비밀번호_표시_온오프.setImage(UIImage(systemName: "eye"), for: .normal)
            새_비밀번호_표시_온오프.tintColor = UIColor(named: "neon")
            새_비밀번호_텍스트필드.isSecureTextEntry = false
        } else if 새_비밀번호_텍스트필드.isSecureTextEntry == false {
            새_비밀번호_표시_온오프.setImage(UIImage(named: "passwordOFF"), for: .normal)
            새_비밀번호_텍스트필드.isSecureTextEntry = true
        }
    }
    @objc func 새_비밀번호_확인_표시_온오프_클릭() {
        if 새_비밀번호_확인_텍스트필드.isSecureTextEntry == true {
            새_비밀번호_확인_표시_온오프.setImage(UIImage(systemName: "eye"), for: .normal)
            새_비밀번호_확인_표시_온오프.tintColor = UIColor(named: "neon")
            새_비밀번호_확인_텍스트필드.isSecureTextEntry = false
        } else if 새_비밀번호_확인_텍스트필드.isSecureTextEntry == false {
            새_비밀번호_확인_표시_온오프.setImage(UIImage(named: "passwordOFF"), for: .normal)
            새_비밀번호_확인_텍스트필드.isSecureTextEntry = true
        }
    }
}



extension 비밀번호변경_화면 {
    func 현재_비밀번호_실시간_조회_불러오기() {
        if let 유저 = Auth.auth().currentUser {
            for auth에등록된계정 in 유저.providerData {
                let 제공업체 = auth에등록된계정.providerID
                if 제공업체 == "password" {
                    let 이메일 = 유저.email
                    if let 이메일 = 이메일 {
                        let 데이터베이스 = Firestore.firestore()
                        let 유저데이터조회 = 데이터베이스.collection("유저_데이터_관리").whereField("이메일", isEqualTo: 이메일)
                        
                        유저데이터조회.addSnapshotListener { [weak self] (snapshot, error) in
                            guard let self = self, let 문서 = snapshot?.documents.first else { return }
                            
                            if 문서.exists {
                                let 비밀번호 = 문서["비밀번호"] as? String
                                self.현재_비밀번호_텍스트필드.text = 비밀번호
                            } else {
                                print("유저 데이터를 찾을 수 없음")
                            }
                        }
                    } else {
                        print("조회 결과 등록된 이메일이 없음")
                    }
                } else if 제공업체 == "google.com" {
                    
                    현재_비밀번호_텍스트필드.text = "구글 연동 로그인의 경우 사용 변경 불가"
                    현재_비밀번호_텍스트필드.textColor = UIColor.red
                    현재_비밀번호_텍스트필드.isEnabled = false
                    현재_비밀번호_텍스트필드.isSecureTextEntry = false
                    현재_비밀번호_표시_온오프.isHidden = true
                    
                    새_비밀번호_텍스트필드.text = "구글 연동 로그인의 경우 사용 변경 불가"
                    새_비밀번호_텍스트필드.textColor = UIColor.red
                    새_비밀번호_텍스트필드.isEnabled = false
                    새_비밀번호_텍스트필드.isSecureTextEntry = false
                    새_비밀번호_표시_온오프.isHidden = true
                    
                    새_비밀번호_확인_텍스트필드.text = "구글 연동 로그인의 경우 사용 변경 불가"
                    새_비밀번호_확인_텍스트필드.textColor = UIColor.red
                    새_비밀번호_확인_텍스트필드.isEnabled = false
                    새_비밀번호_확인_텍스트필드.isSecureTextEntry = false
                    새_비밀번호_확인_표시_온오프.isHidden = true
                    
                }
            }
        } else {
            print("접속중인 계정이 없는 경우 이 프린트가 출력됩니다. (뜨는 경우는 없을걸로 예상")
        }
    }
}


