import UIKit
import AuthenticationServices
import FirebaseAuth
import FirebaseCore
import GoogleSignIn
import SnapKit
import Firebase
import Foundation
import UIKit
import FirebaseAuth
import FirebaseCore
import AuthenticationServices
import FirebaseFirestore

extension 로그인_뷰컨트롤러 {


    @objc func 구글_버튼_클릭() {
        print("구글 페이지로 연결")

        GIDSignIn.sharedInstance.signIn(withPresenting: self) { authentication, 에러 in
            if let 에러 = 에러 {
                print("There is an error signing the user in ==> \(에러)")
                return
            }
            guard let 구글계정 = authentication?.user, let idToken = 구글계정.idToken?.tokenString else { return }
            //앱체크 토큰가져오기 아직은 콘솔창에서 버전 파이어베이스 앱체크 api 부재로 못가져온다고나옴
            let 토큰가져오기 = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: 구글계정.accessToken.tokenString)


            Auth.auth().signIn(with: 토큰가져오기) { (authResult, 에러) in
                if let 에러 = 에러 {
                    print(에러.localizedDescription)
                    print("토큰가져오기 에러")
                } else {
                    print("구글 로그인 성공")

                    guard let 구글계정 = authResult?.user else { return }
                    let 구글이메일 = 구글계정.email ?? "default email"
                    let 구글닉네임 = 구글계정.displayName ?? "default name"
                    let 프로필이미지URL = 구글계정.photoURL?.absoluteString ?? "default image URL"
                    let 유저UID = 구글계정.uid
                    let 식별id = self.아이디_추출(구글이메일) // 구글은 email로부터 id 생성


                    // Firestore에 사용자 정보 저장 또는 업데이트
                    self.구글계정정보_파이어스토어_업로드(
                        회원가입_타입: "구글",
                        구글이메일: 구글이메일,
                        구글닉네임: 구글닉네임,
                        식별id: 식별id, // 여기에 식별id 값을 제공해야 합니다.
                        로그인상태: true,
                        프로필이미지URL: 프로필이미지URL,
                        유저UID: 유저UID
                    )


                    UserDefaults.standard.set(true, forKey: "isUserLoggedIn")

                    let 메인화면_이동 = TabBar()
                    self.navigationController?.pushViewController(메인화면_이동, animated: true)
                    self.navigationItem.hidesBackButton = true
                }
            }

        }
    }



    func 아이디_추출(_ email: String) -> String {
        let 이메일에서ID추출 = email.components(separatedBy: "@")
        guard 이메일에서ID추출.count == 2 else {
            print("ERROR: extractUsername")
            return ""
        }
        print("구글 계정 UID 생성 완료 : 파이어 스토어 문서화를 위함")
        return 이메일에서ID추출[0]
    }



    func 구글계정정보_파이어스토어_업로드(회원가입_타입: String, 구글이메일: String, 구글닉네임: String, 식별id: String, 로그인상태: Bool, 프로필이미지URL: String, 유저UID: String) {
        let 데이터베이스 = Firestore.firestore()

        // 유저UID를 문서 이름으로 사용
        let 유저컬렉션 = 데이터베이스.collection("유저_데이터_관리").document(유저UID)

        let 현재날짜시간 = Timestamp(date: Date())
        let userData: [String: Any] = [
            "회원가입_타입": 회원가입_타입,
            "로그인상태": 로그인상태,
            "닉네임": 구글닉네임,
            "이메일": 구글이메일,
            "프로필이미지URL": 프로필이미지URL,
            "마지막로그인": 현재날짜시간,
            "마지막로그아웃": "로그아웃 기록이 없음"
        ]

        유저컬렉션.setData(userData) { 에러 in
            if let 에러 = 에러 {
                print("Firestore 구글 데이터 등록 실패: \(에러.localizedDescription)")
            } else {
                print("구글 계정 auth 등록후 필요 데이터를 Firestore에 구글 데이터 등록 성공")
            }
        }
    }

}

extension 회원가입_첫번째_뷰컨트롤러 {

