import UIKit

class 마이페이지_보관함 : UIViewController {
    
    var 현재_선택된_버튼: Int = 0
    
    let 뒤로가기_버튼 = {
        let button = UIButton()
        button.setImage(UIImage(named: "loginBack"), for: .selected)
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
    
    let 보관함_전시_버튼 = {
        let button = UIButton()
        button.setTitle("전시", for: .normal)
        button.setTitle("전시", for: .selected)
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.setTitleColor(UIColor.white, for: .selected)
        button.isSelected = !button.isSelected
        button.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 14)
        return button
    } ()
    let 보관함_미술관_버튼 = {
        let button = UIButton()
        button.setTitle("미술관", for: .normal)
        button.setTitle("미술관", for: .selected)
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.setTitleColor(UIColor.white, for: .selected)
        button.isSelected = !button.isSelected
        button.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 14)
        return button
    } ()
    let 보관함_작가_버튼 = {
        let button = UIButton()
        button.setTitle("작가", for: .normal)
        button.setTitle("작가", for: .selected)
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.setTitleColor(UIColor.white, for: .selected)
        button.isSelected = !button.isSelected
        button.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 14)
        return button
    } ()
    let 보관함_리뷰_버튼 = {
        let button = UIButton()
        button.setTitle("리뷰", for: .normal)
        button.setTitle("리뷰", for: .selected)
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.setTitleColor(UIColor.white, for: .selected)
        button.isSelected = !button.isSelected
        button.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 14)
        return button
    } ()
    let 구분선 = {
        let uiView = UIView()
        uiView.backgroundColor = .darkGray
        return uiView
    }()
    let 바 = {
        let uiView = UIView()
        uiView.backgroundColor = .white
        uiView.layer.cornerRadius = 3
        
        return uiView
    }()
    lazy var 보관함_컬렉션뷰 = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 5 , left: 0, bottom: 0, right: 0)
        
        collectionView.backgroundColor = .black
        collectionView.layer.cornerRadius = 10
        collectionView.showsVerticalScrollIndicator = false
        collectionView.decelerationRate = UIScrollView.DecelerationRate.normal
        return collectionView
    } ()
