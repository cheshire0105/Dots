import SnapKit
import UIKit

class PopularReviewCell: UICollectionViewCell {
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
    
    let 인기셀_이미지 = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
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
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: -  EXTENSION

extension PopularReviewCell {
    func configure(with imageData: UIImage) {
        인기셀_이미지.image = imageData
    }
}

extension PopularReviewCell {
    func 인기셀layout() {
        contentView.addSubview(인기셀_작성자_이미지)
        contentView.addSubview(인기셀_작성자_이름)
        contentView.addSubview(인기셀_하트_아이콘)
        contentView.addSubview(인기셀_이미지)
        contentView.addSubview(인기셀_아티스트)
        contentView.addSubview(인기셀_전시장소)
        contentView.addSubview(인기셀_리뷰제목)
        contentView.addSubview(인기셀_리뷰내용)
        
        인기셀_작성자_이미지.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalTo(인기셀_이미지.snp.top).offset(-10)
            make.leading.equalTo(인기셀_이미지)
            make.trailing.equalTo(인기셀_작성자_이름.snp.leading).offset(-10)
        }
        인기셀_작성자_이름.snp.makeConstraints { make in
            
            make.centerY.equalTo(인기셀_작성자_이미지)
            make.leading.equalToSuperview().offset(68)
        }
        인기셀_하트_아이콘.snp.makeConstraints { make in
//            make.size.equalTo(인기셀_작성자_이미지).offset(-8)
            make.centerY.equalTo(인기셀_작성자_이름)
            make.top.bottom.equalTo(인기셀_작성자_이름)
            
            make.trailing.equalTo(인기셀_이미지.snp.trailing)
        }
        
        인기셀_이미지.snp.makeConstraints { make in
            
            make.top.equalToSuperview().offset(60)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-207)
        }
        인기셀_아티스트.snp.makeConstraints { make in
            make.top.equalTo(인기셀_이미지.snp.bottom).offset(10)
            make.leading.equalTo(인기셀_이미지.snp.leading)
        }
        인기셀_전시장소.snp.makeConstraints { make in
            make.top.equalTo(인기셀_이미지.snp.bottom).offset(10)
            make.leading.equalTo(인기셀_아티스트.snp.trailing).offset(10)
        }
        인기셀_리뷰제목.snp.makeConstraints { make in
            make.top.equalTo(인기셀_아티스트.snp.bottom).offset(10)
            make.leading.equalTo(인기셀_이미지)
        }
        인기셀_리뷰내용.snp.makeConstraints { make in
            make.leading.equalTo(인기셀_이미지)
            make.trailing.equalTo(인기셀_이미지)
            make.top.equalTo(인기셀_리뷰제목.snp.bottom).offset(10)
            make.bottom.equalToSuperview().offset(-10)
            
        }
    }
}
