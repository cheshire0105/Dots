import UIKit
import Firebase
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth
import SDWebImage


extension Mypage {
    func 버튼_클릭() {
        마이페이지_설정_버튼.addTarget(self, action: #selector(마이페이지_설정_버튼_클릭), for: .touchUpInside)
        마이페이지_알림_버튼.addTarget(self, action: #selector(마이페이지_알림_버튼_클릭), for: .touchUpInside)
        마이페이지_전시_버튼.addTarget(self, action: #selector(마이페이지_전시_버튼_클릭), for: .touchUpInside)
        마이페이지_후기_버튼.addTarget(self, action: #selector(마이페이지_후기_버튼_클릭), for: .touchUpInside)
        마이페이지_보관함_버튼.addTarget(self, action: #selector(마이페이지_보관함_버튼_클릭), for: .touchUpInside)
    }
    @objc func 마이페이지_설정_버튼_클릭() {
        let 설정_이동 = 마이페이지_설정_페이지()
        self.navigationController?.pushViewController(설정_이동, animated: false)
        self.navigationItem.hidesBackButton = true
        self.dismiss(animated: false, completion: nil)
        
    }
    
    @objc func 마이페이지_알림_버튼_클릭() {
        //        let 알림_이동 = 마이페이지_알림()
        //        self.navigationController?.pushViewController(알림_이동, animated: true)
        //        self.navigationItem.hidesBackButton = true
        //        self.dismiss(animated: false, completion: nil)
    }
    @objc func 마이페이지_전시_버튼_클릭 () {
        let 전시_이동 = 마이페이지_전시()
        self.navigationController?.pushViewController(전시_이동, animated: true)
        self.navigationItem.hidesBackButton = true
        self.dismiss(animated: false, completion: nil)
        
    }
    @objc func 마이페이지_후기_버튼_클릭 () {
        let 후기_이동 = 마이페이지_리뷰()
        self.navigationController?.pushViewController(후기_이동, animated: true)
        self.navigationItem.hidesBackButton = true
        self.dismiss(animated: false, completion: nil)
        
    }
    @objc func 마이페이지_보관함_버튼_클릭 () {
        let 보관함_이동 = 마이페이지_보관함()
        self.navigationController?.pushViewController(보관함_이동, animated: true)
        self.navigationItem.hidesBackButton = true
        self.dismiss(animated: false, completion: nil)
        
    }
    
}

extension Mypage {
  
     func 캐시된_유저_데이터_마이페이지_적용하기() {
        var 닉네임_캐싱: String?
        var 이메일_캐싱: String?
        if let 캐시된닉네임 = 닉네임_캐싱, let 캐시된이메일 = 이메일_캐싱 {
            캐시된_유저_닉네임_이메일_마이페이지_적용하기( 닉네임: 캐시된닉네임, 이메일: 캐시된이메일)
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
                    self.캐시된_유저_닉네임_이메일_마이페이지_적용하기(닉네임: 닉네임_캐싱, 이메일: 이메일_캐싱)
                    if let url = URL(string: 프로필이미지URL) {
                        self.마이페이지_프로필_이미지_버튼.sd_setImage(with: url, for: .normal, completed: nil)
                    }
                }
            }
        }
    }
    
     func 캐시된_유저_닉네임_이메일_마이페이지_적용하기( 닉네임: String?, 이메일: String?) {
        
        if let 닉네임 = 닉네임 {
            self.마이페이지_프로필_닉네임.text = 닉네임
        }
        
        if let 이메일 = 이메일 {
            self.마이페이지_프로필_이메일.text = 이메일
        }
    }
}