//    override func viewWillAppear(_ animated: Bool) {
//        if let glassTabBar = tabBarController as? GlassTabBar {
//            glassTabBar.customTabBarView.isHidden = true
//        }
//    }
    override func viewDidLoad() {
        view.backgroundColor = .black
        navigationItem.hidesBackButton = true
        navigationController?.isNavigationBarHidden = true
        
        UI레이아웃()
        버튼_클릭()
        보관함_컬렉션뷰.delegate = self
        보관함_컬렉션뷰.dataSource = self
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.보관함_전시_버튼_클릭()
        }
        화면_제스쳐_실행()
    }
    
    func UI레이아웃() {
        view.addSubview(뒤로가기_버튼)
        view.addSubview(페이지_제목)
        view.addSubview(보관함_전시_버튼)
        view.addSubview(보관함_미술관_버튼)
        view.addSubview(보관함_작가_버튼)
        view.addSubview(보관함_리뷰_버튼)
        view.addSubview(구분선)
        view.addSubview(바)
        
        뒤로가기_버튼.snp.makeConstraints { make in
            make.centerY.equalTo(페이지_제목.snp.centerY)
            make.leading.equalToSuperview().offset(16)
            make.size.equalTo(40)
        }
        페이지_제목.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.centerX.equalToSuperview()
        }
        
        보관함_전시_버튼.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(129)
            make.leading.equalToSuperview().offset(36)
        }
        보관함_미술관_버튼.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(129)
            make.leading.equalTo(보관함_전시_버튼.snp.trailing).offset(39)
            
        }
        보관함_작가_버튼.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(129)
            make.leading.equalTo(보관함_미술관_버튼.snp.trailing).offset(39)
        }
        보관함_리뷰_버튼.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(129)
            make.leading.equalTo(보관함_작가_버튼.snp.trailing).offset(39)
        }
        구분선.snp.makeConstraints { make in
            make.top.equalTo(보관함_전시_버튼.snp.bottom).offset(11)
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
            make.height.equalTo(1)
        }
        바.snp.makeConstraints { make in
            make.centerY.equalTo(구분선.snp.centerY).offset(-0.5)
            make.leading.equalTo(보관함_전시_버튼.snp.leading)
            make.trailing.equalTo(보관함_전시_버튼.snp.trailing)
            make.height.equalTo(2)
        }
    }
    func 보관함_컬렉션뷰_레이아웃 () {
        view.addSubview(보관함_컬렉션뷰)
        보관함_컬렉션뷰.snp.makeConstraints { make in
            make.top.equalTo(보관함_전시_버튼.snp.bottom).offset(40)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
    private func 버튼_클릭() {
        뒤로가기_버튼.addTarget(self, action: #selector(뒤로가기_버튼_클릭), for: .touchUpInside)
        보관함_전시_버튼.addTarget(self, action: #selector(보관함_전시_버튼_클릭), for: .touchUpInside)
        보관함_미술관_버튼.addTarget(self, action: #selector(보관함_미술관_버튼_클릭), for: .touchUpInside)
        보관함_작가_버튼.addTarget(self, action: #selector(보관함_작가_버튼_클릭), for: .touchUpInside)
        보관함_리뷰_버튼.addTarget(self, action: #selector(보관함_리뷰_버튼_클릭), for: .touchUpInside)
    }
    @objc func 뒤로가기_버튼_클릭() {
        navigationController?.popViewController(animated: true)
    }
    @objc func 보관함_전시_버튼_클릭() {
        print("마이페이지 : 전시 보관함")
        현재_선택된_버튼 = 0
        바_위치_업데이트()
        보관함_컬렉션뷰.register(보관함_전시_셀.self, forCellWithReuseIdentifier: "보관함_전시_셀")
        보관함_컬렉션뷰_레이아웃 ()
        보관함_컬렉션뷰.reloadData()
        
        
    }
    @objc func 보관함_미술관_버튼_클릭() {
        print("마이페이지 : 미술관 보관함")
        현재_선택된_버튼 = 1
        바_위치_업데이트()
        보관함_컬렉션뷰.register(보관함_미술관_셀.self, forCellWithReuseIdentifier: "보관함_미술관_셀")
        보관함_컬렉션뷰_레이아웃 ()
        보관함_컬렉션뷰.reloadData()
        
    }
    @objc func 보관함_작가_버튼_클릭() {
        print("마이페이지 : 작가 보관함")
        현재_선택된_버튼 = 2
        바_위치_업데이트()
        보관함_컬렉션뷰.register(보관함_아티스트_셀.self, forCellWithReuseIdentifier: "보관함_아티스트_셀")
        보관함_컬렉션뷰_레이아웃 ()
        보관함_컬렉션뷰.reloadData()
        
    }
    @objc func 보관함_리뷰_버튼_클릭() {
        print("마이페이지 : 리뷰 보관함")
        현재_선택된_버튼 = 3
        바_위치_업데이트()
        보관함_컬렉션뷰.register(보관함_리뷰_셀.self, forCellWithReuseIdentifier: "보관함_리뷰_셀")
        보관함_컬렉션뷰_레이아웃 ()
        보관함_컬렉션뷰.reloadData()
    }
    private func 바_위치_업데이트() {
        let 선택된버튼: UIButton
        switch 현재_선택된_버튼 {
        case 0:
            선택된버튼 = 보관함_전시_버튼
        case 1:
            선택된버튼 = 보관함_미술관_버튼
        case 2:
            선택된버튼 = 보관함_작가_버튼
        case 3:
            선택된버튼 = 보관함_리뷰_버튼
        default:
            return
        }
            UIView.animate(withDuration: 0.3) {
                self.바.layer.borderColor = UIColor.clear.cgColor
                self.바.layer.borderWidth = 1
                self.바.snp.remakeConstraints { make in
                    make.centerY.equalTo(self.구분선.snp.centerY).offset(-0.5)
                    make.leading.equalTo(선택된버튼.snp.leading)
                    make.trailing.equalTo(선택된버튼.snp.trailing)
                    make.height.equalTo(2)
                }
                self.view.setNeedsLayout()
                self.view.layoutIfNeeded()
        }
    }
}
extension 마이페이지_보관함 : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch 현재_선택된_버튼 {
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
        switch 현재_선택된_버튼 {
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
        switch 현재_선택된_버튼 {
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
        switch 현재_선택된_버튼 {
        case 0:
            
            return 20
        case 1:
          
            return 30
        case 2:
           
            return 30
        case 3:
           
            return 20
        default:
            break
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch 현재_선택된_버튼 {
        case 0:
            let width = collectionView.frame.width * 0.49 - 12
            let height = collectionView.frame.height * 0.4
            return CGSize(width: width, height: height)
        case 1:
            let width = collectionView.frame.width * 0.33 - 10
            let height = collectionView.frame.height * 0.20
            return CGSize(width: width, height: height)
        case 2:
            let width = collectionView.frame.width * 0.33 - 10
            let height = collectionView.frame.height * 0.20
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



extension 마이페이지_보관함 {
    
    func 화면_제스쳐_실행 () {
        let 화면_제스쳐 = UISwipeGestureRecognizer(target: self, action: #selector(화면_제스쳐_뒤로_가기))
        화면_제스쳐.direction = .right
        view.addGestureRecognizer(화면_제스쳐)
    }
    @objc private func 화면_제스쳐_뒤로_가기() {
        navigationController?.popViewController(animated: true)
    }
    
}

