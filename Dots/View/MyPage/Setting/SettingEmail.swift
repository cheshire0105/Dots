import UIKit

class 이메일변경_화면 : UIViewController {
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
        label.text = "이메일 변경"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    private let 현재_이메일_텍스트필드 = { ()
        let textField = UITextField()
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.lightGray,
            .font: UIFont.boldSystemFont(ofSize: 14)
        ]
        textField.attributedPlaceholder = NSAttributedString(string: "이메일", attributes: attributes)
        textField.textColor = UIColor.white
        textField.tintColor = UIColor(named: "neon")
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 25
        //        textField.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
        textField.backgroundColor = UIColor.clear
        textField.textAlignment = .left
        textField.font = UIFont.boldSystemFont(ofSize: 14)
        
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        
        textField.clearButtonMode = .whileEditing
        textField.rightViewMode = .whileEditing
        return textField
    } ()
    
    private let 새_이메일_텍스트필드 = { ()
        let textField = UITextField()
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.lightGray,
            .font: UIFont.boldSystemFont(ofSize: 14)
        ]
        textField.attributedPlaceholder = NSAttributedString(string: "이메일", attributes: attributes)
        textField.textColor = UIColor.white
        textField.tintColor = UIColor(named: "neon")
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 25
        //        textField.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
        textField.backgroundColor = UIColor.clear
        textField.textAlignment = .left
        textField.font = UIFont.boldSystemFont(ofSize: 14)
        
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        
        textField.clearButtonMode = .whileEditing
        textField.rightViewMode = .whileEditing
        
        return textField
    } ()
    
    override func viewDidLoad() {
        view.backgroundColor = .black
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 0.3
        
        UI레이아웃()
        버튼_클릭()
    }
}


extension 이메일변경_화면{
    
    private func UI레이아웃 () {
        view.addSubview(뒤로가기_버튼)
        view.addSubview(페이지_제목)
        view.addSubview(현재_이메일_텍스트필드)
        view.addSubview(새_이메일_텍스트필드)
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
        현재_이메일_텍스트필드.snp.makeConstraints { make in
            make.top.equalTo(페이지_제목.snp.bottom).offset(86)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(44)
        }
        
        새_이메일_텍스트필드.snp.makeConstraints { make in
            make.top.equalTo(현재_이메일_텍스트필드.snp.bottom).offset(85)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(44)
        }
    }
}


extension 이메일변경_화면 {
    
    private func 버튼_클릭() {
        뒤로가기_버튼.addTarget(self, action: #selector(뒤로가기_버튼_클릭), for: .touchUpInside)
    }
    @objc private func 뒤로가기_버튼_클릭() {
        navigationController?.popViewController(animated: true)
    }
}
