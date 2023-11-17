import UIKit

class 마이페이지_보관함 : UIViewController {
    let 전시_컬렉션뷰 = 마이페이지_전시().마이페이지_전시_컬렉션뷰
    let 리뷰_컬렉션뷰 = 마이페이지_리뷰().마이페이지_리뷰_컬렉션뷰
    
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
        label.text = "보관함"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    let 세그먼트_컨트롤: UISegmentedControl = {
        let 세그먼트_아이탬 = ["전시", "미술관", "작가", "리뷰"]
        let 세그먼트 = UISegmentedControl(items: 세그먼트_아이탬)
        세그먼트.selectedSegmentIndex = 0
        세그먼트.setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        세그먼트.backgroundColor = .black
        세그먼트.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.lightGray], for: .normal)
        세그먼트.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        세그먼트.selectedSegmentTintColor = UIColor.lightGray
        return 세그먼트
    }()
    
    lazy var 보관함_컬렉션뷰 = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top:5 , left: 0, bottom: 5, right: 0)
        
        collectionView.backgroundColor = .black
        collectionView.layer.cornerRadius = 10
        collectionView.showsVerticalScrollIndicator = false
        collectionView.decelerationRate = UIScrollView.DecelerationRate.normal
        return collectionView
    } ()
    override func viewWillAppear(_ animated: Bool) {
        if let glassTabBar = tabBarController as? GlassTabBar {
            glassTabBar.customTabBarView.isHidden = true
        }
    }
    override func viewDidLoad() {
        view.backgroundColor = .black
        navigationItem.hidesBackButton = true
        navigationController?.isNavigationBarHidden = true
        UI레이아웃()
        버튼_클릭()
        보관함_컬렉션뷰.delegate = self
        보관함_컬렉션뷰.dataSource = self
        세그먼트_아이탬_클릭()
    }
    
    func UI레이아웃() {
        view.addSubview(뒤로가기_버튼)
        view.addSubview(페이지_제목)
        view.addSubview(세그먼트_컨트롤)
        뒤로가기_버튼.snp.makeConstraints { make in
            make.centerY.equalTo(페이지_제목.snp.centerY)
            make.leading.equalToSuperview().offset(16)
            make.size.equalTo(40)
        }
        페이지_제목.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.centerX.equalToSuperview()
        }
        세그먼트_컨트롤.snp.makeConstraints { make in
            make.top.equalTo(페이지_제목.snp.bottom).offset(45)
//            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-70)
        }
        
    }
    func 보관함_컬렉션뷰_레이아웃 () {
        view.addSubview(보관함_컬렉션뷰)
        보관함_컬렉션뷰.snp.makeConstraints { make in
            make.top.equalTo(세그먼트_컨트롤.snp.bottom).offset(40)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
    private func 버튼_클릭() {
        뒤로가기_버튼.addTarget(self, action: #selector(뒤로가기_버튼_클릭), for: .touchUpInside)
        세그먼트_컨트롤.addTarget(self, action: #selector(세그먼트_아이탬_클릭), for: .valueChanged)
        
    }
    @objc func 뒤로가기_버튼_클릭() {
        navigationController?.popViewController(animated: true)
    }
    @objc func 세그먼트_아이탬_클릭() {
        let 세그먼트_아이탬 = 세그먼트_컨트롤.selectedSegmentIndex
        print("선택된 세그먼트 아이탬 : \(세그먼트_아이탬 + 1)")
        
        switch 세그먼트_아이탬 {
        case 0:
            보관함_컬렉션뷰.register(보관함_전시_셀.self, forCellWithReuseIdentifier: "보관함_전시_셀")
            보관함_컬렉션뷰_레이아웃 ()
            보관함_컬렉션뷰.reloadData()
            break
        case 1:
            보관함_컬렉션뷰.register(보관함_미술관_셀.self, forCellWithReuseIdentifier: "보관함_미술관_셀")
            보관함_컬렉션뷰_레이아웃 ()
            보관함_컬렉션뷰.reloadData()

            break
        case 2:
            보관함_컬렉션뷰.register(보관함_아티스트_셀.self, forCellWithReuseIdentifier: "보관함_아티스트_셀")
            보관함_컬렉션뷰_레이아웃 ()
            보관함_컬렉션뷰.reloadData()

            break
        case 3:
            보관함_컬렉션뷰.register(보관함_리뷰_셀.self, forCellWithReuseIdentifier: "보관함_리뷰_셀")
            보관함_컬렉션뷰_레이아웃 ()
            보관함_컬렉션뷰.reloadData()

            break
        default:
            break
        }
    }
}

extension 마이페이지_보관함 : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch 세그먼트_컨트롤.selectedSegmentIndex {
        case 0:
            return 10
        case 1:
            return 10
        case 2:
            return 10
        case 3:
            return 10
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch 세그먼트_컨트롤.selectedSegmentIndex {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "보관함_전시_셀", for: indexPath) as! 보관함_전시_셀
            
            
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "보관함_미술관_셀", for: indexPath) as! 보관함_미술관_셀
            
            
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "보관함_아티스트_셀", for: indexPath) as! 보관함_아티스트_셀
            
            
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "보관함_리뷰_셀", for: indexPath) as! 보관함_리뷰_셀
            
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch 세그먼트_컨트롤.selectedSegmentIndex {
        case 0:
            
            return 12
        case 1:
          
            return 10
        case 2:
           
            return 10
        case 3:
           
            return 0
        default:
            break
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch 세그먼트_컨트롤.selectedSegmentIndex {
        case 0:
            
            return 15
        case 1:
          
            return 5
        case 2:
           
            return 5
        case 3:
           
            return 15
        default:
            break
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch 세그먼트_컨트롤.selectedSegmentIndex {
        case 0:
            let width = collectionView.frame.width * 0.49 - 12
            let height = collectionView.frame.height * 0.4
            return CGSize(width: width, height: height)
        case 1:
            let width = collectionView.frame.width * 0.33 - 10
            let height = collectionView.frame.height * 0.22
            return CGSize(width: width, height: height)
        case 2:
            let width = collectionView.frame.width * 0.33 - 10
            let height = collectionView.frame.height * 0.22
            return CGSize(width: width, height: height)
        case 3:
            let width = collectionView.frame.width * 1
            let height = collectionView.frame.height * 0.35
            return CGSize(width: width, height: height)
        default:
            break
        }
        return CGSize(width: 0, height: 0)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //       let 마이페이지_티켓_화면 = MyPageTicket()
        //        self.navigationController?.pushViewController(마이페이지_티켓_화면, animated: true)
    }
}
