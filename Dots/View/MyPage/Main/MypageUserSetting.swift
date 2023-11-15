import UIKit
import FirebaseAuth
import SnapKit
//asdfasf
class 마이페이지_설정_페이지 : UIViewController {
    let 페이지_제목 = {
        let label = UILabel()
        label.text = "설정"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    let 뒤로가기_버튼 = {
        let button = UIButton()
        button.setImage(UIImage(named: "loginBack"), for: .selected)
        button.setImage(UIImage(named: ""), for: .normal)
        button.isSelected = !button.isSelected
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        return button
    } ()
    let 프로필공개여부_라벨 = {
        let label = UILabel()
     
        return label
    } ()
    let 프로필공개여부_토글 = {
        let toggle = UISwitch()
        return toggle
    } ()
    
    let 프로필변경_버튼 = {
        let button = UIButton()
        button.setTitle("로그아웃", for: .normal)
        button.setTitle("로그아웃", for: .selected)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor.white, for: .selected)
        button.backgroundColor = UIColor.darkGray
        button.titleLabel?.textAlignment = .left
        return button
    } ()
    let 프로필변경_화살표 = {
        let imageView = UIImageView()
        return imageView
    }()
    let 비밀번호변경_버튼 = {
        let button = UIButton()
        button.setTitle("로그아웃", for: .normal)
        button.setTitle("로그아웃", for: .selected)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor.white, for: .selected)
        button.backgroundColor = UIColor.darkGray
        button.titleLabel?.textAlignment = .left
        return button
    } ()
    let 비밀번호변경_화살표 = {
        let imageView = UIImageView()
        return imageView
    }()
    let 알림설정_버튼 = {
        let button = UIButton()
        button.setTitle("로그아웃", for: .normal)
        button.setTitle("로그아웃", for: .selected)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor.white, for: .selected)
        button.backgroundColor = UIColor.darkGray
        button.titleLabel?.textAlignment = .left
        return button
    } ()
    let 알림설정_화살표 = {
        let imageView = UIImageView()
        return imageView
    }()
    let 서비스설정_버튼 = {
        let button = UIButton()
        button.setTitle("로그아웃", for: .normal)
        button.setTitle("로그아웃", for: .selected)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor.white, for: .selected)
        button.backgroundColor = UIColor.darkGray
        button.titleLabel?.textAlignment = .left
        return button
    } ()
    let 서비스설정_화살표 = {
        let imageView = UIImageView()
        return imageView
    }()
    let 로그아웃_버튼 = {
        let button = UIButton()
        button.setTitle("로그아웃", for: .normal)
        button.setTitle("로그아웃", for: .selected)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor.white, for: .selected)
        button.backgroundColor = UIColor.darkGray
        button.titleLabel?.textAlignment = .left
        return button
    } ()
 
    let 회원탈퇴_버튼 = {
        let button = UIButton()
        button.setTitle("회원탈퇴", for: .normal)
        button.setTitle("회원탈퇴", for: .selected)
        button.setTitleColor(UIColor.red, for: .normal)
        button.setTitleColor(UIColor.red, for: .selected)
        button.backgroundColor = UIColor.darkGray
        button.titleLabel?.textAlignment = .left
        return button
    } ()
    
    override func viewWillAppear(_ animated: Bool) {
        if let glassTabBar = tabBarController as? GlassTabBar {
            glassTabBar.customTabBarView.isHidden = true
        }
    }
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
        view.addSubview(프로필공개여부_라벨)
        view.addSubview(프로필공개여부_토글)
        view.addSubview(프로필변경_버튼)
        view.addSubview(프로필변경_화살표)
        view.addSubview(비밀번호변경_버튼)
        view.addSubview(비밀번호변경_화살표)
        view.addSubview(알림설정_버튼)
        view.addSubview(알림설정_화살표)
        view.addSubview(서비스설정_버튼)
        view.addSubview(서비스설정_화살표)
        view.addSubview(로그아웃_버튼)
        view.addSubview(회원탈퇴_버튼)
        뒤로가기_버튼.snp.makeConstraints { make in
            make.centerY.equalTo(페이지_제목.snp.centerY)
            make.leading.equalToSuperview().offset(16)
            make.size.equalTo(40)
        }
        페이지_제목.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.centerX.equalToSuperview()
        }
        
        
        로그아웃_버튼.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
        }
    }
    
    private func 버튼_클릭() {
        뒤로가기_버튼.addTarget(self, action: #selector(뒤로가기_버튼_클릭), for: .touchUpInside)
    }
    @objc func 뒤로가기_버튼_클릭() {
        navigationController?.popViewController(animated: true)
    }
    @objc private func 로그아웃_버튼_클릭() {
        do {
            if let 현제접속중인_유저 = Auth.auth().currentUser {
                print("로그아웃한 사용자 정보:")
                print("UID: \(현제접속중인_유저.uid)")
                print("이메일: \(현제접속중인_유저.email ?? "없음")")
            }
            try Auth.auth().signOut()
            print("계정이 로그아웃되었습니다.")
            let 로그인_뷰컨트롤러 = 로그인_뷰컨트롤러()
            let 로그인화면_이동 = UINavigationController(rootViewController: 로그인_뷰컨트롤러)
            로그인화면_이동.modalPresentationStyle = .fullScreen
            present(로그인화면_이동, animated: true, completion: nil)
        } catch {
            print("로그아웃 실패: \(error.localizedDescription)")
        }
    }
}
