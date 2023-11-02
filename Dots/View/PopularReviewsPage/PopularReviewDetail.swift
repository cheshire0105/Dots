import UIKit
import SwiftUI
import RxSwift
import RxCocoa
import SnapKit

class PopularReviewDetail : UIViewController {
    var selectedCellIndex: Int?
    var 전시정보_메인셀_인스턴스 = 전시정보_택스트(전시아티스트이름: "", 전시장소이름: "", 본문제목: "", 본문내용: "")

    private let 뒤로가기_버튼_블록 = {
        let uiView = UIView()
        uiView.backgroundColor = UIColor.gray.withAlphaComponent(0.8)
        uiView.layer.cornerRadius = 20
        return uiView
    } ()
    
    private let 뒤로가기_버튼 = {
        let button = UIButton()
        button.setImage(UIImage(named: "backButton"), for: .normal)
        button.isSelected = !button.isSelected
        return button
    } ()
    
     private var 유저_블록 = {
        let uiView = UIView()
        uiView.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        uiView.layer.cornerRadius = 20
        return uiView
    } ()
    
     private var 좋아요_블록 = {
        let uiView = UIView()
        uiView.backgroundColor = UIColor.systemPink.withAlphaComponent(0.8)
        uiView.layer.cornerRadius = 20
        return uiView
    } ()
    
    private var 조회수_블록 = {
        let uiView = UIView()
        uiView.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        uiView.layer.cornerRadius = 20
        return uiView
    } ()
    
     private var 인기셀_작성자_이미지 = {
        var imageView = UIImageView()
         imageView.image = UIImage(named: "cabanel")
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
     private let 인기셀_작성자_이름: UILabel = {
        let label = UILabel()
        label.text = "박철우"
        label.textColor = UIColor.black
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        label.textAlignment = .left
        return label
    }()
    
   private let 좋아요_버튼 = {
        let button = UIButton()
        button.setImage(UIImage(named: "좋아요"), for: .normal)
        button.isSelected = !button.isSelected
        
        return button
    } ()
    
    private let 좋아요_카운트 = {
        let label = UILabel()
        label.text = "카운트"
        label.font = UIFont(name: "HelveticaNeue", size: 10)
        label.textColor = UIColor.white
        return label
    } ()
    
    private let 조회수_버튼 = {
        let button = UIButton()
        button.setImage(UIImage(named: "조회수"), for: .normal)
        button.isEnabled = false
        return button
    } ()
    
    private let 조회수_카운트 = {
        let label = UILabel()
        label.text = "카운트"
        label.font = UIFont(name: "HelveticaNeue", size: 10)
        label.textColor = UIColor.darkGray
        return label
    } ()
    
    private let 리뷰_제목 = {
        let label = UILabel()
        label.text = "전시 리뷰 제목 택스트"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor.white
        return label
    } ()
    private let 리뷰_전시명 = {
        let label = UILabel()
        label.text = "리암 길릭 : Alterants"
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        label.textColor = UIColor.white
        return label
    } ()
    private let 리뷰_내용 = {
        let label = UILabel()
        label.text = """
        assajflfj sjflajslf asfj! asjlsjffjklasfj ? asfjklff, asjfkl.sjflsajfjlafjlasjfjs,fasjdlfjsdlfsflkfjlksajklf;qierxnvjdsfkla!.aslkfdjlkajfsajjfjaslfkjfksdlfjalksdfqejrklasdklfjkldfaldsfajsqr!!aslfjsasajflkjsfal,sfjalsjflsflkajfslajflksjlajklfjlkasjflksajflkjsl asjflksfj l asjflk ja lajsklfj klsajf jaskdfnjkqwenrk joiv njqweojr njkxz sjl wke njkfsd k lksdjf lsjlwqne krjbkjsn kllfj
        """
        label.textColor = UIColor.white
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .justified
        return label
    } ()
    
    private let 댓글_버튼 = {
        let 댓글갯수 : Int = 0
        let button = UIButton()
        button.setTitle(" 댓글\(댓글갯수)개", for: .normal)
        button.setTitleColor(UIColor.black, for: .selected)
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 12)
        button.setImage(UIImage(named: "댓글"), for: .normal)
        button.backgroundColor = UIColor.white
        button.isSelected = !button.isSelected
        button.layer.cornerRadius = 10
        return button
    } ()
    
