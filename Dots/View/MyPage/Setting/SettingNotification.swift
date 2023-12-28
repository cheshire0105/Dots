import UIKit

class 알림설정_화면 : UIViewController, UIGestureRecognizerDelegate {
    private let 뒤로가기_버튼 = {
        let button = UIButton()
        button.setImage(UIImage(named: "loginBack"), for: .selected)
        button.isSelected = !button.isSelected
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        return button
    } ()
    
    private let 페이지_제목 = {
        let label = UILabel()
        label.text = "알림 설정"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    private let 팔로우_백 = {
        let uiView = UIView()
        uiView.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
        uiView.layer.cornerRadius = 15
        return uiView
    } ()
    private let 팔로우_라벨 = {
        let label = UILabel()
        label.text = "팔로우"
        label.textColor = UIColor.white
        label.font = UIFont(name: "HelveticaNeue", size: 17)
        label.textAlignment = .left
        return label
    }()
    private let 팔로우_토글 = {
        let toggle = UISwitch()
        return toggle
    } ()
    private let 좋아요_백 = {
        let uiView = UIView()
        uiView.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
        uiView.layer.cornerRadius = 15
        return uiView
    } ()
    private let 좋아요_라벨 = {
        let label = UILabel()
        label.text = "좋아요"
        label.textColor = UIColor.white
        label.font = UIFont(name: "HelveticaNeue", size: 17)
        label.textAlignment = .left
        return label
    }()
    private let 좋아요_토글 = {
        let toggle = UISwitch()
        return toggle
    } () 
    private let 댓글_백 = {
        let uiView = UIView()
        uiView.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
        uiView.layer.cornerRadius = 15
        return uiView
    } ()
    private let 댓글_라벨 = {
        let label = UILabel()
        label.text = "댓글"
        label.textColor = UIColor.white
        label.font = UIFont(name: "HelveticaNeue", size: 17)
        label.textAlignment = .left
        return label
    }()
    private let 댓글_토글 = {
        let toggle = UISwitch()
        return toggle
    } () 
    private let 보관한전시오픈_백 = {
        let uiView = UIView()
        uiView.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
        uiView.layer.cornerRadius = 15
        return uiView
    } ()
    private let 보관한전시오픈_라벨 = {
        let label = UILabel()
        label.text = "보관한 전시 오픈"
        label.textColor = UIColor.white
        label.font = UIFont(name: "HelveticaNeue", size: 17)
        label.textAlignment = .left
        return label
    }()
    private let 보관한전시오픈_토글 = {
        let toggle = UISwitch()
        return toggle
    } () 
    private let 보관한전시마감임박_백 = {
        let uiView = UIView()
        uiView.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
        uiView.layer.cornerRadius = 15
        return uiView
    } ()
    private let 보관한전시마감임박_라벨 = {
        let label = UILabel()
        label.text = "보관한 전시 마감 임박"
        label.textColor = UIColor.white
        label.font = UIFont(name: "HelveticaNeue", size: 17)
        label.textAlignment = .left
        return label
    }()
    private let 보관한전시마감임박_토글 = {
        let toggle = UISwitch()
        return toggle
    } ()
    private let 도트공지사항및약관변경_백 = {
        let uiView = UIView()
        uiView.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
        uiView.layer.cornerRadius = 15
        return uiView
    } ()
    private let 도트공지사항및약관변경_라벨 = {
        let label = UILabel()
        label.text = "도트 공지사항 및 약관 변경"
        label.textColor = UIColor.white
        label.font = UIFont(name: "HelveticaNeue", size: 17)
        label.textAlignment = .left
        return label
    }()
    private let 도트공지사항및약관변경_토글 = {
        let toggle = UISwitch()
        return toggle
    } () 
    private let 이벤트관련정보_백 = {
        let uiView = UIView()
        uiView.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
        uiView.layer.cornerRadius = 15
        return uiView
    } ()
    private let 이벤트관련정보_라벨 = {
        let label = UILabel()
        label.text = "이벤트 관련 정보"
        label.textColor = UIColor.white
        label.font = UIFont(name: "HelveticaNeue", size: 17)
        label.textAlignment = .left
        return label
    }()
    private let 이벤트관련정보_토글 = {
        let toggle = UISwitch()
        return toggle
    } ()
   
   
    override func viewDidLoad() {
        view.backgroundColor = .black
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 0.3
        tabBarController?.tabBar.isHidden = true

        UI레이아웃()
        버튼_클릭()
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
   
}


extension 알림설정_화면{
    
    private func UI레이아웃 () {
        view.addSubview(뒤로가기_버튼)
        view.addSubview(페이지_제목)
        
        view.addSubview(팔로우_백)
        view.addSubview(팔로우_라벨)
        view.addSubview(팔로우_토글)
        
        view.addSubview(좋아요_백)
        view.addSubview(좋아요_라벨)
        view.addSubview(좋아요_토글)
        
        view.addSubview(댓글_백)
        view.addSubview(댓글_라벨)
        view.addSubview(댓글_토글)
        
        view.addSubview(보관한전시오픈_백)
        view.addSubview(보관한전시오픈_라벨)
        view.addSubview(보관한전시오픈_토글)
        
        view.addSubview(보관한전시마감임박_백)
        view.addSubview(보관한전시마감임박_라벨)
        view.addSubview(보관한전시마감임박_토글)
        
        view.addSubview(도트공지사항및약관변경_백)
        view.addSubview(도트공지사항및약관변경_라벨)
        view.addSubview(도트공지사항및약관변경_토글)
        
        view.addSubview(이벤트관련정보_백)
        view.addSubview(이벤트관련정보_라벨)
        view.addSubview(이벤트관련정보_토글)
       
        
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
        
        팔로우_백.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(145)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.height.equalTo(44)
            
        }
        팔로우_라벨.snp.makeConstraints { make in
            make.centerY.equalTo(팔로우_백.snp.centerY)
            make.leading.equalTo(팔로우_백.snp.leading).offset(16)
        }
        팔로우_토글.snp.makeConstraints { make in
            make.centerY.equalTo(팔로우_백.snp.centerY)
            make.trailing.equalTo(팔로우_백.snp.trailing).offset(-16)
        }
        
        좋아요_백.snp.makeConstraints { make in
            make.top.equalTo(팔로우_백.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.height.equalTo(44)
            
        }
        좋아요_라벨.snp.makeConstraints { make in
            make.centerY.equalTo(좋아요_백.snp.centerY)
            make.leading.equalTo(좋아요_백.snp.leading).offset(16)
        }
        좋아요_토글.snp.makeConstraints { make in
            make.centerY.equalTo(좋아요_백.snp.centerY)
            make.trailing.equalTo(좋아요_백.snp.trailing).offset(-16)
        }
        댓글_백.snp.makeConstraints { make in
            make.top.equalTo(좋아요_백.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.height.equalTo(44)
            
        }
        댓글_라벨.snp.makeConstraints { make in
            make.centerY.equalTo(댓글_백.snp.centerY)
            make.leading.equalTo(댓글_백.snp.leading).offset(16)
        }
        댓글_토글.snp.makeConstraints { make in
            make.centerY.equalTo(댓글_백.snp.centerY)
            make.trailing.equalTo(댓글_백.snp.trailing).offset(-16)
        }
        보관한전시오픈_백.snp.makeConstraints { make in
            make.top.equalTo(댓글_백.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.height.equalTo(44)
            
        }
        보관한전시오픈_라벨.snp.makeConstraints { make in
            make.centerY.equalTo(보관한전시오픈_백.snp.centerY)
            make.leading.equalTo(보관한전시오픈_백.snp.leading).offset(16)
        }
        보관한전시오픈_토글.snp.makeConstraints { make in
            make.centerY.equalTo(보관한전시오픈_백.snp.centerY)
            make.trailing.equalTo(보관한전시오픈_백.snp.trailing).offset(-16)
        }
        보관한전시마감임박_백.snp.makeConstraints { make in
            make.top.equalTo(보관한전시오픈_백.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.height.equalTo(44)
            
        }
        보관한전시마감임박_라벨.snp.makeConstraints { make in
            make.centerY.equalTo(보관한전시마감임박_백.snp.centerY)
            make.leading.equalTo(보관한전시마감임박_백.snp.leading).offset(16)
        }
        보관한전시마감임박_토글.snp.makeConstraints { make in
            make.centerY.equalTo(보관한전시마감임박_백.snp.centerY)
            make.trailing.equalTo(보관한전시마감임박_백.snp.trailing).offset(-16)
        }
        
        도트공지사항및약관변경_백.snp.makeConstraints { make in
            make.top.equalTo(보관한전시마감임박_백.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.height.equalTo(44)
            
        }
        도트공지사항및약관변경_라벨.snp.makeConstraints { make in
            make.centerY.equalTo(도트공지사항및약관변경_백.snp.centerY)
            make.leading.equalTo(도트공지사항및약관변경_백.snp.leading).offset(16)
        }
        도트공지사항및약관변경_토글.snp.makeConstraints { make in
            make.centerY.equalTo(도트공지사항및약관변경_백.snp.centerY)
            make.trailing.equalTo(도트공지사항및약관변경_백.snp.trailing).offset(-16)
        }
        
        이벤트관련정보_백.snp.makeConstraints { make in
            make.top.equalTo(도트공지사항및약관변경_백.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.height.equalTo(44)
        }
        이벤트관련정보_라벨.snp.makeConstraints { make in
            make.centerY.equalTo(이벤트관련정보_백.snp.centerY)
            make.leading.equalTo(이벤트관련정보_백.snp.leading).offset(16)
        }
        이벤트관련정보_토글.snp.makeConstraints { make in
            make.centerY.equalTo(이벤트관련정보_백.snp.centerY)
            make.trailing.equalTo(이벤트관련정보_백.snp.trailing).offset(-16)
        }
        
    }
    private func 버튼_클릭() {
        뒤로가기_버튼.addTarget(self, action: #selector(뒤로가기_버튼_클릭), for: .touchUpInside)
    }
    @objc private func 뒤로가기_버튼_클릭() {
        navigationController?.popViewController(animated: true)
    }
}
