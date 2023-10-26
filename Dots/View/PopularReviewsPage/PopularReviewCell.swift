import RxCocoa
import RxSwift
import SnapKit
import UIKit

class PopularReviewCell: UICollectionViewCell {
    var 전시정보_서브셀_인스턴스 = 전시정보_서브셀()
    let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.pageIndicatorTintColor = .lightGray

        return pageControl
    }()

    var 인기셀_작성자_이미지 = {
        var imageView = UIImageView()
        imageView.layer.cornerRadius = 18
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    let 인기셀_작성자_이름: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()

    let 인기셀_하트_아이콘 = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        return imageView
    }()

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

    let 인기셀_전시장소 = {
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

//
//    let 인기셀_리뷰제목 = {
//        let label = UILabel()
//        label.text = ""
//        label.textColor = UIColor.white
//        label.font = UIFont.boldSystemFont(ofSize: 20)
//        label.textAlignment = .center
//        return label
//    }()

    let 인기셀_리뷰내용 = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor.white
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        label.numberOfLines = 7
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .justified
        return label
    }()

    let 인기셀_이미지_묶음_컬렉션뷰: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .orange
        collectionView.layer.cornerRadius = 10
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.decelerationRate = UIScrollView.DecelerationRate.fast

        return collectionView
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        인기셀_이미지_묶음_컬렉션뷰.reloadData()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        인기셀layout()
        layer.cornerRadius = 30
        backgroundColor = UIColor.darkGray.withAlphaComponent(0.7)
        //backgroundColor = UIColor.darkGray
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 20
        //
        인기셀_이미지_묶음_컬렉션뷰.isPagingEnabled = true
        인기셀_이미지_묶음_컬렉션뷰.dataSource = self
        인기셀_이미지_묶음_컬렉션뷰.delegate = self
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
        contentView.addSubview(인기셀_작성자_이미지)
        contentView.addSubview(인기셀_작성자_이름)
        contentView.addSubview(인기셀_하트_아이콘)
        addSubview(인기셀_이미지_묶음_컬렉션뷰)
        addSubview(pageControl)
        contentView.addSubview(인기셀_아티스트)
        contentView.addSubview(인기셀_전시장소)
        contentView.addSubview(인기셀_리뷰내용)

        인기셀_작성자_이미지.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(34)
            make.bottom.equalTo(인기셀_이미지_묶음_컬렉션뷰.snp.top).offset(-12)
            make.leading.equalTo(인기셀_이미지_묶음_컬렉션뷰.snp.leading)
            make.trailing.equalTo(인기셀_작성자_이름.snp.leading).offset(-13)
        }
        인기셀_작성자_이름.snp.makeConstraints { make in

            make.centerY.equalTo(인기셀_작성자_이미지)
            make.leading.equalToSuperview().offset(88)
        }
        인기셀_하트_아이콘.snp.makeConstraints { make in
            make.width.equalTo(인기셀_작성자_이미지)
            make.top.equalTo(인기셀_작성자_이미지.snp.top).offset(3)
            make.bottom.equalTo(인기셀_작성자_이미지.snp.bottom).offset(-3)
            make.trailing.equalTo(인기셀_이미지_묶음_컬렉션뷰.snp.trailing)
        }
        인기셀_이미지_묶음_컬렉션뷰.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(80)
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().offset(-40)
            make.bottom.equalToSuperview().offset(-205)
        }
        pageControl.snp.makeConstraints { make in
            make.bottom.equalTo(인기셀_이미지_묶음_컬렉션뷰).offset(-25)
            make.centerX.equalToSuperview()
        }

        인기셀_아티스트.snp.makeConstraints { make in
            make.top.equalTo(인기셀_이미지_묶음_컬렉션뷰.snp.bottom).offset(10)
            make.leading.equalTo(인기셀_이미지_묶음_컬렉션뷰.snp.leading)
            make.bottom.equalTo(인기셀_전시장소)
            make.width.equalTo(135)
        }
        인기셀_전시장소.snp.makeConstraints { make in
            make.width.equalTo(115)
            make.top.equalTo(인기셀_이미지_묶음_컬렉션뷰.snp.bottom).offset(10)
            make.leading.equalTo(인기셀_아티스트.snp.trailing).offset(10)
        }

        인기셀_리뷰내용.snp.makeConstraints { make in
            make.leading.equalTo(인기셀_이미지_묶음_컬렉션뷰)
            make.trailing.equalTo(인기셀_이미지_묶음_컬렉션뷰)
            make.top.equalTo(인기셀_아티스트.snp.bottom).offset(5)
            make.bottom.equalToSuperview().offset(-25)
        }
    }
}

extension PopularReviewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 전시정보_서브셀_인스턴스.전시이미지묶음.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "인기셀_이미지_묶음_셀", for: indexPath) as? 인기셀_이미지_묶음_셀 else {
            return UICollectionViewCell()
        }
        let imageArray = 전시정보_서브셀_인스턴스.전시이미지묶음[indexPath.item]

        // 전체 이미지 배열을 사용하여 셀에 데이터 설정
        cell.인기셀_이미지.image = UIImage(named: imageArray.first ?? "")
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width * 1
        let height = collectionView.frame.height * 1
        return CGSize(width: width, height: height)
    }
}
