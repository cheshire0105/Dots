import UIKit
import SnapKit

class 로그인_뷰컨트롤러 : UIViewController {
    //페이지 제목
    private let 제목_라벨 = {
        let label = UILabel()
        label.text = "LOG IN"
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 40)
        
        return label
    } ()
    let 뒤로가기_버튼 = {
       let button = UIButton()
       button.setImage(UIImage(named: "loginBack"), for: .selected)
       button.setImage(UIImage(named: ""), for: .normal)
       button.isSelected = !button.isSelected
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
       return button
   } ()
    //이메일 텍스트필드
    private let 로그인_이메일_텍스트필드 = { ()
        let textField = UITextField()
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.lightGray,
            .font: UIFont.boldSystemFont(ofSize: 14)
        ]
        textField.attributedPlaceholder = NSAttributedString(string: "이메일", attributes: attributes)
        textField.textColor = UIColor.white
        textField.tintColor = UIColor.lightGray
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 25
        textField.backgroundColor = .darkGray
        textField.textAlignment = .left
        textField.font = UIFont.boldSystemFont(ofSize: 14)
        return textField
    } ()
    //비밀번호 텍스트필드
    private let 로그인_비밀번호_텍스트필드 = { ()
        let textField = UITextField()
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.lightGray,
            .font: UIFont.boldSystemFont(ofSize: 14)
        ]
        textField.attributedPlaceholder = NSAttributedString(string: "비밀번호", attributes: attributes)
        textField.textColor = UIColor.white
        textField.tintColor = UIColor.lightGray
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 25
        textField.backgroundColor = .darkGray
        textField.textAlignment = .left
        textField.font = UIFont.boldSystemFont(ofSize: 14)
        return textField
    } ()
    //로그인 버튼
    private let 로그인_버튼 = {
        let button = UIButton()
        button.layer.cornerRadius = 30
        button.backgroundColor = UIColor(named: "neon")
        button.isSelected = !button.isSelected
        button.setTitle("로그인", for: .normal)
        button.setTitle("로그인", for: .selected)
        button.setTitleColor(UIColor(named: "neon"), for: .normal)
        button.setTitleColor(UIColor.black, for: .selected)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .black
        navigationItem.hidesBackButton = true
        navigationController?.isNavigationBarHidden = true 
        UI레이아웃()
        버튼_클릭()
    }
    
}

//레이아웃
extension 로그인_뷰컨트롤러 {
    func UI레이아웃() {
        view.addSubview(뒤로가기_버튼)
        view.addSubview(제목_라벨)
        view.addSubview(로그인_이메일_텍스트필드)
        view.addSubview(로그인_비밀번호_텍스트필드)
        view.addSubview(로그인_버튼)
        
        뒤로가기_버튼.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(75)
            make.leading.equalToSuperview().offset(24)
            make.size.equalTo(40)
        }
        
        제목_라벨.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(275)
            make.leading.equalToSuperview().offset(32)
            
            
        }
        로그인_이메일_텍스트필드.snp.makeConstraints { make in
            make.top.equalTo(제목_라벨.snp.bottom).offset(114)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(58)
        }
        로그인_비밀번호_텍스트필드.snp.makeConstraints { make in
            make.top.equalTo(로그인_이메일_텍스트필드.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(58)
        }
        로그인_버튼.snp.makeConstraints { make in
            make.top.equalTo(로그인_비밀번호_텍스트필드.snp.bottom).offset(53)
            make.leading.equalToSuperview().offset(102)
            make.trailing.equalToSuperview().offset(-103)
            make.height.equalTo(64)

        }
    }
}
//버튼클릭
extension 로그인_뷰컨트롤러 {
    
    private func 버튼_클릭() {
        뒤로가기_버튼.addTarget(self, action: #selector(뒤로가기_버튼_클릭), for: .touchUpInside)
        로그인_버튼.addTarget(self, action: #selector(로그인_버튼_클릭), for: .touchUpInside)
    }
    @objc func 뒤로가기_버튼_클릭() {
        print("뒤로가기")
        navigationController?.popViewController(animated: true)

    }
    @objc func 로그인_버튼_클릭() {
        print("메인 전시 페이지로 이동")
        let 메인화면_이동 = GlassTabBar()
        self.navigationController?.pushViewController(메인화면_이동, animated: true)
        navigationItem.hidesBackButton = true
        
 
    }
}
