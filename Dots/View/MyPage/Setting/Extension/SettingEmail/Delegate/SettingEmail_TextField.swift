import UIKit


extension 이메일변경_화면 {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
         if textField == 현재_이메일_텍스트필드 {
            // 이메일 규칙: 숫자 영문 소문자 - . _ 사용 가능
            let 입력제한사항 = CharacterSet(charactersIn: "0123456789abcdefghijklmnopqrstuvwxyz.@_-")
            let 제한사항준수 = string.rangeOfCharacter(from: 입력제한사항.inverted) == nil
            return 제한사항준수
        }
        else if textField == 새_이메일_텍스트필드 {
            // 이메일 규칙: 숫자 영문 소문자 - . _ 사용 가능
            let 입력제한사항 = CharacterSet(charactersIn: "0123456789abcdefghijklmnopqrstuvwxyz.@_-")
            let 제한사항준수 = string.rangeOfCharacter(from: 입력제한사항.inverted) == nil
            return 제한사항준수
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == 현재_이메일_텍스트필드 {
            새_이메일_텍스트필드.becomeFirstResponder()
        } else if textField == 새_이메일_텍스트필드 {
            새_이메일_텍스트필드.resignFirstResponder()
        }
        return true
    }
}

extension 이메일변경_화면: UITextFieldDelegate {
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        활성화된텍스트필드 = textField
        if textField == 현재_이메일_텍스트필드 {
            현재_이메일_백.layer.borderColor = UIColor(named: "neon")?.cgColor
            현재_이메일_백.layer.borderWidth = 1
        }
        else if textField == 새_이메일_텍스트필드 {
            새_이메일_백.layer.borderColor = UIColor(named: "neon")?.cgColor
            새_이메일_백.layer.borderWidth = 1
        }
      
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        활성화된텍스트필드 = nil
        if textField == 현재_이메일_텍스트필드 {
            새_이메일_백.layer.borderColor = UIColor.clear.cgColor
        }
        else if textField == 새_이메일_텍스트필드 {
            새_이메일_백.layer.borderColor = UIColor.clear.cgColor
        }
    }
}


extension 이메일변경_화면 {
        
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


