import UIKit


class 마이페이지_알림 : UIViewController {
        private let 뒤로가기_버튼 = {
            let button = UIButton()
            button.setImage(UIImage(named: "backButton"), for: .normal)
            button.isSelected = !button.isSelected
            return button
        } ()
//    override func viewWillAppear(_ animated: Bool) {
//        if let glassTabBar = tabBarController as? GlassTabBar {
//            glassTabBar.customTabBarView.isHidden = true
//        }
//    }
    override func viewDidLoad() {
        view.backgroundColor = .orange
        navigationItem.hidesBackButton = true
        navigationController?.isNavigationBarHidden = true
        UI레이아웃()
        버튼_클릭()
        화면_제스쳐_실행()
    }
    
    func UI레이아웃() {
        view.addSubview(뒤로가기_버튼)
        뒤로가기_버튼.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(58)
            make.leading.equalToSuperview().offset(16)
        }
    }
    
        private func 버튼_클릭() {
            뒤로가기_버튼.addTarget(self, action: #selector(뒤로가기_버튼_클릭), for: .touchUpInside)
    
        }
        @objc func 뒤로가기_버튼_클릭() {
            navigationController?.popViewController(animated: true)
        }
}



extension 마이페이지_알림 {
    
    func 화면_제스쳐_실행 () {
        let 화면_제스쳐 = UISwipeGestureRecognizer(target: self, action: #selector(화면_제스쳐_뒤로_가기))
        화면_제스쳐.direction = .right
        view.addGestureRecognizer(화면_제스쳐)
    }
    @objc private func 화면_제스쳐_뒤로_가기() {
        navigationController?.popViewController(animated: true)
    }
    
}

