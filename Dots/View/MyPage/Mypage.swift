//23 . 11 . 6. 2:33 am  최신화 완료-  브랜치 스타팅 포인트
import UIKit
import SnapKit
import RxSwift
import RxCocoa

class Mypage: UIViewController {
    var 유저정보_인스턴스 = 유저정보(사용자프로필이미지: "", 사용자프로필이름: "")
    
    var 마이페이지_프로필_이미지_버튼 = {
        var imageButton = UIButton()
        imageButton.layer.cornerRadius = 38
        imageButton.clipsToBounds = true
        imageButton.setImage(UIImage(named: "cabanel"), for: .selected)
        imageButton.setImage(UIImage(named: "cabanel"), for: .normal)
        imageButton.isSelected = !imageButton.isSelected
        return imageButton
    }()
    
    let 마이페이지_설정_버튼 = {
        var button = UIButton()
        button.setImage(UIImage(named: "setting" ), for: .normal)
        button.isSelected = !button.isSelected
        return button
    } ()
    
    let 마이페이지_프로필_닉네임: UILabel = {
        let label = UILabel()
        label.text = "유저 닉네임"
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let 마이페이지_프로필_아이디: UILabel = {
        let label = UILabel()
        label.text = "유저 아이디"
        label.textColor = UIColor.white
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        return label
    }()
    
    let 마이페이지_티켓_버튼 = {
        var button = UIButton()
        button.setImage(UIImage(named:"ticket"), for: .selected)
        button.setImage(UIImage(named: "ticket"), for: .normal)
        button.isSelected = !button.isSelected
        return button
    } ()
    
    let 마이페이지_티켓_택스트: UILabel = {
        let label = UILabel()
        label.text = "티켓"
        label.textColor = UIColor.white
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        label.textAlignment = .center
        return label
    }()
    
    let 마이페이지_체크인_버튼 = {
        var button = UIButton()
        button.setImage(UIImage(named:"home"), for: .selected)
        button.setImage(UIImage(named: "home"), for: .normal)
        button.isSelected = !button.isSelected
        button.isSelected = !button.isSelected
        return button
    } ()
    
    let 마이페이지_체크인_택스트: UILabel = {
        let label = UILabel()
        label.text = "체크인"
        label.textColor = UIColor.white
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        label.textAlignment = .center
        return label
    }()
    
    let 마이페이지_좋아요_버튼 = {
        var button = UIButton()
        button.setImage(UIImage(named:"heart"), for: .selected)
        button.setImage(UIImage(named: "heart"), for: .normal)
        button.isSelected = !button.isSelected
        button.isSelected = !button.isSelected
        return button
    } ()
    
    let 마이페이지_좋아요_택스트: UILabel = {
        
        let label = UILabel()
        label.text = "좋아요"
        label.textColor = UIColor.white
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        label.textAlignment = .center
        return label
        
    }()
    
    lazy var 마이페이지_컬렉션뷰 = {
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
        super.viewDidLoad()
        print("My Page")
        view.backgroundColor = UIColor.black
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.backgroundColor = UIColor.clear
        컬렉션뷰_레이아웃()
        UI레이아웃()

        마이페이지_컬렉션뷰.dataSource = self
        마이페이지_컬렉션뷰.delegate = self
        마이페이지_컬렉션뷰.register(MyPageCell.self, forCellWithReuseIdentifier: "MyPageCell")
    }
    override func viewDidAppear(_ animated: Bool) {
        
    }
    private func UI레이아웃 () {
        
        for UI뷰 in [마이페이지_프로필_이미지_버튼,마이페이지_설정_버튼,마이페이지_프로필_닉네임,마이페이지_프로필_아이디,마이페이지_티켓_버튼,마이페이지_티켓_택스트,마이페이지_체크인_버튼,마이페이지_체크인_택스트,마이페이지_좋아요_버튼,마이페이지_좋아요_택스트]{
            view.addSubview(UI뷰)
        }
        마이페이지_프로필_이미지_버튼.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(72)
            make.bottom.equalTo(마이페이지_컬렉션뷰.snp.top).offset(-192)
            make.centerX.equalToSuperview()
            make.size.equalTo(76)
        }
        마이페이지_설정_버튼.snp.makeConstraints { make in
            make.centerY.equalTo(마이페이지_프로필_이미지_버튼.snp.centerY)
            make.trailing.equalTo(마이페이지_컬렉션뷰.snp.trailing).offset(-5)
        }
        마이페이지_프로필_닉네임.snp.makeConstraints { make in
            make.top.equalTo(마이페이지_프로필_이미지_버튼.snp.bottom).offset(15)
            make.centerX.equalTo(마이페이지_프로필_이미지_버튼.snp.centerX)
           
        }
        마이페이지_프로필_아이디.snp.makeConstraints { make in
            make.top.equalTo(마이페이지_프로필_닉네임.snp.bottom).offset(8)
            make.centerX.equalTo(마이페이지_프로필_이미지_버튼.snp.centerX)
        }
        
        마이페이지_티켓_버튼.snp.makeConstraints { make in
            make.top.equalTo(마이페이지_체크인_버튼)
            make.trailing.equalTo(마이페이지_체크인_버튼.snp.leading).offset(-100)
        }
        마이페이지_티켓_택스트.snp.makeConstraints { make in
            make.top.equalTo(마이페이지_티켓_버튼.snp.bottom).offset(10)
            make.centerX.equalTo(마이페이지_티켓_버튼)
        }
        마이페이지_체크인_버튼.snp.makeConstraints { make in
            make.top.equalTo(마이페이지_프로필_아이디.snp.bottom).offset(46)
            make.centerX.equalTo(마이페이지_프로필_이미지_버튼.snp.centerX)
            
            
        }
        마이페이지_체크인_택스트.snp.makeConstraints { make in
            make.top.equalTo(마이페이지_체크인_버튼.snp.bottom).offset(10)
            make.centerX.equalTo(마이페이지_체크인_버튼)
        }
        마이페이지_좋아요_버튼.snp.makeConstraints { make in
            make.top.equalTo(마이페이지_체크인_버튼)
            make.leading.equalTo(마이페이지_체크인_버튼.snp.trailing).offset(100)
        }
        마이페이지_좋아요_택스트.snp.makeConstraints { make in
            make.top.equalTo(마이페이지_좋아요_버튼.snp.bottom).offset(10)
            make.centerX.equalTo(마이페이지_좋아요_버튼)
        }
    }
    func 컬렉션뷰_레이아웃 () {
        view.addSubview(마이페이지_컬렉션뷰)
        마이페이지_컬렉션뷰.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(350)
            make.bottom.equalToSuperview().offset(-5)
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
            
        }
    }
}

extension Mypage : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyPageCell", for: indexPath) as? MyPageCell else {
            return UICollectionViewCell()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width * 0.49
        let height = collectionView.frame.height * 0.5
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       let 마이페이지_티켓_화면 = MyPageTicket()
        self.navigationController?.pushViewController(마이페이지_티켓_화면, animated: true)
    }
}
