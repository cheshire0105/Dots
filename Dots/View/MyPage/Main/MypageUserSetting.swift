import UIKit
import GoogleSignIn
import FirebaseAuth
import FirebaseFirestore
import SnapKit
//class 마이페이지_설정_페이지 : UIViewController {
//    private let 페이지_제목 = {
//        let label = UILabel()
//        label.text = "설정"
//        label.textColor = .white
//        label.font = UIFont.boldSystemFont(ofSize: 20)
//        label.textAlignment = .center
//        return label
//    }()
//    private let 뒤로가기_버튼 = {
//        let button = UIButton()
//        button.setImage(UIImage(named: "loginBack"), for: .selected)
//        button.isSelected = !button.isSelected
//        button.backgroundColor = .white
//        button.layer.cornerRadius = 20
//        return button
//    } ()
//    private let 프로필공개여부_버튼 = {
//        let button = UIButton()
//        button.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
//        button.titleLabel?.textAlignment = .left
//        button.layer.cornerRadius = 15
//        return button
//    } ()
//    private let 프로필공개여부_토글 = {
//        let toggle = UISwitch()
//        return toggle
//    } ()
//    private let 프로필공개여부_라벨 = {
//        let label = UILabel()
//        label.text = "프로필 공개 / 비공개"
//        label.textColor = UIColor.white
//        label.font = UIFont(name: "HelveticaNeue", size: 17)
//        label.textAlignment = .left
//        return label
//    }()
//
//    private let 프로필변경_버튼 = {
//        let button = UIButton()
//        button.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
//        button.titleLabel?.textAlignment = .left
//        button.layer.cornerRadius = 15
//        button.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
//
//        return button
//    } ()
//    private let 프로필변경_라벨 = {
//        let label = UILabel()
//        label.text = "프로필 변경"
//        label.textColor = UIColor.white
//        label.font = UIFont(name: "HelveticaNeue", size: 17)
//        label.textAlignment = .left
//        return label
//    }()
//    private let 프로필변경_화살표 = {
//        let imageView = UIImageView()
//        imageView.image = UIImage(named: "버튼화살표")
//        return imageView
//    }()
//    private let 이메일변경_버튼 = {
//        let button = UIButton()
//        button.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
//        button.titleLabel?.textAlignment = .left
//        return button
//    } ()
//    private let 이메일변경_라벨 = {
//        let label = UILabel()
//        label.text = "이메일 변경"
//        label.textColor = UIColor.white
//        label.font = UIFont(name: "HelveticaNeue", size: 17)
//        label.textAlignment = .left
//        return label
//    }()
//    private let 이메일변경_화살표 = {
//        let imageView = UIImageView()
//        imageView.image = UIImage(named: "버튼화살표")
//
//        return imageView
//    }()
//    private let 비밀번호변경_버튼 = {
//        let button = UIButton()
//        button.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
//        button.titleLabel?.textAlignment = .left
//        return button
//    } ()
//    private let 비밀번호변경_라벨 = {
//        let label = UILabel()
//        label.text = "비밀번호 변경"
//        label.textColor = UIColor.white
//        label.font = UIFont(name: "HelveticaNeue", size: 17)
//        label.textAlignment = .left
//        return label
//    }()
//    private let 비밀번호변경_화살표 = {
//        let imageView = UIImageView()
//        imageView.image = UIImage(named: "버튼화살표")
//
//        return imageView
//    }()
//    private let 알림설정_버튼 = {
//        let button = UIButton()
//        button.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
//        button.titleLabel?.textAlignment = .left
//        button.layer.cornerRadius = 15
//        button.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
//        return button
//    } ()
//    private let 알림설정_라벨 = {
//        let label = UILabel()
//        label.text = "알림 설정"
//        label.textColor = UIColor.white
//        label.font = UIFont(name: "HelveticaNeue", size: 17)
//        label.textAlignment = .left
//        return label
//    }()
//    private let 알림설정_화살표 = {
//        let imageView = UIImageView()
//        imageView.image = UIImage(named: "버튼화살표")
//
//        return imageView
//    }()
//    private let 로그아웃_버튼 = {
//        let button = UIButton()
//        button.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
//        button.titleLabel?.textAlignment = .left
//        button.layer.cornerRadius = 15
//        return button
//    } ()
//    private let 로그아웃_라벨 = {
//        let label = UILabel()
//        label.text = "로그아웃"
//        label.textColor = UIColor.white
//        label.font = UIFont(name: "HelveticaNeue", size: 17)
//        label.textAlignment = .left
//        return label
//    }()
//
//    private let 회원탈퇴_버튼 = {
//        let button = UIButton()
//        button.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
//        button.titleLabel?.textAlignment = .left
//        button.layer.cornerRadius = 15
//        return button
//    } ()
//    private let 회원탈퇴_라벨 = {
//        let label = UILabel()
//        label.text = "회원탈퇴"
//        label.textColor = UIColor.systemRed
//        label.font = UIFont(name: "HelveticaNeue", size: 17)
//        label.textAlignment = .left
//        return label
//    }()
//
//    override func viewWillAppear(_ animated: Bool) {
//
//    }
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .black
//        navigationItem.hidesBackButton = true
//        navigationController?.isNavigationBarHidden = true
//        UI레이아웃()
//        화살표_레이아웃()
//        버튼_클릭()
//        화면_제스쳐_실행()
//
//    }
//
//}
//
////버튼 클릭 관련
//extension 마이페이지_설정_페이지 {
//    private func 버튼_클릭() {
//        뒤로가기_버튼.addTarget(self, action: #selector(뒤로가기_버튼_클릭), for: .touchUpInside)
//        프로필변경_버튼.addTarget(self, action: #selector(프로필변경_버튼_클릭), for: .touchUpInside)
//        이메일변경_버튼.addTarget(self, action: #selector(이메일변경_버튼_클릭), for: .touchUpInside)
//        비밀번호변경_버튼.addTarget(self, action: #selector(비밀번호변경_버튼_클릭), for: .touchUpInside)
//        알림설정_버튼.addTarget(self, action: #selector(알림설정_버튼_클릭), for: .touchUpInside)
//
//        로그아웃_버튼.addTarget(self, action: #selector(로그아웃_버튼_클릭), for: .touchUpInside)
//        회원탈퇴_버튼.addTarget(self, action: #selector(회원탈퇴_버튼_클릭), for: .touchUpInside)
//    }
//
//    //일반 뷰전환 버튼
//    @objc private func 프로필변경_버튼_클릭 () {
//        let 프로필변경_화면 = 프로필변경_화면()
////        present(프로필변경_모달, animated: true, completion: nil)
//        self.navigationController?.pushViewController(프로필변경_화면, animated: false)
//        navigationItem.hidesBackButton = true
//    }
//    @objc private func 이메일변경_버튼_클릭 () {
//        let 이메일변경_화면 = 이메일변경_화면()
////        present(비밀번호변경_모달, animated: true, completion: nil)
//        self.navigationController?.pushViewController(이메일변경_화면, animated: false)
//        navigationItem.hidesBackButton = true
//    }
//    @objc private func  비밀번호변경_버튼_클릭 () {
//        let 비밀번호변경_화면 = 비밀번호변경_화면()
////        present(알림설정_모달, animated: true, completion: nil)
//        self.navigationController?.pushViewController(비밀번호변경_화면, animated: false)
//        navigationItem.hidesBackButton = true
//    }
//    @objc private func 알림설정_버튼_클릭 () {
//        let 알림설정_화면 = 알림설정_화면()
////        present(서비스설정_모달, animated: true, completion: nil)
//        self.navigationController?.pushViewController(알림설정_화면, animated: false)
//        navigationItem.hidesBackButton = true
//    }
//    @objc private func 뒤로가기_버튼_클릭() {
//        navigationController?.popViewController(animated: true)
//    }
//}
//
////유저 로그아웃 관련
//extension 마이페이지_설정_페이지 {
//
//    //    클릭했을때
//    @objc private func 로그아웃_버튼_클릭() {
//        let 로그아웃_알럿 = UIAlertController(title: "로그아웃", message: "지금 사용중인 기기에서 로그아웃을 진행할까요?", preferredStyle: .alert)
//
//        let 로그아웃취소_버튼 = UIAlertAction(title: "취소", style: .cancel, handler: nil)
//        로그아웃_알럿.addAction(로그아웃취소_버튼)
//
//        let 로그아웃확인_버튼 = UIAlertAction(title: "로그아웃", style: .destructive) { _ in
//            self.로그아웃_유저로그아웃()
//        }
//        로그아웃_알럿.addAction(로그아웃확인_버튼)
//
//        present(로그아웃_알럿, animated: true, completion: nil)
//
//    }
//
//    func 로그아웃_유저로그아웃() {
//        do {
//            if let 현재접속중인유저 = Auth.auth().currentUser {
//                print("로그아웃한 사용자 정보:")
//                print("UID: \(현재접속중인유저.uid)")
//                print("이메일: \(현재접속중인유저.email ?? "없음")")
//
//                let 파이어스토어 = Firestore.firestore()
//                let 이메일 = 현재접속중인유저.email ?? ""
//                let 유저컬렉션: CollectionReference
//
//                if let providerID = 현재접속중인유저.providerData.first?.providerID, providerID == GoogleAuthProviderID {
//                    유저컬렉션 = 파이어스토어.collection("유저_데이터_관리")
//                } else {
//                    유저컬렉션 = 파이어스토어.collection("유저_데이터_관리")
//                }
//
//                유저컬렉션.whereField("이메일", isEqualTo: 이메일).getDocuments { [weak self] (querySnapshot, 에러) in
//                    guard let self = self else { return }
//
//                    if let 에러 = 에러 {
//                        print("Firestore 조회 에러: \(에러.localizedDescription)")
//                    } else {
//                        if let 문서조회 = querySnapshot?.documents, !문서조회.isEmpty {
//                            let 문서 = 문서조회[0]
//                            let 현재날짜시간 = Timestamp(date: Date())
//
//                            문서.reference.updateData(["로그인상태": false, "마지막로그아웃": 현재날짜시간]) { (에러) in
//                                if let 에러 = 에러 {
//                                    print("Firestore 업데이트 에러: \(에러.localizedDescription)")
//                                } else {
//                                    print("Firestore: 로그인 상태 : false")
//                                    self.로그아웃_프로세스_완료()
//                                }
//                            }
//                        } else {
//                            print("Firestore: 일치하는 이메일이 없습니다.")
//                            self.로그아웃_프로세스_완료()
//                        }
//                    }
//                }
//            }
//        } catch {
//            print("로그아웃 실패: \(error.localizedDescription)")
//        }
//    }
//
//    func 로그아웃_프로세스_완료() {
//        do {
//            try Auth.auth().signOut()
//            print("계정이 로그아웃되었습니다.")
//            let 로그인_뷰컨트롤러 = 로그인_뷰컨트롤러()
//            let 로그인화면_이동 = UINavigationController(rootViewController: 로그인_뷰컨트롤러)
//            로그인화면_이동.modalPresentationStyle = .fullScreen
//            present(로그인화면_이동, animated: true, completion: nil)
//            UserDefaults.standard.removeObject(forKey: "isUserLoggedIn")
//        } catch {
//            print("로그아웃 실패: \(error.localizedDescription)")
//        }
//    }
//
//}
//
////유저 회원탈퇴 관련
//extension 마이페이지_설정_페이지 {
//
//    //클릭했을때
//    @objc private func 회원탈퇴_버튼_클릭() {
//        let 탈퇴확인_알럿 = UIAlertController(title: "회원 탈퇴", message: "탈퇴하면 모든 정보가 삭제됩니다. 이대로 회원 탈퇴를 진행할까요?", preferredStyle: .alert)
//
//        let 탈퇴취소_버튼 = UIAlertAction(title: "취소", style: .cancel, handler: nil)
//        탈퇴확인_알럿.addAction(탈퇴취소_버튼)
//
//        let 탈퇴확인_버튼 = UIAlertAction(title: "탈퇴", style: .destructive) { _ in
//            self.회원탈퇴_데이터삭제()
//        }
//        탈퇴확인_알럿.addAction(탈퇴확인_버튼)
//        present(탈퇴확인_알럿, animated: true, completion: nil)
//    }
//
//    // 회원탈퇴 로직
//    private func 회원탈퇴_데이터삭제() {
//        if let 현제접속중인_유저 = Auth.auth().currentUser {
//            현제접속중인_유저.delete { error in
//                if let error = error {
//                    print("회원 탈퇴 실패: \(error.localizedDescription)")
//                } else {
//                    UserDefaults.standard.removeObject(forKey: "isUserLoggedIn")
//
//                    print("회원 탈퇴 성공")
//
//                }
//            }
//        }
//    }
//}
//
//
////레이아웃 관련
//extension 마이페이지_설정_페이지 {
//
//
//    private func UI레이아웃() {
//        view.addSubview(뒤로가기_버튼)
//        view.addSubview(페이지_제목)
//        view.addSubview(프로필공개여부_버튼)
//        view.addSubview(프로필공개여부_라벨)
//        view.addSubview(프로필공개여부_토글)
//        view.addSubview(프로필변경_버튼)
//        view.addSubview(이메일변경_버튼)
//        view.addSubview(비밀번호변경_버튼)
//        view.addSubview(알림설정_버튼)
//        view.addSubview(로그아웃_버튼)
//        view.addSubview(회원탈퇴_버튼)
//        view.addSubview(프로필변경_라벨)
//        view.addSubview(이메일변경_라벨)
//        view.addSubview(비밀번호변경_라벨)
//        view.addSubview(알림설정_라벨)
//        view.addSubview(로그아웃_라벨)
//        view.addSubview(회원탈퇴_라벨)
//        뒤로가기_버튼.snp.makeConstraints { make in
//            make.centerY.equalTo(페이지_제목.snp.centerY)
//            make.leading.equalToSuperview().offset(16)
//            make.size.equalTo(40)
//        }
//        페이지_제목.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(60)
//            make.centerX.equalToSuperview()
//            make.height.equalTo(44)
//        }
//        프로필공개여부_버튼.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(145)
//            make.leading.equalToSuperview().offset(15)
//            make.trailing.equalToSuperview().offset(-15)
//            make.height.equalTo(44)
//
//        }
//        프로필공개여부_라벨.snp.makeConstraints { make in
//            make.centerY.equalTo(프로필공개여부_버튼.snp.centerY)
//            make.leading.equalTo(프로필공개여부_버튼.snp.leading).offset(16)
//        }
//        프로필공개여부_토글.snp.makeConstraints { make in
//            make.centerY.equalTo(프로필공개여부_버튼.snp.centerY)
//            make.trailing.equalTo(프로필공개여부_버튼.snp.trailing).offset(-16)
//        }
//        프로필변경_버튼.snp.makeConstraints { make in
//            make.top.equalTo(프로필공개여부_버튼.snp.bottom).offset(24)
//            make.leading.equalToSuperview().offset(15)
//            make.trailing.equalToSuperview().offset(-15)
//            make.height.equalTo(44)
//
//        }
//        프로필변경_라벨.snp.makeConstraints { make in
//            make.centerY.equalTo(프로필변경_버튼.snp.centerY)
//            make.leading.equalTo(프로필변경_버튼.snp.leading).offset(16)
//        }
//
//        이메일변경_버튼.snp.makeConstraints { make in
//            make.top.equalTo(프로필변경_버튼.snp.bottom).offset(2)
//            make.leading.equalToSuperview().offset(15)
//            make.trailing.equalToSuperview().offset(-15)
//            make.height.equalTo(44)
//
//        }
//        이메일변경_라벨.snp.makeConstraints { make in
//            make.centerY.equalTo(이메일변경_버튼.snp.centerY)
//            make.leading.equalTo(이메일변경_버튼.snp.leading).offset(16)
//        }
//
//        비밀번호변경_버튼.snp.makeConstraints { make in
//            make.top.equalTo(이메일변경_버튼.snp.bottom).offset(2)
//            make.leading.equalToSuperview().offset(15)
//            make.trailing.equalToSuperview().offset(-15)
//            make.height.equalTo(44)
//
//        }
//        비밀번호변경_라벨.snp.makeConstraints { make in
//            make.centerY.equalTo(비밀번호변경_버튼.snp.centerY)
//            make.leading.equalTo(비밀번호변경_버튼.snp.leading).offset(16)
//        }
//
//        알림설정_버튼.snp.makeConstraints { make in
//            make.top.equalTo(비밀번호변경_버튼.snp.bottom).offset(2)
//            make.leading.equalToSuperview().offset(15)
//            make.trailing.equalToSuperview().offset(-15)
//            make.height.equalTo(44)
//        }
//        알림설정_라벨.snp.makeConstraints { make in
//            make.centerY.equalTo(알림설정_버튼.snp.centerY)
//            make.leading.equalTo(알림설정_버튼.snp.leading).offset(16)
//        }
//
//        로그아웃_버튼.snp.makeConstraints { make in
//            make.top.equalTo(알림설정_버튼.snp.bottom).offset(24)
//            make.leading.equalToSuperview().offset(15)
//            make.trailing.equalToSuperview().offset(-15)
//            make.height.equalTo(44)
//        }
//        로그아웃_라벨.snp.makeConstraints { make in
//            make.centerY.equalTo(로그아웃_버튼.snp.centerY)
//            make.leading.equalTo(로그아웃_버튼.snp.leading).offset(16)
//        }
//        회원탈퇴_버튼.snp.makeConstraints { make in
//            make.top.equalTo(로그아웃_버튼.snp.bottom).offset(24)
//            make.leading.equalToSuperview().offset(15)
//            make.trailing.equalToSuperview().offset(-15)
//            make.height.equalTo(44)
//        }
//        회원탈퇴_라벨.snp.makeConstraints { make in
//            make.centerY.equalTo(회원탈퇴_버튼.snp.centerY)
//            make.leading.equalTo(회원탈퇴_버튼.snp.leading).offset(16)
//        }
//    }
//    private func 화살표_레이아웃() {
//        view.addSubview(프로필변경_화살표)
//        view.addSubview(이메일변경_화살표)
//        view.addSubview(비밀번호변경_화살표)
//        view.addSubview(알림설정_화살표)
//
//        프로필변경_화살표.snp.makeConstraints { make in
//            make.centerY.equalTo(프로필변경_버튼
//                .snp.centerY)
//            make.trailing.equalTo(프로필변경_버튼.snp.trailing).offset(-16)
//        }
//
//        이메일변경_화살표.snp.makeConstraints { make in
//            make.centerY.equalTo(이메일변경_버튼.snp.centerY)
//            make.trailing.equalTo(이메일변경_버튼.snp.trailing).offset(-16)
//        }
//
//        비밀번호변경_화살표.snp.makeConstraints { make in
//            make.centerY.equalTo(비밀번호변경_버튼.snp.centerY)
//            make.trailing.equalTo(비밀번호변경_버튼.snp.trailing).offset(-16)
//        }
//
//        알림설정_화살표.snp.makeConstraints { make in
//            make.centerY.equalTo(알림설정_버튼.snp.centerY)
//            make.trailing.equalTo(알림설정_버튼.snp.trailing).offset(-16)
//        }
//    }
//}
//
//
//
//extension 마이페이지_설정_페이지 {
//
//    func 화면_제스쳐_실행 () {
//        let 화면_제스쳐 = UISwipeGestureRecognizer(target: self, action: #selector(화면_제스쳐_뒤로_가기))
//        화면_제스쳐.direction = .right
//        view.addGestureRecognizer(화면_제스쳐)
//    }
//    @objc private func 화면_제스쳐_뒤로_가기() {
//        navigationController?.popViewController(animated: true)
//    }
//
//}
//
struct 설정아이템 {
    let title: String
    var isSwitchOn: Bool
    let action: () -> Void
}
class 마이페이지_설정_페이지 : UIViewController, UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    
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
        button.isSelected = !button.isSelected
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        return button
    } ()
    
    private let 설정_테이블뷰 = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.layer.cornerRadius = 10
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    private var 설정아이템들: [[설정아이템]] = []
    
    
    override func viewDidLoad() {
        view.backgroundColor = .black
        
        UI레이아웃()
        설정_테이블뷰.delegate = self
        설정_테이블뷰.dataSource = self
        설정_테이블뷰.register(설정_셀.self, forCellReuseIdentifier: "설정_셀")
        설정아이템들_구성()
        버튼_클릭()
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.hidesBackButton = true
        navigationController?.isNavigationBarHidden = true
        tabBarController?.tabBar.isHidden = true
        
        
        
    }
    
    func 로그아웃_유저로그아웃() {
        do {
            if let 현재접속중인유저 = Auth.auth().currentUser {
                print("로그아웃한 사용자 정보:")
                print("UID: \(현재접속중인유저.uid)")
                print("이메일: \(현재접속중인유저.email ?? "없음")")
                
                let 파이어스토어 = Firestore.firestore()
                let 이메일 = 현재접속중인유저.email ?? ""
                let 유저컬렉션: CollectionReference
                
                if let providerID = 현재접속중인유저.providerData.first?.providerID, providerID == GoogleAuthProviderID {
                    유저컬렉션 = 파이어스토어.collection("유저_데이터_관리")
                } else {
                    유저컬렉션 = 파이어스토어.collection("유저_데이터_관리")
                }
                
                유저컬렉션.whereField("이메일", isEqualTo: 이메일).getDocuments { [weak self] (querySnapshot, 에러) in
                    guard let self = self else { return }
                    
                    if let 에러 = 에러 {
                        print("Firestore 조회 에러: \(에러.localizedDescription)")
                    } else {
                        if let 문서조회 = querySnapshot?.documents, !문서조회.isEmpty {
                            let 문서 = 문서조회[0]
                            let 현재날짜시간 = Timestamp(date: Date())
                            
                            문서.reference.updateData(["로그인상태": false, "마지막로그아웃": 현재날짜시간]) { (에러) in
                                if let 에러 = 에러 {
                                    print("Firestore 업데이트 에러: \(에러.localizedDescription)")
                                } else {
                                    print("Firestore: 로그인 상태 : false")
                                    self.로그아웃_프로세스_완료()
                                }
                            }
                        } else {
                            print("Firestore: 일치하는 이메일이 없습니다.")
                            self.로그아웃_프로세스_완료()
                        }
                    }
                }
            }
        } catch {
            print("로그아웃 실패: \(error.localizedDescription)")
        }
    }
    
    func 로그아웃_프로세스_완료() {
        do {
            try Auth.auth().signOut()
            print("계정이 로그아웃되었습니다.")
            let 로그인_뷰컨트롤러 = 로그인_뷰컨트롤러()
            let 로그인화면_이동 = UINavigationController(rootViewController: 로그인_뷰컨트롤러)
            로그인화면_이동.modalPresentationStyle = .fullScreen
            present(로그인화면_이동, animated: false, completion: nil)
            UserDefaults.standard.removeObject(forKey: "isUserLoggedIn")
        } catch {
            print("로그아웃 실패: \(error.localizedDescription)")
        }
    }
}
extension 마이페이지_설정_페이지  {
    
