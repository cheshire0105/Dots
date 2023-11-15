import UIKit


class 마이페이지_알림 : UIViewController {
        private let 뒤로가기_버튼 = {
            let button = UIButton()
            button.setImage(UIImage(named: "backButton"), for: .normal)
            button.isSelected = !button.isSelected
            return button
        } ()
    override func viewWillAppear(_ animated: Bool) {
        if let glassTabBar = tabBarController as? GlassTabBar {
            glassTabBar.customTabBarView.isHidden = true
        }
    }
    override func viewDidLoad() {
        view.backgroundColor = .orange
        navigationItem.hidesBackButton = true
        navigationController?.isNavigationBarHidden = true
        UI레이아웃()
        버튼_클릭()
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

