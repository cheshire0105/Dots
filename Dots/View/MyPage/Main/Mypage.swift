// 최신화  유저_다녀옴_날짜 데이터를 해당 유저의 마이페이지 켈린더에 표시하기
import UIKit
import SnapKit
import FSCalendar
import Firebase
import FirebaseAuth
import FirebaseFirestore
import GoogleSignIn

class Mypage: UIViewController {
    var 유저_다녀옴_날짜: [Date] = [].compactMap { $0 }
    
    
    var 마이페이지_프로필_이미지_버튼 = {
        var imageButton = UIButton()
        imageButton.layer.cornerRadius = 38
        imageButton.clipsToBounds = true
        //        imageButton.setImage(UIImage(named: "cabanel"), for: .selected)
        //        imageButton.setImage(UIImage(named: "cabanel"), for: .normal)
        imageButton.isSelected = !imageButton.isSelected
        return imageButton
    }()
    
    let 버튼_백 = {
        let uiView = UIView()
        uiView.backgroundColor = UIColor.black
        return uiView
    } ()
    
    let 마이페이지_설정_버튼 = {
        var button = UIButton()
        button.setImage(UIImage(named: "setting" ), for: .normal)
        button.isSelected = !button.isSelected
        return button
    } ()
    
    let 마이페이지_알림_버튼 = {
        var button = UIButton()
        button.setImage(UIImage(named: "알림" ), for: .normal)
        button.isSelected = !button.isSelected
        return button
    } ()
    
    let 마이페이지_프로필_닉네임: UILabel = {
        let label = UILabel()
        label.text = "유저 닉네임"
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let 마이페이지_프로필_이메일: UILabel = {
        let label = UILabel()
        label.text = "유저 이메일"
        label.textColor = UIColor.white
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        return label
    }()
    
    let 마이페이지_전시_버튼 = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
        button.layer.cornerRadius = 10
        button.isSelected = !button.isSelected
        return button
    } ()
    
