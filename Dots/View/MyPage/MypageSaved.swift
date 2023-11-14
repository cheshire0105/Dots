import UIKit

class 마이페이지_보관함 : UIViewController {
    let 뒤로가기_버튼 = {
        let button = UIButton()
        button.setImage(UIImage(named: "loginBack"), for: .selected)
        button.setImage(UIImage(named: ""), for: .normal)
        button.isSelected = !button.isSelected
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        return button
    } ()
    let 페이지_제목 = {
        let label = UILabel()
        label.text = "보관함"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()

override func viewDidLoad() {
    view.backgroundColor = .black
    navigationItem.hidesBackButton = true
    navigationController?.isNavigationBarHidden = true
    UI레이아웃()
    버튼_클릭()
}

func UI레이아웃() {
    view.addSubview(뒤로가기_버튼)
    view.addSubview(페이지_제목)
    뒤로가기_버튼.snp.makeConstraints { make in
        make.centerY.equalTo(페이지_제목.snp.centerY)
        make.leading.equalToSuperview().offset(16)
        make.size.equalTo(40)
    }
    페이지_제목.snp.makeConstraints { make in
        make.top.equalToSuperview().offset(60)
        make.centerX.equalToSuperview()
    }
}

    private func 버튼_클릭() {
        뒤로가기_버튼.addTarget(self, action: #selector(뒤로가기_버튼_클릭), for: .touchUpInside)

    }
    @objc func 뒤로가기_버튼_클릭() {
        navigationController?.popViewController(animated: true)
    }
}