    @objc func 구글_버튼_클릭() {
        print("구글 페이지로 연결")

        GIDSignIn.sharedInstance.signIn(withPresenting: self) { authentication, 에러 in
            if let 에러 = 에러 {
                print("There is an error signing the user in ==> \(에러)")
                return
            }
            guard let 구글계정 = authentication?.user, let idToken = 구글계정.idToken?.tokenString else { return }
            //앱체크 토큰가져오기 아직은 콘솔창에서 버전 파이어베이스 앱체크 api 부재로 못가져온다고나옴
            let 토큰가져오기 = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: 구글계정.accessToken.tokenString)

            Auth.auth().signIn(with: 토큰가져오기) { (authResult, 에러) in
                if let 에러 = 에러 {
                    print(에러.localizedDescription)
                    print("토큰가져오기 에러")
                } else {
                    print("구글 로그인 성공")

                    let 구글이메일 = 구글계정.profile?.email ?? "default email"
                    let 구글닉네임 = 구글계정.profile?.name ?? "default name"
                    let 식별id = self.아이디_추출(구글이메일) // 구글은 email로부터 id 생성
                    let 프로필이미지URL = 구글계정.profile?.imageURL(withDimension: 200)?.absoluteString ?? "default image URL"

                    self.구글계정정보_파이어스토어_업로드(회원가입_타입: "구글", 구글이메일: 구글이메일, 구글닉네임: 구글닉네임, 식별id: 식별id, 로그인상태: true, 프로필이미지URL: 프로필이미지URL)

                    let 메인화면_이동 = TabBar()
                    self.navigationController?.pushViewController(메인화면_이동, animated: true)
                    self.navigationItem.hidesBackButton = true
                }
            }
        }
    }


    func 아이디_추출(_ email: String) -> String {
        let 이메일에서ID추출 = email.components(separatedBy: "@")
        guard 이메일에서ID추출.count == 2 else {
            print("ERROR: extractUsername")
            return ""
        }
        print("구글 계정 UID 생성 완료 : 파이어 스토어 문서화를 위함")
        return 이메일에서ID추출[0]
    }



    func 구글계정정보_파이어스토어_업로드(회원가입_타입: String,구글이메일: String, 구글닉네임: String, 식별id: String,로그인상태: Bool, 프로필이미지URL: String) {
        let 데이터베이스 = Firestore.firestore()
        let 유저컬렉션 = 데이터베이스.collection("유저_데이터_관리").document(식별id)
        let 현재날짜시간 = Timestamp(date: Date())

        let userData: [String: Any] = [
            "회원가입_타입": "구글",
            "로그인상태": true, // 로그인이 성공시 true
            "닉네임": 구글닉네임,
            "이메일": 구글이메일,
            "프로필이미지URL": 프로필이미지URL,
            "마지막로그인": 현재날짜시간,
            "마지막로그아웃": "로그아웃 기록이 없음"

        ]

        유저컬렉션.setData(userData) { 에러 in
            if let 에러 = 에러 {
                print("Firestore 구글 데이터 등록 실패: \(에러.localizedDescription)")
            } else {
                print("구글 계정 auth 등록후 필요 데이터를 Firestore에 구글 데이터 등록 성공")
            }
        }
    }
}

extension 로그인_뷰컨트롤러: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {

    @objc func 애플_버튼_클릭() {
        print("애플 로그인 시도")
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]

        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
            // 기존 코드 유지
            if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential, let appleIDToken = appleIDCredential.identityToken, let idTokenString = String(data: appleIDToken, encoding: .utf8) {
                let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: nil)

                Auth.auth().signIn(with: credential) { [weak self] (authResult, error) in
                    guard let self = self else { return }
                    if let error = error {
                        print("애플 로그인 에러: \(error.localizedDescription)")
                        return
                    }
                    print("애플 로그인 성공")


                    // 사용자 정보 가져오기
                                   guard let user = authResult?.user else { return }
                                   let 유저UID = user.uid

                    // Firestore에서 사용자 정보 조회
                                  self.사용자정보조회_및_처리(유저UID: 유저UID)

           
            }
        }
    }

    func 사용자정보조회_및_처리(유저UID: String) {
           let 데이터베이스 = Firestore.firestore()
           데이터베이스.collection("유저_데이터_관리").document(유저UID).getDocument { (document, error) in
               if let document = document, document.exists {
                   // 기존 사용자 정보가 있음: 로그인 처리
                   print("기존 사용자 정보 사용")
                   // 메인 화면으로 이동
                   self.메인화면으로_이동()
               } else {
                   // 새 사용자: 회원가입 처리 또는 적절한 조치
                   print("새 사용자 또는 사용자 정보 없음")
               }
           }
       }

       func 메인화면으로_이동() {

           UserDefaults.standard.set(true, forKey: "isUserLoggedIn")


           let 메인화면_이동 = TabBar()
           self.navigationController?.pushViewController(메인화면_이동, animated: true)
           self.navigationItem.hidesBackButton = true
       }

    // 애플 로그인 사용자 정보 Firestore에 저장
    func 애플계정정보_파이어스토어_업로드(회원가입_타입: String, 애플이메일: String, 애플닉네임: String, 유저UID: String, 로그인상태: Bool, 프로필이미지URL: String) {
        let 데이터베이스 = Firestore.firestore()
        let userData: [String: Any] = [
            "회원가입_타입": 회원가입_타입,
            "로그인상태": 로그인상태,
            "닉네임": 애플닉네임,
            "이메일": 애플이메일,
            "프로필이미지URL": 프로필이미지URL,
            "마지막로그인": Timestamp(date: Date()),
            "마지막로그아웃": "로그아웃 기록이 없음"
        ]
        데이터베이스.collection("유저_데이터_관리").document(유저UID).setData(userData) { 에러 in
            if let 에러 = 에러 {
                print("Firestore 애플 데이터 등록 실패: \(에러.localizedDescription)")
            } else {
                print("Firestore에 애플 데이터 등록 성공")
            }
        }
    }

    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}
