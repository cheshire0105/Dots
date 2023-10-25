import RxCocoa
import RxSwift
import SnapKit
import UIKit
var imageNames: [String] = ["morningStar", "morningStar", "morningStar"]

class PopularReviewCell: UICollectionViewCell {
    // 인기셀_이미지 대신 UIScrollView 추가
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.clipsToBounds = true
        scrollView.backgroundColor = UIColor.clear
        scrollView.isPagingEnabled = true
        scrollView.layer.cornerRadius = 10

        return scrollView
    }()

    let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.pageIndicatorTintColor = .lightGray

        return pageControl
    }()

    // ---------------------------
    let 인기셀_작성자_이미지 = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 20
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

//    let 인기셀_이미지 = {
//        let imageView = UIImageView()
//        imageView.layer.cornerRadius = 10
//        imageView.clipsToBounds = true
//        imageView.contentMode = .scaleAspectFill
//
//        return imageView
//    }()

    let 인기셀_아티스트 = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.backgroundColor = UIColor.systemGray
        button.isEnabled = true
        button.layer.cornerRadius = 10
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(UIColor.white, for: .normal)
        return button
    }()

    let 인기셀_전시장소 = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.backgroundColor = UIColor.systemGray
        button.isEnabled = true
        button.layer.cornerRadius = 10
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(UIColor.white, for: .normal)

        return button
    }()

    let 인기셀_리뷰제목 = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()

    let 인기셀_리뷰내용 = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 7
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .justified
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        인기셀layout()
        layer.cornerRadius = 20
        backgroundColor = UIColor.darkGray
        //
        imageNames = ["morningStar", "morningStar", "morningStar"]

//        scrollView.contentSize = CGSize(width: scrollView.frame.width * CGFloat(imageNames.count), height: scrollView.frame.height)
//        pageControl.numberOfPages = imageNames.count
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
        addSubview(scrollView)
        contentView.addSubview(pageControl)
        // contentView.addSubview(인기셀_이미지)
        contentView.addSubview(인기셀_아티스트)
        contentView.addSubview(인기셀_전시장소)
        contentView.addSubview(인기셀_리뷰제목)
        contentView.addSubview(인기셀_리뷰내용)

        인기셀_작성자_이미지.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalTo(scrollView.snp.top).offset(-10)
            make.leading.equalTo(scrollView)
            make.trailing.equalTo(인기셀_작성자_이름.snp.leading).offset(-10)
        }
        인기셀_작성자_이름.snp.makeConstraints { make in

            make.centerY.equalTo(인기셀_작성자_이미지)
            make.leading.equalToSuperview().offset(68)
        }
        인기셀_하트_아이콘.snp.makeConstraints { make in
            make.centerY.equalTo(인기셀_작성자_이름)
            make.top.bottom.equalTo(인기셀_작성자_이름)
            make.trailing.equalTo(scrollView.snp.trailing)
        }
        scrollView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-207)
        }
        pageControl.snp.makeConstraints { make in
            make.bottom.equalTo(scrollView.snp.bottom).offset(-5)
            make.centerX.equalToSuperview()
        }

//        인기셀_이미지.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(60)
//            make.leading.equalToSuperview().offset(20)
//            make.trailing.equalToSuperview().offset(-20)
//            make.bottom.equalToSuperview().offset(-207)
//        }
        인기셀_아티스트.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.bottom).offset(15)
            make.leading.equalTo(scrollView.snp.leading)
            make.bottom.equalTo(인기셀_전시장소)
        }
        인기셀_전시장소.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.bottom).offset(15)
            make.leading.equalTo(인기셀_아티스트.snp.trailing).offset(10)
        }
        인기셀_리뷰제목.snp.makeConstraints { make in
            make.top.equalTo(인기셀_아티스트.snp.bottom).offset(10)
            make.leading.equalTo(scrollView)
        }
        인기셀_리뷰내용.snp.makeConstraints { make in
            make.leading.equalTo(scrollView)
            make.trailing.equalTo(scrollView)
            make.top.equalTo(인기셀_리뷰제목.snp.bottom).offset(5)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
}

extension PopularReviewCell {
    func addImagesToScrollView(imageNames: [String]) {
        for (index, imageName) in imageNames.enumerated() {
            let 인기셀_이미지 = UIImageView()
            인기셀_이미지.image = UIImage(named: imageName)
            인기셀_이미지.layer.cornerRadius = 10
            인기셀_이미지.clipsToBounds = true
            인기셀_이미지.contentMode = .scaleAspectFill

            let xPosition = scrollView.frame.width * CGFloat(index)
            인기셀_이미지.frame = CGRect(x: xPosition, y: 0, width: scrollView.frame.width, height: scrollView.frame.height)

            scrollView.addSubview(인기셀_이미지)
        }

        scrollView.contentSize = CGSize(width: scrollView.frame.width * CGFloat(imageNames.count), height: scrollView.frame.height)

        pageControl.numberOfPages = imageNames.count
    }
}

extension PopularReviewCell: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // scrollView가 스크롤될 때 호출되는 메서드
        let pageIndex = Int(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = pageIndex
    }
}
