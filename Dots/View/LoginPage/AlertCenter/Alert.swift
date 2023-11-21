import Foundation
import UIKit

class 알럿센터 : UIViewController {
    
    static var 알럿_메시지 = 알럿센터()
    
     func 경고_알럿(message: String) {
        let alert = UIAlertController(title: "경고", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
}
