import UIKit
import SnapKit

class 회원가입_세번째_뷰컨트롤러 : UIViewController {
    

    let 뒤로가기_버튼 = {
        let button = UIButton()
        button.setImage(UIImage(named: "loginBack"), for: .selected)
        button.setImage(UIImage(named: ""), for: .normal)
        button.isSelected = !button.isSelected
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        return button
    } ()
    private let 건너뛰기_버튼 = {
        let button = UIButton()
        button.isSelected = !button.isSelected
        button.setTitle("건너뛰기", for: .normal)
        button.setTitle("건너뛰기", for: .selected)
        button.setTitleColor(UIColor(named: "neon"), for: .selected)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.titleLabel?.textAlignment = .center
        return button
    }()
    private let 제목_라벨 = {
        let label = UILabel()
        label.text = "좋아하는 작가를 선택해주세요"
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 24)
        
        return label
    } ()
    private let 검색_백 = {
        let uiView = UIView()
        uiView.backgroundColor = .darkGray
        uiView.layer.cornerRadius = 25
        return uiView
    }()
    private let 검색_텍스트필드 = { ()
        let textField = UITextField()
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.lightGray,
            .font: UIFont.boldSystemFont(ofSize: 14)
        ]
        textField.attributedPlaceholder = NSAttributedString(string: "직접입력...", attributes: attributes)
        textField.textColor = UIColor.white
        textField.tintColor = UIColor.lightGray
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 25
        textField.backgroundColor = .darkGray
        textField.textAlignment = .left
        textField.font = UIFont.boldSystemFont(ofSize: 14)
        return textField
    } ()
    private let 다음_버튼 = {
        let button = UIButton()
        button.layer.cornerRadius = 30
        button.backgroundColor = UIColor.white
        button.isSelected = !button.isSelected
        button.setTitle("다음", for: .normal)
        button.setTitle("다음", for: .selected)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor.black, for: .selected)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    
    
    
    override func viewDidLoad() {
        view.backgroundColor = .black
        UI레이아웃 ()
        버튼_클릭()
    }
}

extension 회원가입_세번째_뷰컨트롤러 {
    
    func UI레이아웃 () {
        view.addSubview(뒤로가기_버튼)
        view.addSubview(건너뛰기_버튼)
        view.addSubview(제목_라벨)
        view.addSubview(검색_백)
        view.addSubview(검색_텍스트필드)
        view.addSubview(다음_버튼)

        뒤로가기_버튼.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(75)
            make.leading.equalToSuperview().offset(24)
            make.size.equalTo(40)
        }
        건너뛰기_버튼.snp.makeConstraints { make in
            make.centerY.equalTo(뒤로가기_버튼.snp.centerY)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(30)
        }
        제목_라벨.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(149)
            make.leading.equalToSuperview().offset(24)
        }
        검색_백.snp.makeConstraints { make in
            make.top.equalTo(제목_라벨.snp.bottom).offset(47)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(56)
            
            
        }
        검색_텍스트필드.snp.makeConstraints { make in
            make.top.equalTo(검색_백)
            make.leading.equalTo(검색_백.snp.leading).offset(30)
            make.trailing.equalTo(검색_백.snp.trailing).offset(-80)
            make.height.equalTo(56)
        
        }
        다음_버튼.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-30)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(64)
        }
        
    }
}


extension 회원가입_세번째_뷰컨트롤러 {
    
    private func 버튼_클릭() {
        뒤로가기_버튼.addTarget(self, action: #selector(뒤로가기_버튼_클릭), for: .touchUpInside)
        건너뛰기_버튼.addTarget(self, action: #selector(건너뛰기_버튼_클릭), for: .touchUpInside)
        다음_버튼.addTarget(self, action: #selector(다음_버튼_클릭), for: .touchUpInside)
    }
    
    
    @objc func 뒤로가기_버튼_클릭() {
        print("뒤로가기")
        navigationController?.popViewController(animated: true)
    }
    @objc func 건너뛰기_버튼_클릭() {
        print("건 너 뛰 기")
        let 다음화면_이동 = 회원가입_네번째_뷰컨트롤러()
        self.navigationController?.pushViewController(다음화면_이동, animated: true)
        navigationItem.hidesBackButton = true
    }
    
    @objc func 다음_버튼_클릭() {
        print("다음 페이지로 이동")
        let 다음화면_이동 = 회원가입_네번째_뷰컨트롤러()
        self.navigationController?.pushViewController(다음화면_이동, animated: true)
        navigationItem.hidesBackButton = true
    }
}
