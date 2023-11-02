
import UIKit
import PanModal
import SnapKit
import RxSwift
import RxCocoa

class PopularReviewDetailPanModal : UIViewController {
    
    private let 상단_블록 = {
        let uiView = UIView()
        uiView.backgroundColor = UIColor.darkGray.withAlphaComponent(0.8)
        return uiView
    } ()
    private let 판모달_댓글_테이블뷰 = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor.darkGray.withAlphaComponent(0.8)
        tableView.isUserInteractionEnabled = true
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Ui레이아웃()
        테이블뷰_레이아웃()
    }
    
    func Ui레이아웃 () {
        view.addSubview(상단_블록)
        상단_블록.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
    }
    func 테이블뷰_레이아웃 () {
        view.addSubview(판모달_댓글_테이블뷰)
        판모달_댓글_테이블뷰.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(63)
            make.bottom.equalToSuperview().offset(-90)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
        }
    }
    
}





extension PopularReviewDetailPanModal : UITabBarDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PopularReviewDetailPanModalCell", for: indexPath) as! PopularReviewDetailPanModalCell
        return cell
    }
    
}




extension PopularReviewDetailPanModal : PanModalPresentable {
    
    var panScrollable: UIScrollView? {
        return nil
    }
    
    var longFormHeight: PanModalHeight {
        return .contentHeight(440)
        
    }
    var panModalCornerRadius: CGFloat {
        return 20
    }
    
    var panModalBackgroundColor: UIColor {
        return UIColor.clear
    }
    var allowsTapToDismiss: Bool {
        return true
    }
    
    var allowsDragToDismiss: Bool {
        return true
    }
    func shouldRespond(to panModalGestureRecognizer: UIPanGestureRecognizer) -> Bool {
        return true
    }
}

