import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
import GoogleSignIn


extension 이메일변경_화면 {
    
     func 버튼_클릭() {
        뒤로가기_버튼.addTarget(self, action: #selector(뒤로가기_버튼_클릭), for: .touchUpInside)
        변경_버튼.addTarget(self, action: #selector(변경_버튼_클릭), for: .touchUpInside)
        
    }
    @objc private func 뒤로가기_버튼_클릭() {
        navigationController?.popViewController(animated: true)
    }
}


extension 이메일변경_화면 {
    @objc func 변경_버튼_클릭 () {
        
    }
}
