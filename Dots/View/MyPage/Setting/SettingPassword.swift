import UIKit

class 비밀번호변경_화면 : UIViewController {
    
    var 활성화된텍스트필드: UITextField?
    
    private let 뒤로가기_버튼 = {
        let button = UIButton()
        button.setImage(UIImage(named: "loginBack"), for: .selected)
        button.isSelected = !button.isSelected
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        return button
    } ()
    
    private let 페이지_제목 = {
        let label = UILabel()
        label.text = "비밀번호 변경"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    private let 현재_비밀번호_백 = {
        let uiView = UIView()
        uiView.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
        uiView.layer.cornerRadius = 10
        return uiView
    }()
    private let 현재_비밀번호_텍스트필드 = { ()
        let textField = UITextField()
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.darkGray,
            .font: UIFont.boldSystemFont(ofSize: 14)
        ]
        textField.attributedPlaceholder = NSAttributedString(string: "현재 비밀번호", attributes: attributes)
        textField.textColor = UIColor.white
        textField.tintColor = UIColor(named: "neon")
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 10
       
        textField.backgroundColor = UIColor.clear
        textField.textAlignment = .left
        textField.font = UIFont.boldSystemFont(ofSize: 14)
        
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        
        textField.clearButtonMode = .whileEditing
        textField.rightViewMode = .whileEditing
        textField.isEnabled = false
        
        return textField
    } ()
    private let 새_비밀번호_백 = {
        let uiView = UIView()
        uiView.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
        uiView.layer.cornerRadius = 10
        return uiView
    }()
    
    private let 새_비밀번호_텍스트필드 = { ()
        let textField = UITextField()
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.darkGray,
            .font: UIFont.boldSystemFont(ofSize: 14)
        ]
        textField.attributedPlaceholder = NSAttributedString(string: "8~16자사이의 영문(소문자) + 숫자를 입력해주세요", attributes: attributes)
        textField.textColor = UIColor.white
        textField.tintColor = UIColor(named: "neon")
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 10
       
        textField.backgroundColor = UIColor.clear
        textField.textAlignment = .left
        textField.font = UIFont.boldSystemFont(ofSize: 14)
        
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        
        textField.clearButtonMode = .whileEditing
        textField.rightViewMode = .whileEditing
        
        return textField
    } ()
    
    private let 새_비밀번호_확인_백 = {
        let uiView = UIView()
        uiView.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
        uiView.layer.cornerRadius = 10
        return uiView
    }()
    
    private let 새_비밀번호_확인_텍스트필드 = { ()
        let textField = UITextField()
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.darkGray,
            .font: UIFont.boldSystemFont(ofSize: 14)
        ]
        textField.attributedPlaceholder = NSAttributedString(string: "8~16자사이의 영문(소문자) + 숫자를 입력해주세요", attributes: attributes)
        textField.textColor = UIColor.white
        textField.tintColor = UIColor(named: "neon")
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 10
       
        textField.backgroundColor = UIColor.clear
        textField.textAlignment = .left
        textField.font = UIFont.boldSystemFont(ofSize: 14)
        
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        
        textField.clearButtonMode = .whileEditing
        textField.rightViewMode = .whileEditing
        
        return textField
    } ()
    
    var 구분선 = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "구분선")
        imageView.layer.cornerRadius = 10
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    
    private let 현재비밀번호_라벨 = {
        let label = UILabel()
        label.text = "현재 비밀번호"
        label.textColor = UIColor.darkGray
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .left
        return label
    }()
    private let 새비밀번호_라벨 = {
        let label = UILabel()
        label.text = "새 비밀번호 입력"
        label.textColor = UIColor.darkGray
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .left
        return label
    }()
    private let 새비밀번호확인_라벨 = {
        let label = UILabel()
        label.text = "새 비밀번호 확인"
        label.textColor = UIColor.darkGray
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .left
        return label
    }()
    
    
    private let 변경_버튼 = {
        let button = UIButton()
        button.setTitle("변경", for: .selected)
        button.setTitle("변경", for: .normal)
        button.setTitleColor(UIColor(named: "neon"), for: .normal)
        button.setTitleColor(UIColor.black, for: .selected)
        button.backgroundColor = UIColor(named: "neon")
        button.isSelected = !button.isSelected
        button.layer.cornerRadius = 10
        return button
    } ()
    
    override func viewDidLoad() {
        view.backgroundColor = .black
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 0.3
        
        NotificationCenter.default.addObserver(self, selector: #selector(키보드가올라올때), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        UI레이아웃()
        버튼_클릭()
        화면_제스쳐_실행()
        
        새_비밀번호_텍스트필드.delegate = self
        현재_비밀번호_텍스트필드.delegate = self
        새_비밀번호_확인_텍스트필드.delegate = self
    }
    
    deinit {
        // 메모리 해제 시 리스너 제거
        NotificationCenter.default.removeObserver(self)
    }
    
    
}


