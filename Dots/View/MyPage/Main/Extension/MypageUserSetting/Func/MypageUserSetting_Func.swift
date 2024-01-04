import UIKit
import GoogleSignIn
import FirebaseAuth
import FirebaseFirestore
import SnapKit

extension 마이페이지_설정_페이지  {
    
     func 버튼_클릭() {
        뒤로가기_버튼.addTarget(self, action: #selector(뒤로가기_버튼_클릭), for: .touchUpInside)
    }
    @objc func 뒤로가기_버튼_클릭() {
        navigationController?.popViewController(animated: true)
    }
    @objc func 프로필스위치변경(sender: UISwitch) {
        let indexPath = IndexPath(row: 0, section: 0)
        설정아이템들[indexPath.section][indexPath.row].isSwitchOn = sender.isOn
    }
    @objc func 셀_클릭(for cell: 설정_셀) {
        if let 셀_제목_라벨 = cell.버튼_이름_라벨.text {
            print("선택된 셀의 라벨: \(셀_제목_라벨)")
            if 셀_제목_라벨 == "프로필 변경" {
                let 프로필변경_화면이동 = 프로필변경_화면()
                navigationController?.pushViewController(프로필변경_화면이동, animated: true)
            }
            else if 셀_제목_라벨 == "이메일 변경" {
                let 이메일변경_화면이동 = 이메일변경_화면()
                navigationController?.pushViewController(이메일변경_화면이동, animated: true)
            }
            else if 셀_제목_라벨 == "비밀번호 변경" {
                let 비밀번호변경_화면이동 = 비밀번호변경_화면()
                navigationController?.pushViewController(비밀번호변경_화면이동, animated: true)
            }
            else if 셀_제목_라벨 == "알림 설정" {
                let 알림설정_화면이동 = 알림설정_화면()
                navigationController?.pushViewController(알림설정_화면이동, animated: true)
            }
            else if 셀_제목_라벨 == "로그아웃" {
                let 로그아웃_알럿 = UIAlertController(title: "로그아웃", message: "지금 사용중인 기기에서 로그아웃을 진행할까요?", preferredStyle: .alert)
                
                let 로그아웃취소_버튼 = UIAlertAction(title: "취소", style: .cancel, handler: nil)
                로그아웃_알럿.addAction(로그아웃취소_버튼)
                
                let 로그아웃확인_버튼 = UIAlertAction(title: "로그아웃", style: .destructive) { _ in
                    self.로그아웃_유저로그아웃()
                }
                로그아웃_알럿.addAction(로그아웃확인_버튼)
                
                present(로그아웃_알럿, animated: true, completion: nil)
            }
            else if 셀_제목_라벨 == "회원 탈퇴" {
                let 회원탈퇴_알럿 = UIAlertController(title: "회원탈퇴", message: "모든 정보가 삭제됩니다. 정말 탈퇴하시나요 ?", preferredStyle: .alert)

                let 회원탈퇴취소_버튼 = UIAlertAction(title: "취소", style: .cancel, handler: nil)
                회원탈퇴_알럿.addAction(회원탈퇴취소_버튼)

                let 회원탈퇴확인_버튼 = UIAlertAction(title: "회원탈퇴", style: .destructive) { _ in
                    self.회원탈퇴_기능()
                }
                회원탈퇴_알럿.addAction(회원탈퇴확인_버튼)

                present(회원탈퇴_알럿, animated: true, completion: nil)

            }
            
        }
    }
}

extension 마이페이지_설정_페이지 {
    
    func 로그아웃_유저로그아웃() {
        do {
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
                                    self.로그아웃_프로세스_완료()
                                }
                            }
                        } else {
                            print("Firestore: 일치하는 이메일이 없습니다.")
                            self.로그아웃_프로세스_완료()
                        }
                    }
                }
            }
        } catch {
            print("로그아웃 실패: \(error.localizedDescription)")
        }
    }
    
    func 로그아웃_프로세스_완료() {
        do {
            try Auth.auth().signOut()
            print("계정이 로그아웃되었습니다.")
            let 로그인_뷰컨트롤러 = 로그인_뷰컨트롤러()
            let 로그인화면_이동 = UINavigationController(rootViewController: 로그인_뷰컨트롤러)
            로그인화면_이동.modalPresentationStyle = .fullScreen
            present(로그인화면_이동, animated: false, completion: nil)
            UserDefaults.standard.removeObject(forKey: "isUserLoggedIn")
        } catch {
            print("로그아웃 실패: \(error.localizedDescription)")
        }
    }
}


extension 마이페이지_설정_페이지 {
    
