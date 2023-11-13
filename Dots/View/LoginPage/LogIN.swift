import UIKit
import FirebaseAuth
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
    private let 이메일_백 = {
        let uiView = UIView()
        uiView.backgroundColor = .darkGray
        uiView.layer.cornerRadius = 25
        return uiView
    }()
    private let 비밀번호_백 = {
        let uiView = UIView()
        uiView.backgroundColor = .darkGray
        uiView.layer.cornerRadius = 25
        return uiView
    }()
    private let 간편로그인_라벨 = {
        let label = UILabel()
        label.text = "간편 로그인"
        label.textColor = UIColor.darkGray
        label.font = UIFont.boldSystemFont(ofSize: 14)
        
        return label
    } ()
    private let 왼쪽구분선: UIView = {
        let view = UIView()
        
        let 점선 = CAShapeLayer()
        점선.strokeColor = UIColor.darkGray.cgColor
        점선.lineDashPattern = [10, 2] // 점선의 길이 및 간격을 설정합니다.
        
        let 경로 = CGMutablePath()
        경로.addLines(between: [CGPoint(x: 0, y: 0), CGPoint(x: 110, y: 0)]) // 좌표값 변경

        점선.path = 경로
        점선.lineWidth = 1
        
        view.layer.addSublayer(점선)
        
        return view
    }()
    private let 오른쪽구분선: UIView = {
        let view = UIView()
        
        let 점선 = CAShapeLayer()
        점선.strokeColor = UIColor.darkGray.cgColor
        점선.lineDashPattern = [10, 2] // 점선의 길이 및 간격을 설정합니다.
        
        let 경로 = CGMutablePath()
        경로.addLines(between: [CGPoint(x: 0, y: 0), CGPoint(x: 110, y: 0)]) // 좌표값 변경

        점선.path = 경로
        점선.lineWidth = 1
        
        view.layer.addSublayer(점선)
        
        return view
    }()
    let 구글_버튼 = {
        let button = UIButton()
        button.setImage(UIImage(named: "google"), for: .selected)
        button.setImage(UIImage(named: "google"), for: .normal)
        button.isSelected = !button.isSelected
        button.backgroundColor = UIColor(named: "neon")
        button.layer.cornerRadius = 30
        button.contentMode = .scaleToFill
        return button
    } ()
    let 애플_버튼 = {
        let button = UIButton()
        button.setImage(UIImage(named: "apple"), for: .selected)
        button.setImage(UIImage(named: "apple"), for: .normal)
        button.isSelected = !button.isSelected
        button.backgroundColor = UIColor(named: "neon")
        button.layer.cornerRadius = 30
        button.contentMode = .scaleToFill

        return button
    } ()
    let 트위터_버튼 = {
        let button = UIButton()
        button.setImage(UIImage(named: "twitter"), for: .selected)
        button.setImage(UIImage(named: "twitter"), for: .normal)
        button.isSelected = !button.isSelected
        button.backgroundColor = UIColor(named: "neon")
        button.layer.cornerRadius = 30
        button.contentMode = .scaleToFill

        return button
    } ()

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
        view.addSubview(이메일_백)
        view.addSubview(비밀번호_백)
        view.addSubview(로그인_이메일_텍스트필드)
        view.addSubview(로그인_비밀번호_텍스트필드)
        view.addSubview(로그인_버튼)
        view.addSubview(간편로그인_라벨)
        view.addSubview(왼쪽구분선)
        view.addSubview(오른쪽구분선)
        view.addSubview(구글_버튼)
        view.addSubview(애플_버튼)
        view.addSubview(트위터_버튼)
        
        뒤로가기_버튼.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(75)
            make.leading.equalToSuperview().offset(24)
            make.size.equalTo(40)
        }
        
        제목_라벨.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(264)
            make.leading.equalToSuperview().offset(32)
            
        }
        이메일_백.snp.makeConstraints { make in
            make.top.equalTo(제목_라벨.snp.bottom).offset(73)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(58)
        }
        로그인_이메일_텍스트필드.snp.makeConstraints { make in
            make.height.equalTo(58)
            make.top.equalTo(이메일_백)
            make.leading.equalTo(이메일_백).offset(30)
            make.trailing.equalTo(이메일_백).offset(-80)
        }
        비밀번호_백.snp.makeConstraints { make in
            make.top.equalTo(로그인_이메일_텍스트필드.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(58)
        }
        로그인_비밀번호_텍스트필드.snp.makeConstraints { make in
            make.height.equalTo(58)
            make.top.equalTo(비밀번호_백)
            make.leading.equalTo(비밀번호_백).offset(30)
            make.trailing.equalTo(비밀번호_백).offset(-80)
        }
        로그인_버튼.snp.makeConstraints { make in
            make.top.equalTo(로그인_비밀번호_텍스트필드.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(64)
        }
        간편로그인_라벨.snp.makeConstraints { make in
            make.top.equalTo(로그인_버튼.snp.bottom).offset(46)
            make.centerX.equalToSuperview()
        }
        왼쪽구분선.snp.makeConstraints { make in
            make.top.equalTo(간편로그인_라벨.snp.centerY)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalTo(간편로그인_라벨.snp.leading ).offset(-10)
            make.height.equalTo(1)
        }
        오른쪽구분선.snp.makeConstraints { make in
            make.top.equalTo(간편로그인_라벨.snp.centerY)
            make.trailing.equalToSuperview().offset(-24)
            make.leading.equalTo(간편로그인_라벨.snp.trailing).offset(10)
            make.height.equalTo(1)
        }
        구글_버튼.snp.makeConstraints { make in
            make.centerY.equalTo(애플_버튼)
            make.trailing.equalTo(애플_버튼.snp.leading).offset(-20)
            make.size.equalTo(60)
        }
        애플_버튼.snp.makeConstraints { make in
            make.top.equalTo(간편로그인_라벨).offset(30)
            make.centerX.equalToSuperview()
            make.size.equalTo(60)
        }
        트위터_버튼.snp.makeConstraints { make in
            make.centerY.equalTo(애플_버튼)
            make.leading.equalTo(애플_버튼.snp.trailing).offset(20)
            make.size.equalTo(60)
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
        let 처음화면_이동 = 로그인_회원가입_뷰컨트롤러()
        self.navigationController?.pushViewController(처음화면_이동, animated: true)
        navigationItem.hidesBackButton = true
    }
    @objc func 로그인_버튼_클릭() {
        print("메인 전시 페이지로 이동")
        guard let 이메일 = 로그인_이메일_텍스트필드.text, let 비밀번호 = 로그인_비밀번호_텍스트필드.text else {
            return
        }
        
        Auth.auth().signIn(withEmail: 이메일, password: 비밀번호) { [weak self] authResult, 에러 in
            guard let self = self else { return }
            
            if let 로그인_실패 = 에러 {
                print("로그인 실패: \(로그인_실패.localizedDescription)")
            } else {
                print("로그인 성공")
                
                let 메인화면_이동 = GlassTabBar()
                self.navigationController?.pushViewController(메인화면_이동, animated: true)
                self.navigationItem.hidesBackButton = true
            }
        }
    }
    
}
