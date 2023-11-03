
import UIKit
import PanModal
import SnapKit
import RxSwift
import RxCocoa

class PopularReviewDetailPanModal : UIViewController, UITableViewDelegate {
    
    private let 블러_블록 = {
        let uiView = UIView()
        uiView.backgroundColor = .black.withAlphaComponent(0.7)
        uiView.layer.cornerRadius = 30
        return uiView
    } ()
    private let 판모달_댓글_테이블뷰 = {
        let tableView = UITableView()
        //      tableView.backgroundColor = UIColor.darkGray.withAlphaComponent(0.6)
        tableView.backgroundColor = UIColor.clear
        tableView.isUserInteractionEnabled = true
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    private let 판모달_댓글_입력 = {
        let textField = UITextField ()
        textField.placeholder = "댓글작성..."
        textField.textColor = UIColor.gray
        textField.backgroundColor = UIColor.clear
        textField.textColor = UIColor.white
        textField.font = UIFont(name: "HelveticaNeue", size: 16)
        textField.layer.cornerRadius = 20
        //textField.becomeFirstResponder()
        return textField
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clear
        블록_레이아웃()
        let gradientLayer = CAGradientLayer()
               gradientLayer.frame = view.bounds
               gradientLayer.colors = [UIColor(white: 0, alpha: 0.8).cgColor, UIColor(white: 0, alpha: 0).cgColor]
               gradientLayer.locations = [0.0, 1.0]

               // 그라디언트 레이어를 추가
               view.layer.insertSublayer(gradientLayer, at: 0)
        let blurEffect = UIBlurEffect(style: .systemThickMaterialDark)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.layer.cornerRadius = 25
        //visualEffectView.backgroundColor = UIColor(white: 0.5, alpha: 0.8)  // 예시로 0.5의 투명도로 설정
        visualEffectView.alpha = 0.6  // 예시로 0.6으로 조절

        visualEffectView.layer.masksToBounds = true
        visualEffectView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(visualEffectView)
        visualEffectView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        테이블뷰_레이아웃()
        댓글입력_레이아웃()
        
        판모달_댓글_테이블뷰.delegate = self
        판모달_댓글_테이블뷰.dataSource = self
        판모달_댓글_테이블뷰.register(PopularReviewDetailPanModalCell.self, forCellReuseIdentifier: "PopularReviewDetailPanModalCell")
    }
    
    func 블록_레이아웃 () {
        view.addSubview(블러_블록)
        블러_블록.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
        }
    }
    func 댓글입력_레이아웃 () {
        view.addSubview(판모달_댓글_입력)
        판모달_댓글_입력.snp.makeConstraints { make in
            make.top.equalTo(판모달_댓글_테이블뷰.snp.bottom).offset(10)
            make.leading.equalTo(판모달_댓글_테이블뷰.snp.leading).offset(5)
            make.trailing.equalTo(판모달_댓글_테이블뷰.snp.trailing).offset(-5)
            make.bottom.equalToSuperview().offset(-20)
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
        15
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
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
    var topOffset: CGFloat {
        return 100
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

