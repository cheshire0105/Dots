import RxCocoa
import RxSwift
import SnapKit
import UIKit
// pull from master branch
class PopularReviewCell: UICollectionViewCell {
    var 전시정보_서브셀_인스턴스 = 전시정보_이미지()
    
    var 유저_블록 = {
        let uiView = UIView()
        uiView.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        uiView.layer.cornerRadius = 20
        return uiView
    } ()
    
    var 좋아요_블록 = {
        let uiView = UIView()
        uiView.backgroundColor = UIColor.systemPink.withAlphaComponent(0.8)
        uiView.layer.cornerRadius = 20
        return uiView
    } ()
    
    var 조회수_블록 = {
        let uiView = UIView()
        uiView.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        uiView.layer.cornerRadius = 20
        return uiView
    } ()
    
    var 인기셀_작성자_이미지 = {
        var imageView = UIImageView()
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let 인기셀_작성자_이름: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor.black
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        label.textAlignment = .left
        return label
    }()
    
    let 좋아요_버튼 = {
        let button = UIButton()
        button.setImage(UIImage(named: "좋아요"), for: .normal)
        button.isSelected = !button.isSelected
        
        return button
    } ()
    
    let 좋아요_카운트 = {
        let label = UILabel()
        label.text = "카운트"
        label.font = UIFont(name: "HelveticaNeue", size: 10)
        label.textColor = UIColor.white
        return label
    } ()
    
    let 조회수_버튼 = {
        let button = UIButton()
        button.setImage(UIImage(named: "조회수"), for: .normal)
        button.isEnabled = false
        return button
    } ()
    
    let 조회수_카운트 = {
        let label = UILabel()
        label.text = "카운트"
        label.font = UIFont(name: "HelveticaNeue", size: 10)
        label.textColor = UIColor.darkGray
        return label
    } ()
    
    let 인기셀_아티스트 = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.setTitle("", for: .selected)
        button.backgroundColor = UIColor.systemGray.withAlphaComponent(0.4)
        button.isEnabled = true
        button.layer.cornerRadius = 12
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 12)
        button.setTitleColor(UIColor.white, for: .selected)
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.isSelected = !button.isSelected
        return button
    }()
   
    let 인기셀_리뷰제목 = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        return label
    } ()
    
    let 인기셀_리뷰내용 = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor.white
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        label.numberOfLines = 3
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .justified
        return label
    } ()
    
    let 인기셀_이미지_묶음_컬렉션뷰: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.layer.cornerRadius = 10
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        
        return collectionView
    } ()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        인기셀_이미지_묶음_컬렉션뷰.reloadData()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.darkGray.withAlphaComponent(0.7)
        layer.cornerRadius = 20
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 10
        인기셀layout()
        인기셀_이미지_묶음_컬렉션뷰.dataSource = self
        인기셀_이미지_묶음_컬렉션뷰.delegate = self
        인기셀_이미지_묶음_컬렉션뷰.isPagingEnabled = true
        인기셀_이미지_묶음_컬렉션뷰.register(인기셀_이미지_묶음_셀.self, forCellWithReuseIdentifier: "인기셀_이미지_묶음_셀")
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: -  EXTENSION

extension PopularReviewCell {
    
    func 인기셀layout() {
      
        contentView.addSubview(인기셀_이미지_묶음_컬렉션뷰)
        contentView.addSubview(인기셀_리뷰제목)
        contentView.addSubview(인기셀_리뷰내용)
        contentView.addSubview(유저_블록)
        contentView.addSubview(조회수_블록)
        contentView.addSubview(좋아요_블록)
        contentView.addSubview(인기셀_작성자_이미지)
        contentView.addSubview(인기셀_작성자_이름)
        contentView.addSubview(조회수_버튼)
        contentView.addSubview(조회수_카운트)
        contentView.addSubview(좋아요_카운트)
        addSubview(좋아요_버튼)

        인기셀_이미지_묶음_컬렉션뷰.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-157)
        }
    
        인기셀_리뷰제목.snp.makeConstraints { make in
            make.top.equalTo(인기셀_이미지_묶음_컬렉션뷰.snp.bottom).offset(41)
            make.leading.equalTo(인기셀_이미지_묶음_컬렉션뷰).offset(5)
            
        }
        
        인기셀_리뷰내용.snp.makeConstraints { make in
            make.top.equalTo(인기셀_리뷰제목.snp.bottom).offset(10)
            make.leading.equalTo(인기셀_이미지_묶음_컬렉션뷰).offset(5)
            make.trailing.equalTo(인기셀_이미지_묶음_컬렉션뷰).offset(-5)
            make.bottom.equalToSuperview().offset(-23)
        }
        유저_블록.snp.makeConstraints { make in
            make.top.equalTo(인기셀_이미지_묶음_컬렉션뷰.snp.bottom).offset(-20)
            make.bottom.equalTo(인기셀_이미지_묶음_컬렉션뷰.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-250)
        }
        조회수_블록.snp.makeConstraints { make in
            make.top.equalTo(유저_블록)
            make.bottom.equalTo(유저_블록)
            make.leading.equalTo(유저_블록.snp.trailing).offset(130)
            make.trailing.equalToSuperview().offset(-80)
        }
        좋아요_블록.snp.makeConstraints { make in
            make.top.equalTo(유저_블록)
            make.bottom.equalTo(유저_블록)
            make.leading.equalTo(조회수_블록.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-30)
        }
        
        인기셀_작성자_이미지.snp.makeConstraints { make in
            make.top.equalTo(유저_블록).offset(5)
            make.leading.equalTo(유저_블록.snp.leading).offset(5)
            make.bottom.equalTo(유저_블록.snp.bottom).offset(-5)
            make.trailing.equalTo(인기셀_작성자_이름.snp.leading).offset(-5)
        }
        
        인기셀_작성자_이름.snp.makeConstraints { make in
            make.top.equalTo(유저_블록).offset(5)
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
        
        
    }
    

}

extension PopularReviewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 전시정보_서브셀_인스턴스.전시이미지묶음[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "인기셀_이미지_묶음_셀", for: indexPath) as? 인기셀_이미지_묶음_셀 else {
            return UICollectionViewCell()
        }
        
        let imageName = 전시정보_서브셀_인스턴스.전시이미지묶음[collectionView.tag][indexPath.item]
        cell.인기셀_이미지.image = UIImage(named: imageName)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width * 1
        let height = collectionView.frame.height * 1
        return CGSize(width: width, height: height)
    }
}