    private func 버튼_클릭() {
        뒤로가기_버튼.addTarget(self, action: #selector(뒤로가기_버튼_클릭), for: .touchUpInside)
    }
    @objc private func 뒤로가기_버튼_클릭() {
        navigationController?.popViewController(animated: true)
    }
    @objc private func 프로필스위치변경(sender: UISwitch) {
        let indexPath = IndexPath(row: 0, section: 0)
        설정아이템들[indexPath.section][indexPath.row].isSwitchOn = sender.isOn
    }
    @objc func 셀_클릭(for cell: 설정_셀) {
        if let 셀_제목_라벨 = cell.버튼_이름_라벨.text {
            print("선택된 셀의 라벨: \(셀_제목_라벨)")
            if 셀_제목_라벨 == "프로필 변경" {
                let 프로필변경_화면이동 = 프로필변경_화면()
                navigationController?.pushViewController(프로필변경_화면이동, animated: true)
            }
            else if 셀_제목_라벨 == "이메일 변경" {
                let 이메일변경_화면이동 = 이메일변경_화면()
                navigationController?.pushViewController(이메일변경_화면이동, animated: true)
            }
            else if 셀_제목_라벨 == "비밀번호 변경" {
                let 비밀번호변경_화면이동 = 비밀번호변경_화면()
                navigationController?.pushViewController(비밀번호변경_화면이동, animated: true)
            }
            else if 셀_제목_라벨 == "알림 설정" {
                let 알림설정_화면이동 = 알림설정_화면()
                navigationController?.pushViewController(알림설정_화면이동, animated: true)
            }
            else if 셀_제목_라벨 == "로그아웃" {
                let 로그아웃_알럿 = UIAlertController(title: "로그아웃", message: "지금 사용중인 기기에서 로그아웃을 진행할까요?", preferredStyle: .alert)
                
                let 로그아웃취소_버튼 = UIAlertAction(title: "취소", style: .cancel, handler: nil)
                로그아웃_알럿.addAction(로그아웃취소_버튼)
                
                let 로그아웃확인_버튼 = UIAlertAction(title: "로그아웃", style: .destructive) { _ in
                    self.로그아웃_유저로그아웃()
                }
                로그아웃_알럿.addAction(로그아웃확인_버튼)
                
                present(로그아웃_알럿, animated: true, completion: nil)
            }
            else if 셀_제목_라벨 == "회원 탈퇴" {
                let 회원탈퇴_알럿 = UIAlertController(title: "회원탈퇴", message: "모든 정보가 삭제됩니다. 정말 탈퇴하시나요 ?", preferredStyle: .alert)

                let 회원탈퇴취소_버튼 = UIAlertAction(title: "취소", style: .cancel, handler: nil)
                회원탈퇴_알럿.addAction(회원탈퇴취소_버튼)

                let 회원탈퇴확인_버튼 = UIAlertAction(title: "회원탈퇴", style: .destructive) { _ in
                    self.회원탈퇴_기능()
                }
                회원탈퇴_알럿.addAction(회원탈퇴확인_버튼)

                present(회원탈퇴_알럿, animated: true, completion: nil)

            }
            
        }
    }
}
//레이아웃 관련
extension 마이페이지_설정_페이지 {
    
    
    private func UI레이아웃() {
        view.addSubview(뒤로가기_버튼)
        view.addSubview(페이지_제목)
        view.addSubview(설정_테이블뷰)
        
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
        설정_테이블뷰.snp.makeConstraints { make in
            make.top.equalTo(페이지_제목.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-50)
        }
    }
    
