import UIKit

class 캘린더_스케쥴_등록_모달 : UIViewController {
    
    private let 손잡이 = {
        let uiView = UIView()
        uiView.backgroundColor = .darkGray
        uiView.layer.cornerRadius = 5
        uiView.layer.borderWidth = 0.5
        return uiView
    } ()
    private let 페이지_제목 = {
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
        
    }
}


extension 캘린더_스케쥴_등록_모달 {
    
    private func UI레이아웃 () {
        view.addSubview(손잡이)
        view.addSubview(페이지_제목)
        view.addSubview(캘린더_전시_테이블뷰)
        
        손잡이.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
            make.height.equalTo(5)
            make.width.equalTo(40)
        }
        페이지_제목.snp.makeConstraints { make in
            make.top.equalTo(손잡이.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        캘린더_전시_테이블뷰.snp.makeConstraints { make in
            make.top.equalTo(페이지_제목.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
            make.bottom.equalToSuperview().offset(-5)
        }
    }
}
extension 캘린더_스케쥴_등록_모달: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "캘린더_스케쥴_등록_셀", for: indexPath) as? 캘린더_스케쥴_등록_셀 else {
            return UITableViewCell()
        }
        if cell.isSelected {
             cell.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
         } else {
             cell.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
         }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                tableView.cellForRow(at: indexPath)?.selectionStyle = .none
                print("셀클릭")
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let 수정 = UIContextualAction(style: .normal, title: nil) { (_, _, completionHandler) in
            
            print("수정 버튼 클릭")
            
            if let 현제모달 = self.findViewController() {
                현제모달.dismiss(animated: true) {
                         let 새모달 = 켈린더_수정_뷰컨트롤러()
                    새모달.modalPresentationStyle = .fullScreen
                    현제모달.present(새모달, animated: false, completion: nil)
                     }
                 }

            completionHandler(true)
        }
        수정.image = UIImage(named: "내후기edit")
        수정.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
        
        
        let 삭제 = UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in
            print("삭제 버튼 클릭")
            
            if let 현제모달 = self.findViewController() {
                현제모달.dismiss(animated: true) {
                         let 새모달 = 켈린더_삭제_뷰컨트롤러()
                    새모달.modalPresentationStyle = .fullScreen
                    현제모달.present(새모달, animated: false, completion: nil)
                    
                     }
                 }
            completionHandler(true)
        }
        삭제.image = UIImage(named: "내후기delete")
        삭제.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
        
        
        let configuration = UISwipeActionsConfiguration(actions: [삭제, 수정])
        수정.accessibilityValue = "수정 버튼"
            삭제.accessibilityValue = "삭제 버튼"
            configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        tableView.separatorStyle = .none
    }
}


extension 캘린더_스케쥴_등록_모달 {
    func findViewController() -> UIViewController? {
        var responder: UIResponder? = self
        while let nextResponder = responder?.next {
            responder = nextResponder
            if let viewController = responder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
    
    
}