    func 회원탈퇴_기능() {
          if let 현재접속중인유저 = Auth.auth().currentUser {
              if let 제공업체 = 현재접속중인유저.providerData.first?.providerID {
                  switch 제공업체 {
                  case "google.com":
                      // 구글 계정일 경우 처리
                      계정탈퇴_알럿_표시(제목: "구글 계정입니다.", 메시지: "구글 계정은 회원 탈퇴 서비스를 지원하지 않습니다.")
                  case "apple.com":
                      // 애플 계정일 경우 처리
                      계정탈퇴_알럿_표시(제목: "애플 계정입니다.", 메시지: "애플 계정은 회원 탈퇴 서비스를 지원하지 않습니다.")
                  case "password":
                      // 이메일/비밀번호 계정일 경우 처리
                      회원탈퇴_auth()
                  default:
                      print("지원되지 않는 계정 타입입니다.")
                  }
              }
          } else {
              print("도트 회원가입 자체 서비스 방식으로 가입한 계정이 아닙니다.")
          }
      }

    func 계정탈퇴_알럿_표시(제목: String, 메시지: String) {
        let 알럿 = UIAlertController(title: 제목, message: 메시지, preferredStyle: .alert)
        let 확인액션 = UIAlertAction(title: "확인", style: .default, handler: nil)
        알럿.addAction(확인액션)
        self.present(알럿, animated: true, completion: nil)
    }

    
    func 회원탈퇴_auth() {
        if let user = Auth.auth().currentUser {
            let 재인증요청_텍스트필드_알럿 = UIAlertController(title: "회원탈퇴", message: "회원탈퇴 진행을 위해 비밀번호를 입력하세요.", preferredStyle: .alert)
            
            재인증요청_텍스트필드_알럿.addTextField { textField in
                textField.placeholder = "비밀번호"
                textField.isSecureTextEntry = true
            }
            
            let 취소액션 = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            재인증요청_텍스트필드_알럿.addAction(취소액션)
            
            let 확인액션 = UIAlertAction(title: "확인", style: .default) { [weak self] _ in
                guard let self = self, let passwordTextField = 재인증요청_텍스트필드_알럿.textFields?.first else { return }
                
                let password = passwordTextField.text ?? ""
                let credential = EmailAuthProvider.credential(withEmail: user.email!, password: password)
                
                user.reauthenticate(with: credential) { _, error in
                    if let error = error {
                        print("재인증 실패: \(error.localizedDescription)")
                    } else {
                        self.파이어스토어에서_도트회원_정보_삭제 ()
                        DispatchQueue.main.async {
                            let 로그인_뷰컨트롤러 = 로그인_뷰컨트롤러()
                            let 로그인화면_이동 = UINavigationController(rootViewController: 로그인_뷰컨트롤러)
                            로그인화면_이동.modalPresentationStyle = .fullScreen

                            self.present(로그인화면_이동, animated: true, completion: nil)
                        }
                    }
                }
            }
            재인증요청_텍스트필드_알럿.addAction(확인액션)
            self.present(재인증요청_텍스트필드_알럿, animated: false, completion: nil)
        }
    }
    func 파이어스토어에서_도트회원_정보_삭제 () {
        if let 현재접속중인유저 = Auth.auth().currentUser {
            if let 제공업체 = 현재접속중인유저.providerData.first?.providerID, 제공업체 == "password" {
                let 데이터베이스 = Firestore.firestore()
                let 유저컬렉션 = 데이터베이스.collection("유저_데이터_관리")
                
                유저컬렉션.document(현재접속중인유저.uid).delete { error in
                    if let error = error {
                        print("Firestore에서 사용자 데이터 삭제 실패: \(error.localizedDescription)")
                    } else {
                        print("Firestore에서 사용자 데이터 삭제 성공")
                        
                        현재접속중인유저.delete { error in
                            if let error = error {
                                print("Firebase Authentication에서 사용자 삭제 실패: \(error.localizedDescription)")
                            } else {
                                print("Firebase Authentication에서 사용자 삭제 성공")
                                self.실제_계정탈퇴()
                            }
                        }
                    }
                }
            }
        }
    }
    func 실제_계정탈퇴() {
        do {
            try Auth.auth().currentUser?.delete(completion: { [weak self] error in
                guard let self = self else { return }

                if let error = error {
                    print("계정 탈퇴 실패: \(error.localizedDescription)")
                } else {
                    print("계정이 성공적으로 탈퇴되었습니다.")
                   
                }
            })
        } catch {
            print("탈퇴 실패: \(error.localizedDescription)")
        }
    }

}
