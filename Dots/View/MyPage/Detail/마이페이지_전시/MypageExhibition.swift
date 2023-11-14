import UIKit

class 마이페이지_전시 : UIViewController {
    let 뒤로가기_버튼 = {
        let button = UIButton()
        button.setImage(UIImage(named: "loginBack"), for: .selected)
        button.setImage(UIImage(named: ""), for: .normal)
        button.isSelected = !button.isSelected
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        return button
    } ()
    let 페이지_제목 = {
        let label = UILabel()
        label.text = "전시"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    let 마이페이지_전시_카운팅 = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor.darkGray
        label.textAlignment = .right
        return label
    } ()
    
    lazy var 마이페이지_전시_컬렉션뷰 = {
          let layout = UICollectionViewFlowLayout()
          let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
          layout.minimumLineSpacing = 8
          layout.minimumInteritemSpacing = 1
          layout.sectionInset = UIEdgeInsets(top:5 , left: 0, bottom: 5, right: 0)
          
          collectionView.backgroundColor = .black
          collectionView.layer.cornerRadius = 10
          collectionView.showsVerticalScrollIndicator = false
          collectionView.decelerationRate = UIScrollView.DecelerationRate.normal
          return collectionView
      }()

override func viewDidLoad() {
    view.backgroundColor = .black
    navigationItem.hidesBackButton = true
    navigationController?.isNavigationBarHidden = true
    UI레이아웃()
    버튼_클릭()
    마이페이지_전시_컬렉션뷰.dataSource = self
    마이페이지_전시_컬렉션뷰.delegate = self
    마이페이지_전시_컬렉션뷰.register(마이페이지_전시_셀.self, forCellWithReuseIdentifier: "마이페이지_전시_셀")
}

func UI레이아웃() {
    view.addSubview(뒤로가기_버튼)
    view.addSubview(페이지_제목)
    view.addSubview(마이페이지_전시_컬렉션뷰)
    뒤로가기_버튼.snp.makeConstraints { make in
        make.centerY.equalTo(페이지_제목.snp.centerY)
        make.leading.equalToSuperview().offset(16)
        make.size.equalTo(40)
    }
    페이지_제목.snp.makeConstraints { make in
        
        make.top.equalToSuperview().offset(60)
        make.centerX.equalToSuperview()
    }
    마이페이지_전시_컬렉션뷰.snp.makeConstraints { make in
        make.top.equalToSuperview().offset(170)
        make.leading.equalToSuperview().offset(17)
        make.trailing.equalToSuperview().offset(-17)
        make.bottom.equalToSuperview().offset(-5)
    }
}

    private func 버튼_클릭() {
        뒤로가기_버튼.addTarget(self, action: #selector(뒤로가기_버튼_클릭), for: .touchUpInside)

    }
    @objc func 뒤로가기_버튼_클릭() {
        navigationController?.popViewController(animated: true)
    }
}



extension 마이페이지_전시 : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "마이페이지_전시_셀", for: indexPath) as? 마이페이지_전시_셀 else {
            return UICollectionViewCell()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width * 0.49
        let height = collectionView.frame.height * 0.4
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//       let 마이페이지_티켓_화면 = MyPageTicket()
//        self.navigationController?.pushViewController(마이페이지_티켓_화면, animated: true)
    }
}