extension 비밀번호변경_화면{
    
    private func UI레이아웃 () {
        view.addSubview(뒤로가기_버튼)
        view.addSubview(페이지_제목)
        view.addSubview(현재_비밀번호_백)
        view.addSubview(현재_비밀번호_텍스트필드)
        view.addSubview(새_비밀번호_백)
        view.addSubview(새_비밀번호_텍스트필드)
        view.addSubview(새_비밀번호_확인_백)
        view.addSubview(새_비밀번호_확인_텍스트필드)
        view.addSubview(구분선)
        view.addSubview(변경_버튼)
        view.addSubview(현재비밀번호_라벨)
        view.addSubview(새비밀번호_라벨)
        view.addSubview(새비밀번호확인_라벨)
        
        뒤로가기_버튼.snp.makeConstraints { make in
            make.centerY.equalTo(페이지_제목.snp.centerY)
            make.leading.equalToSuperview().offset(16)
            make.size.equalTo(40)
        }
        페이지_제목.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.centerX.equalToSuperview()
            make.height.equalTo(44)
        }
        현재_비밀번호_백.snp.makeConstraints { make in
            make.top.equalTo(페이지_제목.snp.bottom).offset(86)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(44)
        }
        현재_비밀번호_텍스트필드.snp.makeConstraints { make in
            make.top.equalTo(현재_비밀번호_백)
            make.leading.equalTo(현재_비밀번호_백).offset(15)
            make.trailing.equalTo(현재_비밀번호_백).offset(-15)
            make.height.equalTo(44)
        }
        
        새_비밀번호_백.snp.makeConstraints { make in
            make.top.equalTo(현재_비밀번호_텍스트필드.snp.bottom).offset(60)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(44)
        }
        새_비밀번호_텍스트필드.snp.makeConstraints { make in
            make.top.equalTo(새_비밀번호_백)
            make.leading.equalTo(새_비밀번호_백).offset(15)
            make.trailing.equalTo(새_비밀번호_백).offset(-15)
            make.height.equalTo(44)
        }
        새_비밀번호_확인_백.snp.makeConstraints { make in
            make.top.equalTo(새_비밀번호_텍스트필드.snp.bottom).offset(45)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(44)
        }
        새_비밀번호_확인_텍스트필드.snp.makeConstraints { make in
            make.top.equalTo(새_비밀번호_확인_백)
            make.leading.equalTo(새_비밀번호_확인_백).offset(15)
            make.trailing.equalTo(새_비밀번호_확인_백).offset(-15)
            make.height.equalTo(44)
        }
        구분선.snp.makeConstraints { make in
            make.top.equalTo(새_비밀번호_확인_텍스트필드.snp.bottom).offset(141)
        }
        변경_버튼.snp.makeConstraints { make in
            make.top.equalTo(구분선.snp.bottom).offset(15)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(32)
            make.width.equalTo(74)
        }
        현재비밀번호_라벨.snp.makeConstraints { make in
            make.bottom.equalTo(현재_비밀번호_백.snp.top)
            make.leading.equalTo(현재_비밀번호_백.snp.leading)
            make.height.equalTo(22)
        }
        새비밀번호_라벨.snp.makeConstraints { make in
            make.bottom.equalTo(새_비밀번호_백.snp.top)
            make.leading.equalTo(새_비밀번호_백.snp.leading)
            make.height.equalTo(22)
        }
        새비밀번호확인_라벨.snp.makeConstraints { make in
            make.bottom.equalTo(새_비밀번호_확인_백.snp.top)
            make.leading.equalTo(새_비밀번호_확인_백.snp.leading)
            make.height.equalTo(22)
        }
        
    }
    private func 버튼_클릭() {
        뒤로가기_버튼.addTarget(self, action: #selector(뒤로가기_버튼_클릭), for: .touchUpInside)
    }
    @objc private func 뒤로가기_버튼_클릭() {
        navigationController?.popViewController(animated: true)
    }
}



