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
        
        // 언더바 형식 설정
        세그먼트.selectedSegmentTintColor = UIColor.lightGray
        
        return 세그먼트
    }()
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
            make.top.equalTo(페이지_제목.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
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
        print("선택된 세그먼트 아이탬 : \(세그먼트_아이탬)")
        
        switch 세그먼트_아이탬 {
        case 0:
            break
        case 1:
            break
        case 2:
            break
        case 3:
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "", for: indexPath) as! 마이페이지_전시_셀
            
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "", for: indexPath) as! 마이페이지_리뷰_셀
            
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch 세그먼트_컨트롤.selectedSegmentIndex {
        case 0:
            let width = collectionView.frame.width * 0.49
            let height = collectionView.frame.height * 0.4
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
