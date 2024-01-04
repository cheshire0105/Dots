import UIKit
import FirebaseFirestore

extension 켈린더_삭제_뷰컨트롤러 {
    
    func 버튼_클릭() {
        유지하기_버튼.addTarget(self, action: #selector(유지하기_버튼_클릭), for: .touchUpInside)
        삭제하기_버튼.addTarget(self, action: #selector(삭제하기_버튼_클릭), for: .touchUpInside)
    }
    
    @objc func 유지하기_버튼_클릭 () {
        print("다녀온 일정을 유지하겠습니다.")
        dismiss(animated: false, completion: nil)
        
    }
    @objc func 삭제하기_버튼_클릭() {
        print("다녀온 일정을 삭제했습니다.")
        
        if let 리뷰문서ID = 삭제할셀데이터?.리뷰문서ID,
           let 포스터스문서ID = 삭제할셀데이터?.포스터스문서ID {
            
            let db = Firestore.firestore()
            
            let 문서조회 = db.collection("posters").document(포스터스문서ID)
            let 서브문서조회 = 문서조회.collection("reviews").document(리뷰문서ID)
            
            서브문서조회.delete { error in
                if let error = error {
                    print("리뷰 서브컬렉션 문서 삭제 실패: \(error.localizedDescription)")
                } else {
                    print("리뷰 서브컬렉션 문서 삭제 성공")
                }
            }
            dismiss(animated: false, completion: nil)
        }
    }
}

