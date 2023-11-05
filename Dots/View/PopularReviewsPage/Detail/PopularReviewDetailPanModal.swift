import UIKit
import PanModal
import SnapKit
import RxSwift
import RxCocoa

class PopularReviewDetailPanModal : UIViewController, UITableViewDelegate {
    
    private let 블러_블록 = {
        let uiView = UIView()
        uiView.backgroundColor = .black.withAlphaComponent(0.8)
        uiView.layer.cornerRadius = 30
        return uiView
    } ()
    
    private let 판모달_댓글_테이블뷰 = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor.clear
        tableView.isUserInteractionEnabled = true
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        
        return tableView
    }()
    private let 댓글_작성자_이미지 = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "cabanel")
        imageView.layer.cornerRadius = 25
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    } ()
    private let 댓글_입력_블록 = {
      let uiView = UIView()
        uiView.backgroundColor = .darkGray.withAlphaComponent(0.8)
        uiView.layer.cornerRadius = 27
        return uiView
    } ()
    private let 판모달_댓글_입력 = {
        let textField = UITextField ()
        textField.attributedPlaceholder = NSAttributedString(string: "댓글작성...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.textColor = UIColor.white
        textField.font = UIFont(name: "HelveticaNeue", size: 16)
        textField.layer.cornerRadius = 25
        //textField.becomeFirstResponder()
        return textField
    } ()
    private let 댓글_버튼 = {
            let button = UIButton()
        button.setImage(UIImage(named: "댓글버튼"), for: .normal)
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 24
        button.isSelected = !button.isSelected
        return button
    } ()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clear
        블록_레이아웃()
        let gradientLayer = CAGradientLayer()
               gradientLayer.frame = view.bounds
               gradientLayer.colors = [UIColor(white: 0, alpha: 0.8).cgColor, UIColor(white: 0, alpha: 0).cgColor]
               gradientLayer.locations = [0.0, 1.0]

               view.layer.insertSublayer(gradientLayer, at: 0)
        let blurEffect = UIBlurEffect(style: .systemThickMaterialDark)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.layer.cornerRadius = 25
        visualEffectView.alpha = 0.6
        visualEffectView.layer.masksToBounds = true
        visualEffectView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(visualEffectView)
        visualEffectView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        테이블뷰_레이아웃()
        UI레이아웃()
        
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
        블러_블록.addSubview(댓글_입력_블록)
        댓글_입력_블록.snp.makeConstraints { make in
//            make.height.equalTo(20)
//            make.width.equalTo(200)
//            make.leading.equalTo(판모달_댓글_테이블뷰).offset(5)
//            make.trailing.equalToSuperview().offset(-85)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-90)
//            make.top.equalToSuperview().offset(400)
            make.height.equalTo(52)
            make.bottom.equalToSuperview().offset(-20)
        }
        
    }
    
    func UI레이아웃 () {
        view.addSubview(댓글_작성자_이미지)
        댓글_작성자_이미지.snp.makeConstraints { make in
            make.top.equalTo(댓글_입력_블록.snp.top)
//            make.bottom.equalTo(댓글_입력_블록.snp.bottom)
            make.leading.equalTo(댓글_입력_블록.snp.leading)
            make.size.equalTo(52)
           
        }
        view.addSubview(판모달_댓글_입력)
        판모달_댓글_입력.snp.makeConstraints { make in
            make.top.equalTo(댓글_입력_블록.snp.top)
            make.bottom.equalTo(댓글_입력_블록.snp.bottom)
            make.leading.equalTo(댓글_입력_블록.snp.leading).offset(60)
            make.trailing.equalTo(댓글_입력_블록.snp.trailing).offset(0)
        }
        view.addSubview(댓글_버튼)
        댓글_버튼.snp.makeConstraints { make in
            make.top.equalTo(댓글_입력_블록.snp.top)
            make.bottom.equalTo(댓글_입력_블록.snp.bottom)
            make.leading.equalTo(댓글_입력_블록.snp.trailing).offset(10)
            make.trailing.equalTo(판모달_댓글_테이블뷰.snp.trailing).offset(-17)
        }
        
    }
    
    func 테이블뷰_레이아웃 () {
        view.addSubview(판모달_댓글_테이블뷰)
        판모달_댓글_테이블뷰.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(63)
            make.bottom.equalToSuperview().offset(-90)
            make.leading.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().offset(-18)
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
    var shortFormHeight: PanModalHeight {
        return .contentHeight(440)
    }
    var longFormHeight: PanModalHeight {
        return .contentHeight(770)
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