    let 마이페이지_전시_아이콘 = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "전시")
        imageView.contentMode = .scaleAspectFill
        return imageView
    } ()
    
    let 마이페이지_전시_라벨 = {
        let label = UILabel()
        label.text = "전시"
        label.font = UIFont(name: "HelveticaNeue", size: 12)
        label.textColor = UIColor.white
        return label
    } ()
    
    let 마이페이지_후기_버튼 = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
        button.layer.cornerRadius = 10
        button.isSelected = !button.isSelected
        return button
    } ()
    
    let 마이페이지_후기_아이콘 = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "후기")
        imageView.contentMode = .scaleAspectFill
        return imageView
    } ()
    
    let 마이페이지_후기_라벨 = {
        let label = UILabel()
        label.text = "리뷰"
        label.font = UIFont(name: "HelveticaNeue", size: 12)
        label.textColor = UIColor.white
        return label
    } ()
    
    let 마이페이지_보관함_버튼 = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
        button.layer.cornerRadius = 10
        button.isSelected = !button.isSelected
        return button
    } ()
    
    let 마이페이지_보관함_아이콘 = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "보관함")
        imageView.contentMode = .scaleAspectFill
        return imageView
    } ()
    
    let 마이페이지_보관함_라벨 = {
        let label = UILabel()
        label.text = "보관함"
        label.font = UIFont(name: "HelveticaNeue", size: 12)
        label.textColor = UIColor.white
        return label
    } ()
    
    let 구분선 = {
        let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }()
    
    /*
     
     
     캘 린 더
     
     
     */
    
    lazy var 캘린더 = {
        let calendar = FSCalendar()
        calendar.backgroundColor = UIColor.clear
        calendar.layer.cornerRadius = 15
        calendar.layer.borderWidth = 0.3
        //        calendar.layer.borderColor = UIColor(named: "neon")?.cgColor
        
        
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        calendar.appearance.headerDateFormat = "MMMM yyyy"
        calendar.appearance.headerTitleColor = UIColor.white
        calendar.appearance.headerTitleFont = UIFont.boldSystemFont(ofSize: 20)
        calendar.appearance.weekdayTextColor = UIColor.darkGray
        calendar.appearance.todayColor = UIColor.clear
        calendar.appearance.todaySelectionColor = UIColor.clear
        calendar.appearance.titleTodayColor = UIColor(named: "neon")
        
        calendar.appearance.selectionColor = UIColor.clear
        calendar.appearance.titleDefaultColor = UIColor.white
        calendar.appearance.titleSelectionColor = UIColor.white
        calendar.appearance.titleFont = UIFont.systemFont(ofSize: 17)
        calendar.appearance.weekdayFont = UIFont.boldSystemFont(ofSize: 14)
        calendar.scrollDirection = .vertical
        calendar.scope = .month
        calendar.allowsMultipleSelection = false
        
        return calendar
    }()
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        캐시된_유저_데이터_마이페이지_적용하기()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("My Page")
        view.backgroundColor = UIColor.black
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.backgroundColor = UIColor.clear
        navigationController?.isNavigationBarHidden = true
        버튼_클릭()
        UI레이아웃()
        버튼_백_레이아웃 ()
        
        캘린더_레이아웃()
        캘린더.dataSource = self
        캘린더.delegate = self
        캘린더.register(FSCalendarCell.self, forCellReuseIdentifier: "cell")
        
        캐시된_유저_데이터_마이페이지_적용하기()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleOutsideTap))
        tapGestureRecognizer.delegate = self
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    @objc private func handleOutsideTap() {
        // 모달이 표시 중이면 dismiss
        if presentedViewController != nil {
            dismiss(animated: true, completion: nil)
        }
    }
    private func 버튼_백_레이아웃 () {
        for 버튼배치 in [마이페이지_전시_버튼,마이페이지_후기_버튼,마이페이지_보관함_버튼,마이페이지_전시_아이콘,마이페이지_후기_아이콘,마이페이지_보관함_아이콘,마이페이지_전시_라벨,마이페이지_후기_라벨,마이페이지_보관함_라벨] {
            버튼_백.addSubview(버튼배치)
        }
        
        
        마이페이지_전시_버튼.snp.makeConstraints { make in
            make.top.equalTo(버튼_백.snp.top).offset(15)
            make.bottom.equalTo(버튼_백.snp.bottom).offset(-15)
            
            make.trailing.equalTo(마이페이지_후기_버튼.snp.leading).offset(-11)
            make.height.equalTo(마이페이지_후기_버튼)
            make.width.equalTo(마이페이지_후기_버튼)
            make.leading.equalTo(버튼_백.snp.leading).offset(10)
        }
        
        마이페이지_후기_버튼.snp.makeConstraints { make in
            make.top.equalTo(버튼_백.snp.top).offset(15)
            make.centerX.equalTo(버튼_백.snp.centerX)
            make.bottom.equalTo(버튼_백.snp.bottom).offset(-15)
            
        }
        마이페이지_보관함_버튼.snp.makeConstraints { make in
            make.top.equalTo(버튼_백.snp.top).offset(15)
            make.leading.equalTo(마이페이지_후기_버튼.snp.trailing).offset(11)
            make.width.equalTo(마이페이지_후기_버튼)
            make.height.equalTo(마이페이지_후기_버튼)
            make.trailing.equalTo(버튼_백.snp.trailing).offset(-10)
            make.bottom.equalTo(버튼_백.snp.bottom).offset(-15)
            
            
            
        }
        
        마이페이지_전시_아이콘.snp.makeConstraints { make in
            make.centerX.equalTo(마이페이지_전시_버튼.snp.centerX)
            make.bottom.equalTo(마이페이지_전시_버튼.snp.centerY)
            make.size.equalTo(20)
        }
        마이페이지_후기_아이콘.snp.makeConstraints { make in
            make.centerX.equalTo(마이페이지_후기_버튼.snp.centerX)
            make.bottom.equalTo(마이페이지_후기_버튼.snp.centerY)
            make.size.equalTo(20)
        }
        마이페이지_보관함_아이콘.snp.makeConstraints { make in
            make.centerX.equalTo(마이페이지_보관함_버튼.snp.centerX)
            make.bottom.equalTo(마이페이지_보관함_버튼.snp.centerY)
            make.size.equalTo(20)
        }
        마이페이지_전시_라벨.snp.makeConstraints { make in
            make.centerX.equalTo(마이페이지_전시_버튼.snp.centerX)
            make.top.equalTo(마이페이지_전시_버튼.snp.centerY).offset(6)
        }
        마이페이지_후기_라벨.snp.makeConstraints { make in
            make.centerX.equalTo(마이페이지_후기_버튼.snp.centerX)
            make.top.equalTo(마이페이지_후기_버튼.snp.centerY).offset(6)
        }
        
        마이페이지_보관함_라벨.snp.makeConstraints { make in
            make.centerX.equalTo(마이페이지_보관함_버튼.snp.centerX)
            make.top.equalTo(마이페이지_보관함_버튼.snp.centerY).offset(6)
        }
        
        
        
    }
    private func UI레이아웃 () {
        
        for UI뷰 in [마이페이지_프로필_이미지_버튼,마이페이지_설정_버튼,마이페이지_알림_버튼,마이페이지_프로필_닉네임,마이페이지_프로필_이메일,버튼_백,구분선,]{
            view.addSubview(UI뷰)
        }
        마이페이지_프로필_이미지_버튼.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(80)
            make.leading.equalToSuperview().offset(28)
            make.size.equalTo(76)
        }
        마이페이지_설정_버튼.snp.makeConstraints { make in
            //            make.centerY.equalTo(마이페이지_프로필_이미지_버튼.snp.centerY)
            //            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(3)
            //            make.bottom.equalTo(마이페이지_프로필_닉네임.snp.bottom)
            make.top.equalToSuperview().offset(65)
            make.trailing.equalToSuperview().offset(-26)
        }
        마이페이지_알림_버튼.snp.makeConstraints { make in
            //            make.centerY.equalTo(마이페이지_프로필_이미지_버튼.snp.centerY)
            //            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(3)
            //            make.bottom.equalTo(마이페이지_프로필_닉네임.snp.bottom)
            make.top.equalToSuperview().offset(65)
            make.trailing.equalTo(마이페이지_설정_버튼.snp.leading ).offset(-20)
        }
        마이페이지_프로필_닉네임.snp.makeConstraints { make in
            make.leading.equalTo(마이페이지_프로필_이미지_버튼.snp.trailing).offset(16)
            make.centerY.equalTo(마이페이지_프로필_이미지_버튼.snp.centerY).offset(-10)
        }
        마이페이지_프로필_이메일.snp.makeConstraints { make in
            make.leading.equalTo(마이페이지_프로필_이미지_버튼.snp.trailing).offset(16)
            make.trailing.equalTo(마이페이지_프로필_닉네임.snp.trailing)
            make.centerY.equalTo(마이페이지_프로필_이미지_버튼.snp.centerY).offset(10)
        }
        버튼_백.snp.makeConstraints { make in
            make.top.equalTo(마이페이지_프로필_이미지_버튼.snp.bottom).offset(5)
            make.bottom.equalTo(구분선.snp.bottom).offset(-10)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        구분선.snp.makeConstraints { make in
            make.top.equalTo(마이페이지_프로필_이미지_버튼.snp.bottom).offset(95)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
    }
    
    func 캘린더_레이아웃() {
        view.addSubview(캘린더)
        캘린더.snp.makeConstraints { make in
            make.top.equalTo(구분선.snp.bottom).offset(-10)
            make.leading.equalToSuperview().offset(4)
            make.trailing.equalToSuperview().offset(-4)
            make.bottom.equalToSuperview().offset(-60)
        }
    }
    
}

