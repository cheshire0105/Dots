import UIKit

class 알림설정_화면 : UIViewController, UIGestureRecognizerDelegate {
     let 뒤로가기_버튼 = {
        let button = UIButton()
        button.setImage(UIImage(named: "loginBack"), for: .selected)
        button.isSelected = !button.isSelected
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        return button
    } ()
    
     let 페이지_제목 = {
        let label = UILabel()
        label.text = "알림 설정"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
     let 팔로우_백 = {
        let uiView = UIView()
        uiView.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
        uiView.layer.cornerRadius = 15
        return uiView
    } ()
     let 팔로우_라벨 = {
        let label = UILabel()
        label.text = "팔로우"
        label.textColor = UIColor.white
        label.font = UIFont(name: "HelveticaNeue", size: 17)
        label.textAlignment = .left
        return label
    }()
     let 팔로우_토글 = {
        let toggle = UISwitch()
        return toggle
    } ()
     let 좋아요_백 = {
        let uiView = UIView()
        uiView.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
        uiView.layer.cornerRadius = 15
        return uiView
    } ()
     let 좋아요_라벨 = {
        let label = UILabel()
        label.text = "좋아요"
        label.textColor = UIColor.white
        label.font = UIFont(name: "HelveticaNeue", size: 17)
        label.textAlignment = .left
        return label
    }()
     let 좋아요_토글 = {
        let toggle = UISwitch()
        return toggle
    } () 
     let 댓글_백 = {
        let uiView = UIView()
        uiView.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
        uiView.layer.cornerRadius = 15
        return uiView
    } ()
     let 댓글_라벨 = {
        let label = UILabel()
        label.text = "댓글"
        label.textColor = UIColor.white
        label.font = UIFont(name: "HelveticaNeue", size: 17)
        label.textAlignment = .left
        return label
    }()
     let 댓글_토글 = {
        let toggle = UISwitch()
        return toggle
    } () 
     let 보관한전시오픈_백 = {
        let uiView = UIView()
        uiView.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
        uiView.layer.cornerRadius = 15
        return uiView
    } ()
     let 보관한전시오픈_라벨 = {
        let label = UILabel()
        label.text = "보관한 전시 오픈"
        label.textColor = UIColor.white
        label.font = UIFont(name: "HelveticaNeue", size: 17)
        label.textAlignment = .left
        return label
    }()
     let 보관한전시오픈_토글 = {
        let toggle = UISwitch()
        return toggle
    } () 
     let 보관한전시마감임박_백 = {
        let uiView = UIView()
        uiView.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
        uiView.layer.cornerRadius = 15
        return uiView
    } ()
     let 보관한전시마감임박_라벨 = {
        let label = UILabel()
        label.text = "보관한 전시 마감 임박"
        label.textColor = UIColor.white
        label.font = UIFont(name: "HelveticaNeue", size: 17)
        label.textAlignment = .left
        return label
    }()
     let 보관한전시마감임박_토글 = {
        let toggle = UISwitch()
        return toggle
    } ()
     let 도트공지사항및약관변경_백 = {
        let uiView = UIView()
        uiView.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
        uiView.layer.cornerRadius = 15
        return uiView
    } ()
     let 도트공지사항및약관변경_라벨 = {
        let label = UILabel()
        label.text = "도트 공지사항 및 약관 변경"
        label.textColor = UIColor.white
        label.font = UIFont(name: "HelveticaNeue", size: 17)
        label.textAlignment = .left
        return label
    }()
     let 도트공지사항및약관변경_토글 = {
        let toggle = UISwitch()
        return toggle
    } () 
     let 이벤트관련정보_백 = {
        let uiView = UIView()
        uiView.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
        uiView.layer.cornerRadius = 15
        return uiView
    } ()
     let 이벤트관련정보_라벨 = {
        let label = UILabel()
        label.text = "이벤트 관련 정보"
        label.textColor = UIColor.white
        label.font = UIFont(name: "HelveticaNeue", size: 17)
        label.textAlignment = .left
        return label
    }()
     let 이벤트관련정보_토글 = {
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
