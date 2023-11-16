import UIKit
import FirebaseAuth
import SnapKit
//asdfasf
class 마이페이지_설정_페이지 : UIViewController {
    private let 페이지_제목 = {
        let label = UILabel()
        label.text = "설정"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    private let 뒤로가기_버튼 = {
        let button = UIButton()
        button.setImage(UIImage(named: "loginBack"), for: .selected)
        button.setImage(UIImage(named: ""), for: .normal)
        button.isSelected = !button.isSelected
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        return button
    } ()
    private let 프로필공개여부_버튼 = {
            let button = UIButton()
        button.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
            button.titleLabel?.textAlignment = .left
        button.layer.cornerRadius = 15
            return button
        } ()
    private let 프로필공개여부_토글 = {
        let toggle = UISwitch()
        return toggle
    } ()
    private let 프로필공개여부_라벨 = {
        let label = UILabel()
        label.text = "프로필 공개 / 비공개"
        label.textColor = UIColor.white
        label.font = UIFont(name: "HelveticaNeue", size: 17)
        label.textAlignment = .left
        return label
    }()
    
    private let 프로필변경_버튼 = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
        button.titleLabel?.textAlignment = .left
        button.layer.cornerRadius = 15
        button.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

        return button
    } ()
    private let 프로필변경_라벨 = {
        let label = UILabel()
        label.text = "프로필 변경"
        label.textColor = UIColor.white
        label.font = UIFont(name: "HelveticaNeue", size: 17)
        label.textAlignment = .left
        return label
    }()
    private let 프로필변경_화살표 = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "버튼화살표")
        return imageView
    }()
    private let 비밀번호변경_버튼 = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
        button.titleLabel?.textAlignment = .left
        return button
    } ()
    private let 비밀번호변경_라벨 = {
        let label = UILabel()
        label.text = "비밀번호 변경"
        label.textColor = UIColor.white
        label.font = UIFont(name: "HelveticaNeue", size: 17)
        label.textAlignment = .left
        return label
    }()
    private let 비밀번호변경_화살표 = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "버튼화살표")

        return imageView
    }()
    private let 알림설정_버튼 = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
        button.titleLabel?.textAlignment = .left
        return button
    } ()
    private let 알림설정_라벨 = {
        let label = UILabel()
        label.text = "알림 설정"
        label.textColor = UIColor.white
        label.font = UIFont(name: "HelveticaNeue", size: 17)
        label.textAlignment = .left
        return label
    }()
    private let 알림설정_화살표 = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "버튼화살표")

        return imageView
    }()
    private let 서비스설정_버튼 = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
        button.titleLabel?.textAlignment = .left
        button.layer.cornerRadius = 15
        button.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return button
    } ()
    private let 서비스설정_라벨 = {
        let label = UILabel()
        label.text = "서비스 설정"
        label.textColor = UIColor.white
        label.font = UIFont(name: "HelveticaNeue", size: 17)
        label.textAlignment = .left
        return label
    }()
    private let 서비스설정_화살표 = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "버튼화살표")

        return imageView
    }()
    private let 로그아웃_버튼 = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
        button.titleLabel?.textAlignment = .left
        button.layer.cornerRadius = 15
        return button
    } ()
    private let 로그아웃_라벨 = {
        let label = UILabel()
        label.text = "로그아웃"
        label.textColor = UIColor.white
        label.font = UIFont(name: "HelveticaNeue", size: 17)
        label.textAlignment = .left
        return label
    }()
 
    private let 회원탈퇴_버튼 = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
        button.titleLabel?.textAlignment = .left
        button.layer.cornerRadius = 15
        return button
    } ()
    private let 회원탈퇴_라벨 = {
        let label = UILabel()
        label.text = "회원탈퇴"
        label.textColor = UIColor.systemRed
        label.font = UIFont(name: "HelveticaNeue", size: 17)
        label.textAlignment = .left
        return label
    }()
    
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
        화살표_레이아웃()
    }
   

    private func UI레이아웃() {
        view.addSubview(뒤로가기_버튼)
        view.addSubview(페이지_제목)
        view.addSubview(프로필공개여부_버튼)
        view.addSubview(프로필공개여부_라벨)
        view.addSubview(프로필공개여부_토글)
        view.addSubview(프로필변경_버튼)
        view.addSubview(비밀번호변경_버튼)
        view.addSubview(알림설정_버튼)
        view.addSubview(서비스설정_버튼)
        view.addSubview(로그아웃_버튼)
        view.addSubview(회원탈퇴_버튼)
        view.addSubview(프로필변경_라벨)
        view.addSubview(비밀번호변경_라벨)
        view.addSubview(알림설정_라벨)
        view.addSubview(서비스설정_라벨)
        view.addSubview(로그아웃_라벨)
        view.addSubview(회원탈퇴_라벨)
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
        프로필공개여부_버튼.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(145)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.height.equalTo(44)

        }
        프로필공개여부_라벨.snp.makeConstraints { make in
            make.centerY.equalTo(프로필공개여부_버튼.snp.centerY)
            make.leading.equalTo(프로필공개여부_버튼.snp.leading).offset(16)
        }
        프로필공개여부_토글.snp.makeConstraints { make in
            make.centerY.equalTo(프로필공개여부_버튼.snp.centerY)
            make.trailing.equalTo(프로필공개여부_버튼.snp.trailing).offset(-16)
        }
        프로필변경_버튼.snp.makeConstraints { make in
            make.top.equalTo(프로필공개여부_버튼.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.height.equalTo(44)

        }
        프로필변경_라벨.snp.makeConstraints { make in
            make.centerY.equalTo(프로필변경_버튼.snp.centerY)
            make.leading.equalTo(프로필변경_버튼.snp.leading).offset(16)
        }
       
        비밀번호변경_버튼.snp.makeConstraints { make in
            make.top.equalTo(프로필변경_버튼.snp.bottom).offset(2)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.height.equalTo(44)

        }
        비밀번호변경_라벨.snp.makeConstraints { make in
            make.centerY.equalTo(비밀번호변경_버튼.snp.centerY)
            make.leading.equalTo(비밀번호변경_버튼.snp.leading).offset(16)
        }
       
        알림설정_버튼.snp.makeConstraints { make in
            make.top.equalTo(비밀번호변경_버튼.snp.bottom).offset(2)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.height.equalTo(44)

        }
        알림설정_라벨.snp.makeConstraints { make in
            make.centerY.equalTo(알림설정_버튼.snp.centerY)
            make.leading.equalTo(알림설정_버튼.snp.leading).offset(16)
        }
        
      
        서비스설정_버튼.snp.makeConstraints { make in
            make.top.equalTo(알림설정_버튼.snp.bottom).offset(2)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.height.equalTo(44)

        }
        서비스설정_라벨.snp.makeConstraints { make in
            make.centerY.equalTo(서비스설정_버튼.snp.centerY)
            make.leading.equalTo(서비스설정_버튼.snp.leading).offset(16)
        }
        
       
        로그아웃_버튼.snp.makeConstraints { make in
            make.top.equalTo(서비스설정_버튼.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.height.equalTo(44)

        }
        로그아웃_라벨.snp.makeConstraints { make in
            make.centerY.equalTo(로그아웃_버튼.snp.centerY)
            make.leading.equalTo(로그아웃_버튼.snp.leading).offset(16)
        }
        회원탈퇴_버튼.snp.makeConstraints { make in
            make.top.equalTo(로그아웃_버튼.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.height.equalTo(44)

        }
        회원탈퇴_라벨.snp.makeConstraints { make in
            make.centerY.equalTo(회원탈퇴_버튼.snp.centerY)
            make.leading.equalTo(회원탈퇴_버튼.snp.leading).offset(16)
        }
    }
    
    private func 화살표_레이아웃() {
        view.addSubview(프로필변경_화살표)
        view.addSubview(비밀번호변경_화살표)
        view.addSubview(알림설정_화살표)
        view.addSubview(서비스설정_화살표)
        
        프로필변경_화살표.snp.makeConstraints { make in
            make.centerY.equalTo(프로필변경_버튼
                .snp.centerY)
            make.trailing.equalTo(프로필변경_버튼.snp.trailing).offset(-16)
        }
        
        비밀번호변경_화살표.snp.makeConstraints { make in
            make.centerY.equalTo(비밀번호변경_버튼.snp.centerY)
            make.trailing.equalTo(비밀번호변경_버튼.snp.trailing).offset(-16)
        }
        
        알림설정_화살표.snp.makeConstraints { make in
            make.centerY.equalTo(알림설정_버튼.snp.centerY)
            make.trailing.equalTo(알림설정_버튼.snp.trailing).offset(-16)
        }
        
        
        서비스설정_화살표.snp.makeConstraints { make in
            make.centerY.equalTo(서비스설정_버튼.snp.centerY)
            make.trailing.equalTo(서비스설정_버튼.snp.trailing).offset(-16)
        }
    }
    private func 버튼_클릭() {
        뒤로가기_버튼.addTarget(self, action: #selector(뒤로가기_버튼_클릭), for: .touchUpInside)
        로그아웃_버튼.addTarget(self, action: #selector(로그아웃_버튼_클릭), for: .touchUpInside)
        회원탈퇴_버튼.addTarget(self, action: #selector(회원탈퇴_버튼_클릭), for: .touchUpInside)
    }
    @objc private func 뒤로가기_버튼_클릭() {
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
    @objc private func 회원탈퇴_버튼_클릭() {
        let 탈퇴확인_알럿 = UIAlertController(title: "회원 탈퇴", message: "탈퇴하면 모든 정보가 삭제됩니다. 이대로 회원 탈퇴를 진행할까요?", preferredStyle: .alert)

            let 탈퇴취소_버튼 = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        탈퇴확인_알럿.addAction(탈퇴취소_버튼)

            let 탈퇴확인_버튼 = UIAlertAction(title: "탈퇴", style: .destructive) { _ in
                self.회원탈퇴_데이터삭제()
            }
        탈퇴확인_알럿.addAction(탈퇴확인_버튼)

            present(탈퇴확인_알럿, animated: true, completion: nil)
    }
    private func 회원탈퇴_데이터삭제() {
        if let 현제접속중인_유저 = Auth.auth().currentUser {
            현제접속중인_유저.delete { error in
                if let error = error {
                    print("회원 탈퇴 실패: \(error.localizedDescription)")
                } else {
                    print("회원 탈퇴 성공")
                    
                }
            }
        }
    }
}