extension Mypage {
    func 버튼_클릭() {
        마이페이지_설정_버튼.addTarget(self, action: #selector(마이페이지_설정_버튼_클릭), for: .touchUpInside)
        마이페이지_전시_버튼.addTarget(self, action: #selector(마이페이지_전시_버튼_클릭), for: .touchUpInside)
        마이페이지_후기_버튼.addTarget(self, action: #selector(마이페이지_후기_버튼_클릭), for: .touchUpInside)
        마이페이지_보관함_버튼.addTarget(self, action: #selector(마이페이지_보관함_버튼_클릭), for: .touchUpInside)
    }
    @objc func 마이페이지_설정_버튼_클릭() {
        let 설정_이동 = 마이페이지_설정_페이지()
        self.navigationController?.pushViewController(설정_이동, animated: false)
        self.navigationItem.hidesBackButton = true
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @objc func 마이페이지_알림_버튼_클릭() {
        let 알림_이동 = 마이페이지_알림()
        self.navigationController?.pushViewController(알림_이동, animated: true)
        self.navigationItem.hidesBackButton = true
        self.dismiss(animated: true, completion: nil)
        
    }
    @objc func 마이페이지_전시_버튼_클릭 () {
        let 전시_이동 = 마이페이지_전시()
        self.navigationController?.pushViewController(전시_이동, animated: true)
        self.navigationItem.hidesBackButton = true
        self.dismiss(animated: true, completion: nil)
        
    }
    @objc func 마이페이지_후기_버튼_클릭 () {
        let 후기_이동 = 마이페이지_리뷰()
        self.navigationController?.pushViewController(후기_이동, animated: true)
        self.navigationItem.hidesBackButton = true
        self.dismiss(animated: true, completion: nil)
        
    }
    @objc func 마이페이지_보관함_버튼_클릭 () {
        let 보관함_이동 = 마이페이지_보관함()
        self.navigationController?.pushViewController(보관함_이동, animated: true)
        self.navigationItem.hidesBackButton = true
        self.dismiss(animated: true, completion: nil)
        
    }
    
}



extension UIImage {
    func resized(to 사이즈: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: 사이즈).image { _ in
            draw(in: CGRect(origin: .zero, size: 사이즈))
        }
    }
}


extension Mypage {
    
    
    //    private func 접속_유저_데이터_마이페이지_적용하기() {
    //          guard let 현재접속중인유저 = Auth.auth().currentUser else {
    //              return
    //          }
    //
    //          let 파이어스토어 = Firestore.firestore()
    //          let 이메일 = 현재접속중인유저.email ?? ""
    //          let 유저컬렉션: CollectionReference
    //
    //          if let providerID = 현재접속중인유저.providerData.first?.providerID, providerID == GoogleAuthProviderID {
    //              유저컬렉션 = 파이어스토어.collection("유저_데이터_관리")
    //          } else {
    //              유저컬렉션 = 파이어스토어.collection("유저_데이터_관리")
    //          }
    //
    //          유저컬렉션.whereField("이메일", isEqualTo: 이메일).getDocuments { [weak self] (querySnapshot, error) in
    //              guard let self = self, let documents = querySnapshot?.documents, error == nil else {
    //                  print("컬렉션 조회 실패")
    //                  return
    //              }
    //
    //              if let userDocument = documents.first {
    //                  let 프로필이미지URL = userDocument["프로필이미지URL"] as? String ?? ""
    //                  let 닉네임 = userDocument["닉네임"] as? String ?? ""
    //                  let 이메일 = userDocument["이메일"] as? String ?? ""
    //
    //                  DispatchQueue.main.async {
    //                      if let url = URL(string: 프로필이미지URL) {
    //
    //                          self.마이페이지_프로필_이미지_버튼.sd_setImage(with: url, for: .normal, completed: nil)
    //                      }
    //
    //                      self.마이페이지_프로필_닉네임.text = 닉네임
    //                      self.마이페이지_프로필_이메일.text = 이메일
    //                  }
    //              }
    //          }
    //      }
    private func 캐시된_유저_데이터_마이페이지_적용하기() {
        var 닉네임_캐싱: String?
        var 이메일_캐싱: String?
        if let 캐시된닉네임 = 닉네임_캐싱, let 캐시된이메일 = 이메일_캐싱 {
            캐시된_유저_닉네임_이메일_마이페이지_적용하기( 닉네임: 캐시된닉네임, 이메일: 캐시된이메일)
            return
        }
        
        guard let 현재접속중인유저 = Auth.auth().currentUser else {
            return
        }
        
        let 파이어스토어 = Firestore.firestore()
        let 이메일 = 현재접속중인유저.email ?? ""
        let 유저컬렉션: CollectionReference
        
        if let providerID = 현재접속중인유저.providerData.first?.providerID, providerID == GoogleAuthProviderID {
            유저컬렉션 = 파이어스토어.collection("유저_데이터_관리")
        } else {
            유저컬렉션 = 파이어스토어.collection("유저_데이터_관리")
        }
        
        유저컬렉션.whereField("이메일", isEqualTo: 이메일).getDocuments { [weak self] (querySnapshot, error) in
            guard let self = self, let documents = querySnapshot?.documents, error == nil else {
                print("컬렉션 조회 실패")
                return
            }
            
            if let userDocument = documents.first {
                let 프로필이미지URL = userDocument["프로필이미지URL"] as? String ?? ""
                let 닉네임 = userDocument["닉네임"] as? String ?? ""
                let 이메일 = userDocument["이메일"] as? String ?? ""
                            
                닉네임_캐싱 = 닉네임
                이메일_캐싱 = 이메일
                
                DispatchQueue.main.async {
                    self.캐시된_유저_닉네임_이메일_마이페이지_적용하기(닉네임: 닉네임_캐싱, 이메일: 이메일_캐싱)
                    if let url = URL(string: 프로필이미지URL) {
                        self.마이페이지_프로필_이미지_버튼.sd_setImage(with: url, for: .normal, completed: nil)
                    }
                }
            }
        }
    }
    
    private func 캐시된_유저_닉네임_이메일_마이페이지_적용하기( 닉네임: String?, 이메일: String?) {
        
        if let 닉네임 = 닉네임 {
            self.마이페이지_프로필_닉네임.text = 닉네임
        }
        
        if let 이메일 = 이메일 {
            self.마이페이지_프로필_이메일.text = 이메일
        }
    }
}

extension Mypage: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {

        if presentedViewController != nil && touch.view == view {
            return true
        }
        return false
    }
}
