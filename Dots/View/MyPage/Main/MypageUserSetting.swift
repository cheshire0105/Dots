import UIKit
import SnapKit
import FirebaseAuth


class 마이페이지_유저_설정_모달 : UIViewController {
    
    
    
    private let 손잡이 = {
        let button = UIButton()
        button.backgroundColor = UIColor.white
        button.layer.borderColor = UIColor(named: "neon")?.withAlphaComponent(0.8).cgColor
        button.layer.borderWidth = 3
        button.layer.cornerRadius = 5
        button.isSelected = false
        return button
    }()
    
    private let 로그아웃_버튼 = {
        let button = UIButton()
        button.setTitle("로그아웃", for: .selected)
        button.setTitle("로그아웃", for: .normal)
        button.setTitleColor(UIColor.black, for: .selected)
        button.setTitleColor(UIColor(named: "neon"), for: .normal)
        button.isSelected = !button.isSelected
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.backgroundColor = UIColor(named: "neon")
        button.layer.cornerRadius = 15
        return button
    }()
    
    override func viewDidLoad() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        gradientLayer.colors = [
            UIColor.black.withAlphaComponent(0.8).cgColor,
            UIColor.black.withAlphaComponent(0.9).cgColor
        ]
        gradientLayer.locations = [0, 1]
        view.layer.addSublayer(gradientLayer)
        view.backgroundColor = .clear
        view.layer.borderColor = UIColor(named: "neon")?.withAlphaComponent(0.6).cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 20
        
        UI레이아웃()
        버튼_클릭()
    }
    
    
    func UI레이아웃 () {
        
        view.addSubview(손잡이)
        view.addSubview(로그아웃_버튼)
        
        손잡이.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(25)
            make.centerX.equalToSuperview()
            make.width.equalTo(60)
            make.height.equalTo(10)
        }
        로그아웃_버튼.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(80)
        }
    }
}

extension 마이페이지_유저_설정_모달 {
    
    private func 버튼_클릭() {
        로그아웃_버튼.addTarget(self, action: #selector(로그아웃_버튼_클릭), for: .touchUpInside)
    }
    
    @objc private func 로그아웃_버튼_클릭() {
        do {
            if let currentUser = Auth.auth().currentUser {
                print("로그아웃한 사용자 정보:")
                print("UID: \(currentUser.uid)")
                print("이메일: \(currentUser.email ?? "없음")")
            }
            
            try Auth.auth().signOut()
            print("로그아웃 성공")
            let 로그인_뷰컨트롤러 = 로그인_뷰컨트롤러()
            let navigationController = UINavigationController(rootViewController: 로그인_뷰컨트롤러)
            navigationController.modalPresentationStyle = .fullScreen
            present(navigationController, animated: true, completion: nil)
        } catch {
            print("로그아웃 실패: \(error.localizedDescription)")
        }
    }
}
