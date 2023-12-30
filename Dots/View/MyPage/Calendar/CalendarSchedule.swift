import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import SDWebImage


class 캘린더_스케쥴_등록_모달 : UIViewController {
    
    var 셀_데이터_배열 = 셀_배열() {
        didSet {
            DispatchQueue.main.async {
                self.캘린더_전시_테이블뷰.reloadData()
            }
        }
    }
    
    let 손잡이 = {
        let uiView = UIView()
        uiView.backgroundColor = .darkGray
        uiView.layer.cornerRadius = 5
        uiView.layer.borderWidth = 0.5
        return uiView
    } ()
    let 페이지_제목 = {
        let label = UILabel()
        label.text = "다녀온 전시 기록"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    lazy var 캘린더_전시_테이블뷰 = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.layer.cornerRadius = 10
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(캘린더_스케쥴_등록_셀.self, forCellReuseIdentifier: "캘린더_스케쥴_등록_셀")
        return tableView
    }()
    
    
    
    override func viewDidLoad() {
        
        view.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
        view.layer.borderWidth = 0.3
        
        UI레이아웃()
        캘린더_전시_테이블뷰.delegate = self
        캘린더_전시_테이블뷰.dataSource = self
        캘린더_전시_테이블뷰.register(캘린더_스케쥴_등록_셀.self, forCellReuseIdentifier: "캘린더_스케쥴_등록_셀")
        
        데이터가져오기및UI업데이트()
        
    }
    deinit {
        listener?.remove()
    }
}

var 셀_데이터_배열 = 셀_배열()
var listener: ListenerRegistration?

struct 셀_데이터 {
    var 포스터이미지URL: String
    var 전시명: String
    var 장소: String
    var 방문날짜: String
    var 리뷰문서ID: String
    var 포스터스문서ID: String
    
    init(포스터이미지URL: String, 전시명: String, 장소: String, 방문날짜: String, 리뷰문서ID: String,포스터스문서ID: String) {
        self.포스터이미지URL = 포스터이미지URL
        self.전시명 = 전시명
        self.장소 = 장소
        self.방문날짜 = 방문날짜
        self.리뷰문서ID = 리뷰문서ID
        self.포스터스문서ID = 포스터스문서ID
        
    }
}

struct 셀_배열 {
    var 셀_데이터_배열: [셀_데이터]
    
    init() {
        self.셀_데이터_배열 = [
            
        ]
    }
}


