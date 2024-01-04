import UIKit

extension 켈린더_수정_뷰컨트롤러 : UIPickerViewDelegate , UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return 년도.count
        case 1:
            return 월.count
        case 2:
            return 일.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let 픽커뷰_년월일_텍스속성 = UILabel()
        
        switch component {
        case 0:
            픽커뷰_년월일_텍스속성.text = "\(년도[row])년"
            픽커뷰_년월일_텍스속성.textColor = .black
        case 1:
            픽커뷰_년월일_텍스속성.text = "\(월[row])월"
            픽커뷰_년월일_텍스속성.textColor = .black
        case 2:
            픽커뷰_년월일_텍스속성.text = "\(일[row])일"
            픽커뷰_년월일_텍스속성.textColor = .black
        default:
            break
        }
        
        픽커뷰_년월일_텍스속성.font = UIFont(name: "Pretendard-SemiBold", size: 15)
        픽커뷰_년월일_텍스속성.textAlignment = .center
        
        return 픽커뷰_년월일_텍스속성
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    }
}