    private func 설정아이템들_구성() {
        설정아이템들 = [
            [설정아이템(title: "프로필 공개 / 비공개", isSwitchOn: false, action: { /* 프로필 공개 / 비공개 기능  */ })],
            [
                설정아이템(title: "프로필 변경", isSwitchOn: false, action: { /* 프로필 변경 기능  */ }),
                설정아이템(title: "이메일 변경", isSwitchOn: false, action: { /* 이메일 변경 기능  */ }),
                설정아이템(title: "비밀번호 변경", isSwitchOn: false, action: { /* 비밀번호 변경 기능  */ }),
                설정아이템(title: "알림 설정", isSwitchOn: false, action: { /* 알림 설정 기능  */ })
            ],
            [설정아이템(title: "로그아웃", isSwitchOn: false, action: { /* 로그아웃  기능  */ })],
            [설정아이템(title: "회원 탈퇴", isSwitchOn: false, action: { /* 회원 탈퇴 기능  */ })]
        ]
    }
}



extension 마이페이지_설정_페이지 : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 설정아이템들.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 설정아이템들[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let 셀 = tableView.dequeueReusableCell(withIdentifier: "설정_셀", for: indexPath) as! 설정_셀
        let 설정아이템 = 설정아이템들[indexPath.section][indexPath.row]
        
        셀.configure(with: 설정아이템.title)
        셀.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
        
        if indexPath.section == 0 && indexPath.row == 0 {
            let 스위치 = UISwitch()
            스위치.isOn = 설정아이템.isSwitchOn
            스위치.addTarget(self, action: #selector(프로필스위치변경), for: .valueChanged)
            셀.accessoryView = 스위치
            셀.selectionStyle = .none
            셀.layer.cornerRadius = 10
            
        } else if indexPath.section == 1 {
            셀.accessoryType = .disclosureIndicator
            셀.tintColor = UIColor.lightGray
            if indexPath.row == 0 {
                셀.layer.cornerRadius = 10
                셀.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            } else if indexPath.row == 3 {
                셀.layer.cornerRadius = 10
                셀.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            }
        }  else if indexPath.section == 2 && indexPath.row == 0{
            셀.layer.cornerRadius = 10
            
        }
        else {
            셀.accessoryType = .none
        }
        if indexPath.section == 3 && indexPath.row == 0 {
            셀.버튼_이름_라벨.textColor = .red
            셀.selectionStyle = .none
            셀.layer.cornerRadius = 10
        }
        return 셀
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //           설정아이템들[indexPath.section][indexPath.row].action()
        
        let selectedCell = (tableView.cellForRow(at: indexPath) as? 설정_셀)!
        셀_클릭(for: selectedCell)
        
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return " "
        case 1:
            return " "
        case 2:
            return " "
        case 3:
            return " "
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if section == 0 || section == 2 || section == 3 {
            view.tintColor = .clear
        } else {
            view.tintColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
            
            let header = view as! UITableViewHeaderFooterView
            header.textLabel?.textColor = .white
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == 0 || indexPath.section == 2 || indexPath.section == 3 , indexPath.section == 1 && indexPath.row == 3 {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        } else {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        }
        if indexPath.row == 설정아이템들[indexPath.section].count - 1 {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        }
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        tabBarController?.tabBar.isHidden = true
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            tabBarController?.tabBar.isHidden = true
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        tabBarController?.tabBar.isHidden = true
    }
    
}

class 설정_셀: UITableViewCell {
    
    let 버튼_이름_라벨 = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(버튼_이름_라벨)
        
        버튼_이름_라벨.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
    }
    
    func configure(with title: String) {
        버튼_이름_라벨.text = title
    }
}


extension 마이페이지_설정_페이지 {
    
