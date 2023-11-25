import UIKit
import FirebaseAuth
import FirebaseCore
import GoogleSignIn
import SnapKit
import Firebase
import Foundation

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
                            
                            let 구글이메일 = 구글계정.profile?.email ?? "default email"
                            let 구글닉네임 = 구글계정.profile?.name ?? "default name"
                            let 식별id = self.아이디_추출(구글이메일) // 구글은 email로부터 id 생성
                            let 프로필이미지URL = 구글계정.profile?.imageURL(withDimension: 200)?.absoluteString ?? "default image URL"
                            
                            self.구글계정정보_파이어스토어_업로드(회원가입_타입: "구글", 구글이메일: 구글이메일, 구글닉네임: 구글닉네임, 식별id: 식별id, 로그인상태: true, 프로필이미지URL: 프로필이미지URL)
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
        let 유저컬렉션 = 데이터베이스.collection("구글_유저_데이터_관리").document(식별id)
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
        let 유저컬렉션 = 데이터베이스.collection("구글_유저_데이터_관리").document(식별id)
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