    lazy var 인기_디테일_컬렉션뷰: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        collectionView.backgroundColor = .black
        collectionView.layer.cornerRadius = 10
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        collectionView.isPagingEnabled = true
        return collectionView
    }()
    override func viewWillAppear(_ animated: Bool) {
        if let glassTabBar = tabBarController as? GlassTabBar {
            glassTabBar.customTabBarView.isHidden = true
        }
    }
    override func viewDidLoad() {
        print("Popular Review Detail")
        
        view.backgroundColor = .black
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        인기_디테일_컬렉션뷰.dataSource = self
        인기_디테일_컬렉션뷰.delegate = self
        버튼_클릭()
        컬렉션뷰_레이아웃()
        UI레이아웃()
        인기_디테일_컬렉션뷰.register(인기리뷰_디테일_셀.self, forCellWithReuseIdentifier: "인기리뷰_디테일_셀")
        
        if let selectedIndex = selectedCellIndex {
            print("Selected Review Title: \(전시정보_메인셀_인스턴스.인기_전시정보[selectedIndex].본문제목)")
            print("Selected Review Content: \(전시정보_메인셀_인스턴스.인기_전시정보[selectedIndex].본문내용)")
            print("Selected Review Artist: \(전시정보_메인셀_인스턴스.인기_전시정보[selectedIndex].전시아티스트이름)")
            print("Selected Review Location: \(전시정보_메인셀_인스턴스.인기_전시정보[selectedIndex].전시장소이름)")
        }
    }
    
    func UI레이아웃 () {
        view.addSubview(뒤로가기_버튼_블록)
        view.addSubview(뒤로가기_버튼)
        view.addSubview(유저_블록)
        view.addSubview(조회수_블록)
        view.addSubview(좋아요_블록)
        view.addSubview(인기셀_작성자_이미지)
        view.addSubview(인기셀_작성자_이름)
        view.addSubview(조회수_버튼)
        view.addSubview(좋아요_버튼)
        view.addSubview(조회수_카운트)
        view.addSubview(좋아요_카운트)
        view.addSubview(리뷰_제목)
        view.addSubview(리뷰_전시명)
        view.addSubview(리뷰_내용)
        view.addSubview(댓글_버튼)
        
        뒤로가기_버튼_블록.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(80)
            make.centerX.equalTo(뒤로가기_버튼.snp.centerX)
            make.centerY.equalTo(뒤로가기_버튼.snp.centerY)
            make.bottom.equalTo(인기_디테일_컬렉션뷰.snp.top).offset(-10)
        }
         뒤로가기_버튼.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(40)
            make.bottom.equalTo(인기_디테일_컬렉션뷰.snp.top).offset(-10)
        }
        유저_블록.snp.makeConstraints { make in
            make.top.equalTo(인기_디테일_컬렉션뷰.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-250)
            make.bottom.equalToSuperview().offset(-312)
        }
        조회수_블록.snp.makeConstraints { make in
            make.top.equalTo(유저_블록)
            make.bottom.equalTo(유저_블록)
            make.leading.equalTo(유저_블록.snp.trailing).offset(145)
            make.trailing.equalToSuperview().offset(-64)
        }
        좋아요_블록.snp.makeConstraints { make in
            make.top.equalTo(유저_블록)
            make.bottom.equalTo(유저_블록)
            make.leading.equalTo(조회수_블록.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-12)
        }
        인기셀_작성자_이미지.snp.makeConstraints { make in
            make.top.equalTo(유저_블록.snp.top).offset(5)
            make.leading.equalTo(유저_블록.snp.leading).offset(5)
            make.bottom.equalTo(유저_블록.snp.bottom).offset(-5)
            make.trailing.equalTo(인기셀_작성자_이름.snp.leading).offset(-5)
        }
        
        인기셀_작성자_이름.snp.makeConstraints { make in
            make.top.equalTo(유저_블록.snp.top).offset(5)
            make.bottom.equalTo(유저_블록.snp.bottom).offset(-5)
            make.leading.equalTo(유저_블록.snp.leading).offset(38)
        }
        
        조회수_버튼.snp.makeConstraints { make in
            make.top.equalTo(조회수_블록).offset(5)
            make.leading.equalTo(조회수_블록.snp.leading).offset(5)
            make.trailing.equalTo(조회수_블록.snp.trailing).offset(-5)
        }
        좋아요_버튼.snp.makeConstraints { make in
            make.top.equalTo(좋아요_블록).offset(5)
            make.leading.equalTo(좋아요_블록.snp.leading).offset(5)
            make.trailing.equalTo(좋아요_블록.snp.trailing).offset(-5)
        }
        조회수_카운트.snp.makeConstraints { make in
            make.top.equalTo(조회수_버튼.snp.bottom).offset(-3)
            make.leading.equalTo(조회수_블록.snp.leading).offset(6)
            make.trailing.equalTo(조회수_블록.snp.trailing).offset(-5)

        }
        좋아요_카운트.snp.makeConstraints { make in
            make.top.equalTo(좋아요_버튼.snp.bottom).offset(-3)
            make.leading.equalTo(좋아요_블록.snp.leading).offset(6)
            make.trailing.equalTo(좋아요_블록.snp.trailing).offset(-5)
        }
        리뷰_제목.snp.makeConstraints { make in
            make.top.equalTo(유저_블록.snp.bottom).offset(36)
            make.leading.equalTo(유저_블록)
            
        }
        리뷰_전시명.snp.makeConstraints { make in
            make.top.equalTo(리뷰_제목.snp.bottom).offset(10)
            make.leading.equalTo(유저_블록)
        }
        리뷰_내용.snp.makeConstraints { make in
            make.top.equalTo(리뷰_전시명.snp.bottom).offset(20)
            make.leading.equalTo(유저_블록)
            make.trailing.equalTo(좋아요_블록.snp.trailing)
            
        }
        댓글_버튼.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.width.equalTo(100)
            make.bottom.equalToSuperview().offset(-42)
            make.centerX.equalToSuperview()
        }
    }
    
    func 컬렉션뷰_레이아웃() {
        view.addSubview(인기_디테일_컬렉션뷰)
        인기_디테일_컬렉션뷰.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(130)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-365)
        }
    }
    
    private func 버튼_클릭() {
        뒤로가기_버튼.addTarget(self, action: #selector(뒤로가기_버튼_클릭), for: .touchUpInside)
    }
    @objc func 뒤로가기_버튼_클릭() {
        navigationController?.popViewController(animated: true)
    }
}

extension PopularReviewDetail : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "인기리뷰_디테일_셀", for: indexPath) as? 인기리뷰_디테일_셀 else {
            return UICollectionViewCell()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width * 1
        let height = collectionView.frame.height * 1
        return CGSize(width: width, height: height)
    }
    
}
