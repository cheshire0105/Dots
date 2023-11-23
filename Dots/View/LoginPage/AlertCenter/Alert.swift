import Foundation
import UIKit

class 알럿센터 : UIViewController {
    
    static var 알럿_메시지 = 알럿센터()
//
//    func 커스텀_알럿(알럿_제목: String, 알럿_메세지: String, 취소_버튼_이름: String, 확인_버튼_이름: String) {
//        let 알럿 = UIAlertController(title: 알럿_제목, message: 알럿_메세지, preferredStyle: .alert)
//        알럿.addAction(커스텀_알럿_취소_버튼(취소_버튼_이름: 취소_버튼_이름))
//        알럿.addAction(커스텀_알럿_확인_버튼(확인_버튼_이름: 확인_버튼_이름))
//        self.present(알럿, animated: true, completion: nil)
//    }
//    func 커스텀_알럿_취소_버튼(취소_버튼_이름: String) -> UIAlertAction {
//        let 취소_버튼 = UIAlertAction(title: 취소_버튼_이름, style: .cancel, handler: nil)
//        return 취소_버튼
//    }
//
//    func 커스텀_알럿_확인_버튼(확인_버튼_이름: String) -> UIAlertAction {
//        let 확인_버튼 = UIAlertAction(title: 확인_버튼_이름, style: .destructive, handler: nil)
//        return 확인_버튼
//    }
    


        func 경고_알럿(알럿_메세지: String, presentingViewController: UIViewController) {
            let 알람 = UIAlertController(title: "경고", message: 알럿_메세지, preferredStyle: .alert)
            let 확인_버튼 = UIAlertAction(title: "확인", style: .default, handler: nil)
            알람.addAction(확인_버튼)
            
            presentingViewController.present(알람, animated: true, completion: nil)
        }
        
    }
    