extension 비밀번호변경_화면 {
    
    func 화면_제스쳐_실행 () {
        let 화면_제스쳐 = UISwipeGestureRecognizer(target: self, action: #selector(화면_제스쳐_뒤로_가기))
        화면_제스쳐.direction = .right
        view.addGestureRecognizer(화면_제스쳐)
    }
    @objc private func 화면_제스쳐_뒤로_가기() {
        navigationController?.popViewController(animated: true)
    }
    
}



extension 비밀번호변경_화면 {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == 현재_비밀번호_텍스트필드 {
            // 비밀번호 규칙: 숫자와 영문 소문자만 가능, 8~16자
            let 입력제한사항 = CharacterSet(charactersIn: "0123456789abcdefghijklmnopqrstuvwxyz")
            let 제한사항준수 = string.rangeOfCharacter(from: 입력제한사항.inverted) == nil
            let 글자수제한 = (textField.text?.count ?? 0) + string.count
            return 제한사항준수 && (글자수제한 <= 16)
        }
        
        else if textField == 새_비밀번호_텍스트필드 {
            // 비밀번호 규칙: 숫자와 영문 소문자만 가능, 8~16자
            let 입력제한사항 = CharacterSet(charactersIn: "0123456789abcdefghijklmnopqrstuvwxyz")
            let 제한사항준수 = string.rangeOfCharacter(from: 입력제한사항.inverted) == nil
            let 글자수제한 = (textField.text?.count ?? 0) + string.count
            return 제한사항준수 && (글자수제한 <= 16)
        }
        
        else if textField == 새_비밀번호_확인_텍스트필드 {
            // 비밀번호 규칙: 숫자와 영문 소문자만 가능, 8~16자
            let 입력제한사항 = CharacterSet(charactersIn: "0123456789abcdefghijklmnopqrstuvwxyz")
            let 제한사항준수 = string.rangeOfCharacter(from: 입력제한사항.inverted) == nil
            let 글자수제한 = (textField.text?.count ?? 0) + string.count
            return 제한사항준수 && (글자수제한 <= 16)
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == 현재_비밀번호_텍스트필드 {
            새_비밀번호_텍스트필드.becomeFirstResponder()
        } else if textField == 새_비밀번호_텍스트필드 {
            새_비밀번호_확인_텍스트필드.becomeFirstResponder()
        } else if textField == 새_비밀번호_확인_텍스트필드 {
            새_비밀번호_확인_텍스트필드.resignFirstResponder()
        }
        return true
    }
    
}
extension 비밀번호변경_화면: UITextFieldDelegate {
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        활성화된텍스트필드 = textField
        if textField == 현재_비밀번호_텍스트필드 {
            현재_비밀번호_백.layer.borderColor = UIColor(named: "neon")?.cgColor
            현재_비밀번호_백.layer.borderWidth = 1
        }
        else if textField == 새_비밀번호_텍스트필드 {
            새_비밀번호_백.layer.borderColor = UIColor(named: "neon")?.cgColor
            새_비밀번호_백.layer.borderWidth = 1
        }
        else if textField == 새_비밀번호_확인_텍스트필드 {
            새_비밀번호_확인_백.layer.borderColor = UIColor(named: "neon")?.cgColor
            새_비밀번호_확인_백.layer.borderWidth = 1
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        활성화된텍스트필드 = nil
        if textField == 현재_비밀번호_텍스트필드 {
            현재_비밀번호_백.layer.borderColor = UIColor.clear.cgColor
        }
        else if textField == 새_비밀번호_텍스트필드 {
            새_비밀번호_백.layer.borderColor = UIColor.clear.cgColor
        }
        else if textField == 새_비밀번호_확인_텍스트필드 {
            새_비밀번호_확인_백.layer.borderColor = UIColor.clear.cgColor
        }
    }
}

extension 비밀번호변경_화면 {
    
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


