import UIKit

class 비밀번호변경_화면 : UIViewController {
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
        textField.attributedPlaceholder = NSAttributedString(string: "이메일", attributes: attributes)
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
        
        UI레이아웃()
        버튼_클릭()
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
