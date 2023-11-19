import UIKit

class 캘린더_스케쥴_등록_모달 : UIViewController {
    private let 백 = {
        let uiView = UIView()
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        gradientLayer.colors = [
            UIColor.black.withAlphaComponent(0.9).cgColor,
            UIColor.black.withAlphaComponent(0.9).cgColor
        ]
        gradientLayer.locations = [0, 1]
        uiView.layer.addSublayer(gradientLayer)
        return uiView
    } ()
    private let 손잡이 = {
        let uiView = UIView()
        uiView.backgroundColor = .white
        uiView.layer.cornerRadius = 5
        uiView.layer.borderColor = UIColor(named: "neon")?.cgColor
        uiView.layer.borderWidth = 0.5
        return uiView
    } ()
    private let 페이지_제목 = {
        let label = UILabel()
        label.text = "전시 방문 일정 등록"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    lazy var 캘린더_전시_컬렉션뷰 = {
          let layout = UICollectionViewFlowLayout()
          let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
          layout.minimumLineSpacing = 20
          layout.minimumInteritemSpacing = 12
          layout.sectionInset = UIEdgeInsets(top:5 , left: 0, bottom: 5, right: 0)
          
          collectionView.backgroundColor = .black
          collectionView.layer.cornerRadius = 10
          collectionView.showsVerticalScrollIndicator = false
          collectionView.decelerationRate = UIScrollView.DecelerationRate.normal
          return collectionView
      }()
    override func viewDidLoad() {
        view.backgroundColor = .clear
        view.layer.cornerRadius = 20
        view.layer.borderColor = UIColor(named: "neon")?.cgColor
        view.layer.borderWidth = 0.3
        
        UI레이아웃()
    }
}


extension 캘린더_스케쥴_등록_모달 {
    
    private func UI레이아웃 () {
        view.addSubview(백)
        view.addSubview(손잡이)
        view.addSubview(페이지_제목)
        백.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
            
        }
        손잡이.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(5)
            make.width.equalTo(40)
        }
        페이지_제목.snp.makeConstraints { make in
            make.top.equalTo(손잡이.snp.bottom).offset(25)
            make.centerX.equalToSuperview()
        }
    }
}