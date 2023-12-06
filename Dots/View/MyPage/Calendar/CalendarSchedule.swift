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
    
    lazy var 캘린더_전시_컬렉션뷰 = {
          let layout = UICollectionViewFlowLayout()
          let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
          layout.minimumLineSpacing = 20
          layout.minimumInteritemSpacing = 0
          layout.sectionInset = UIEdgeInsets(top:5 , left: 0, bottom: 5, right: 0)
          
          collectionView.backgroundColor = .clear
          collectionView.layer.cornerRadius = 10
          collectionView.showsVerticalScrollIndicator = false
          collectionView.decelerationRate = UIScrollView.DecelerationRate.normal
          return collectionView
      }()
    
    let 수정_뷰 = {
    let view = UIView()
        view.backgroundColor = UIColor(named: "neon")
        view.layer.cornerRadius = 15
       return view
        
    }()
    
    override func viewDidLoad() {

        view.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)

        view.layer.borderWidth = 0.3
        
        UI레이아웃()
        캘린더_전시_컬렉션뷰.delegate = self
        캘린더_전시_컬렉션뷰.dataSource = self
        캘린더_전시_컬렉션뷰.register(캘린더_스케쥴_등록_셀.self, forCellWithReuseIdentifier: "캘린더_스케쥴_등록_셀")

    }
    
}


extension 캘린더_스케쥴_등록_모달 {
    
    private func UI레이아웃 () {
        view.addSubview(손잡이)
        view.addSubview(페이지_제목)
        view.addSubview(캘린더_전시_컬렉션뷰)

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
        캘린더_전시_컬렉션뷰.snp.makeConstraints { make in
            make.top.equalTo(페이지_제목.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
            make.bottom.equalToSuperview().offset(-5)
        }
    }
}

extension 캘린더_스케쥴_등록_모달 : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "캘린더_스케쥴_등록_셀", for: indexPath) as? 캘린더_스케쥴_등록_셀 else {
            return UICollectionViewCell()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width * 1
        let height = collectionView.frame.height * 0.35
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           if let cell = collectionView.cellForItem(at: indexPath) as? 캘린더_스케쥴_등록_셀 {
               if cell.transform.isIdentity {
                   cell.셀_클릭_애니메이션_on()
               } else {
                   cell.셀_클릭_애니메이션_off()
               }
           }
       }
    
    
}

