import UIKit



extension 프로필변경_화면: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == 새_닉네임_텍스트필드 {
            // 닉네임 규칙: 2~8자, 한글과 영문만 가능
            //                let 입력제한사항 = CharacterSet(charactersIn: "가-힣")
            //                let 제한사항준수 = string.rangeOfCharacter(from: 입력제한사항.inverted) == nil
            let 글자수제한 = (textField.text?.count ?? 0) + string.count
            return /*제한사항준수 &&*/ (글자수제한 <= 8)
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == 새_닉네임_텍스트필드 {
            새_닉네임_텍스트필드.becomeFirstResponder()
        }
        return true
    }
}
extension 프로필변경_화면 {
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        활성화된텍스트필드 = textField
        if textField == 새_닉네임_텍스트필드 {
            새_닉네임_백.layer.borderColor = UIColor(named: "neon")?.cgColor
            새_닉네임_백.layer.borderWidth = 1
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        활성화된텍스트필드 = nil
        if textField == 새_닉네임_텍스트필드 {
            새_닉네임_백.layer.borderColor = UIColor.clear.cgColor
        }
    }
}

extension 프로필변경_화면 {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        self.view.frame.origin.y = 0
    }
    
    @objc func 키보드가올라올때(notification: NSNotification) {
        guard let 키보드크기 = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
              let 활성화된텍스트필드 = 활성화된텍스트필드 else {
            return
        }
        
        let 텍스트필드끝 = 활성화된텍스트필드.frame.origin.y + 활성화된텍스트필드.frame.size.height
        let 키보드시작 = view.frame.size.height - 키보드크기.height
        
        if 텍스트필드끝 > 키보드시작 {
            let 이동거리 = 키보드시작 - 텍스트필드끝
            view.frame.origin.y = 이동거리
        }
    }
}



