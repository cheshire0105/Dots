import UIKit
import Firebase
import FirebaseFirestore



extension 켈린더_수정_뷰컨트롤러 {
    func 버튼_클릭() {
        변경하기_버튼.addTarget(self, action: #selector(변경하기_버튼_클릭), for: .touchUpInside)
    }
    @objc func 변경하기_버튼_클릭() {
        let 선택된년도 = 년도[연월일_피커뷰.selectedRow(inComponent: 0)]
        let 선택된월 = 월[연월일_피커뷰.selectedRow(inComponent: 1)]
        let 선택된일 = 일[연월일_피커뷰.selectedRow(inComponent: 2)]
        
        //            let 결과값 = "\(선택된년도)-\(선택된월)-\(선택된일)"
        let formattedMonth = String(format: "%02d", Int(선택된월)!)
        let formattedDay = String(format: "%02d", Int(선택된일)!)
        
        let 결과값 = "\(선택된년도)-\(formattedMonth)-\(formattedDay)"
        
        
        if let 리뷰문서ID = 수정할셀데이터?.리뷰문서ID,
           let 포스터스문서ID = 수정할셀데이터?.포스터스문서ID {
            
            let db = Firestore.firestore()
            
            let reviewsRef = db.collection("posters").document(포스터스문서ID).collection("reviews").document(리뷰문서ID)
            
            let errorHandler: (Error) -> Void = { error in
                print("리뷰 서브컬렉션 문서 업데이트 실패: \(error.localizedDescription)")
            }
            
            DispatchQueue.global(qos: .background).async {
                reviewsRef.updateData(["유저_다녀옴_날짜": 결과값]) { error in
                    if let error = error {
                        errorHandler(error)
                    } else {
                        print("리뷰 서브컬렉션 문서 업데이트 성공")
                        
                        DispatchQueue.main.async {
                            if let 수정된셀데이터 = self.수정할셀데이터 {
                             
                                
                            }
                        }
                    }
                }
            }
        }
        dismiss(animated: false, completion: nil)
    }
}




extension 켈린더_수정_뷰컨트롤러 {
    func 년월일_피커뷰_초기값 () {
        let 현제값_데이터 = Date()
        let 켈린더 = Calendar.current
        let 현제_년 = 켈린더.component(.year, from: 현제값_데이터) - 2000
        let 현제_달 = 켈린더.component(.month, from: 현제값_데이터) - 1
        let 현제_일 = 켈린더.component(.day, from: 현제값_데이터) - 1
        연월일_피커뷰.selectRow(현제_년, inComponent: 0, animated: true)
        연월일_피커뷰.selectRow(현제_달, inComponent: 1, animated: true)
        연월일_피커뷰.selectRow(현제_일, inComponent: 2, animated: true)
    }
}
