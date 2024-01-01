import UIKit
import GoogleSignIn
import FirebaseAuth
import FirebaseFirestore
import SnapKit

struct 설정아이템 {
    let title: String
    var isSwitchOn: Bool
    let action: () -> Void
}
class 마이페이지_설정_페이지 : UIViewController, UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    
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
        button.isSelected = !button.isSelected
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        return button
    } ()
    
    let 설정_테이블뷰 = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.layer.cornerRadius = 10
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    var 설정아이템들: [[설정아이템]] = []
    
    
    override func viewDidLoad() {
        view.backgroundColor = .black
        // 테이블 뷰 설정
                설정_테이블뷰.separatorStyle = .none // 구분선 숨기기
                설정_테이블뷰.backgroundColor = .clear // 배경색 투명하게 설정
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
}