    func 회원탈퇴_기능() {
        if let 현재접속중인유저 = Auth.auth().currentUser {
            if let 제공업체 = 현재접속중인유저.providerData.first?.providerID, 제공업체 == "password" {
                UserDefaults.standard.removeObject(forKey: "isUserLoggedIn")
                회원탈퇴_auth()
                
                
            } else if let 제공업체 = 현재접속중인유저.providerData.first?.providerID, 제공업체 == "google.com" {
                let 구글계정일경우_알럿 = UIAlertController(title: "구글 계정입니다.", message: "구글 계정은 회원 탈퇴 서비스를 지원하지 않습니다.", preferredStyle: .alert)
                
                let 확인액션 = UIAlertAction(title: "확인", style: .default) { _ in
                }
                
                구글계정일경우_알럿.addAction(확인액션)
                
                self.present(구글계정일경우_알럿, animated: true, completion: nil)
            }
        } else {
            print("도트 회원가입 자체 서비스 방식으로 가입한 계정이 아닙니다.")
        }
    }
    
    
    func 회원탈퇴_auth() {
        if let user = Auth.auth().currentUser {
            let 재인증요청_텍스트필드_알럿 = UIAlertController(title: "회원탈퇴", message: "회원탈퇴 진행을 위해 비밀번호를 입력하세요.", preferredStyle: .alert)
            
            재인증요청_텍스트필드_알럿.addTextField { textField in
                textField.placeholder = "비밀번호"
                textField.isSecureTextEntry = true
            }
            
            let 취소액션 = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            재인증요청_텍스트필드_알럿.addAction(취소액션)
            
            let 확인액션 = UIAlertAction(title: "확인", style: .default) { [weak self] _ in
                guard let self = self, let passwordTextField = 재인증요청_텍스트필드_알럿.textFields?.first else { return }
                
                let password = passwordTextField.text ?? ""
                let credential = EmailAuthProvider.credential(withEmail: user.email!, password: password)
                
                user.reauthenticate(with: credential) { _, error in
                    if let error = error {
                        print("재인증 실패: \(error.localizedDescription)")
                    } else {
                        self.파이어스토어에서_도트회원_정보_삭제 ()
                        DispatchQueue.main.async {
                            let 로그인_뷰컨트롤러 = 로그인_뷰컨트롤러()
                            let 로그인화면_이동 = UINavigationController(rootViewController: 로그인_뷰컨트롤러)
                            로그인화면_이동.modalPresentationStyle = .fullScreen

                            self.present(로그인화면_이동, animated: true, completion: nil)
                        }
                    }
                }
            }
            재인증요청_텍스트필드_알럿.addAction(확인액션)
            self.present(재인증요청_텍스트필드_알럿, animated: false, completion: nil)
        }
    }
    func 파이어스토어에서_도트회원_정보_삭제 () {
        if let 현재접속중인유저 = Auth.auth().currentUser {
            if let 제공업체 = 현재접속중인유저.providerData.first?.providerID, 제공업체 == "password" {
                let 데이터베이스 = Firestore.firestore()
                let 유저컬렉션 = 데이터베이스.collection("유저_데이터_관리")
                
                유저컬렉션.document(현재접속중인유저.uid).delete { error in
                    if let error = error {
                        print("Firestore에서 사용자 데이터 삭제 실패: \(error.localizedDescription)")
                    } else {
                        print("Firestore에서 사용자 데이터 삭제 성공")
                        
                        현재접속중인유저.delete { error in
                            if let error = error {
                                print("Firebase Authentication에서 사용자 삭제 실패: \(error.localizedDescription)")
                            } else {
                                print("Firebase Authentication에서 사용자 삭제 성공")
                                self.실제_계정탈퇴()
                            }
                        }
                    }
                }
            }
        }
    }
    func 실제_계정탈퇴() {
        do {
            try Auth.auth().currentUser?.delete(completion: { [weak self] error in
                guard let self = self else { return }

                if let error = error {
                    print("계정 탈퇴 실패: \(error.localizedDescription)")
                } else {
                    print("계정이 성공적으로 탈퇴되었습니다.")
                   
                }
            })
        } catch {
            print("탈퇴 실패: \(error.localizedDescription)")
        }
    }

}

