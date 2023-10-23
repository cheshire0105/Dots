import UIKit

class CustomCell: UICollectionViewCell {
    

    let 작성자_이미지 = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill

        return imageView
    }()
    
    let 작성자_이름: UILabel = {
        let label = UILabel()
        label.text = ""
        return label
    }()

    let 하트_아이콘 = {
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
        let label = UILabel()
        label.text = ""
        label.backgroundColor = UIColor.lightGray
        label.layer.cornerRadius = 10
        return label
    }()
    
    let 인기셀_전시장소 = {
        let label = UILabel()
        label.text = ""
        label.backgroundColor = UIColor.lightGray
        label.layer.cornerRadius = 10
        return label
    } ()

    override init(frame: CGRect) {
        super.init(frame: frame)
        인기셀layout()
        layer.cornerRadius = 10
        backgroundColor = UIColor.darkGray
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func 인기셀layout() {
        contentView.addSubview(작성자_이미지)
        contentView.addSubview(작성자_이름)
        contentView.addSubview(하트_아이콘)
        contentView.addSubview(인기셀_이미지)
        contentView.addSubview(인기셀_아티스트)
        contentView.addSubview(인기셀_전시장소)

        작성자_이미지.snp.makeConstraints { make in
            make.width.equalTo(38)
            make.height.equalTo(38)
            make.top.equalToSuperview().offset(18)
            make.leading.equalToSuperview().offset(21)
        }
        작성자_이름.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(26)
            make.top.equalToSuperview().offset(26)
            make.leading.equalToSuperview().offset(68)
        }
        하트_아이콘.snp.makeConstraints { make in
            make.width.equalTo(25)
            make.height.equalTo(22)
            make.top.equalToSuperview().offset(26)
            make.trailing.equalToSuperview().offset(-26)
            make.centerY.equalTo(작성자_이미지)
        }

        인기셀_이미지.snp.makeConstraints { make in
            make.width.equalTo(306)
            make.height.equalTo(368)
            make.top.equalTo(작성자_이미지.snp.bottom).offset(14)
            make.leading.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().offset(-21)
            make.bottom.equalToSuperview().offset(-207)
        }
        인기셀_아티스트.snp.makeConstraints { make in
            make.width.equalTo(139.03)
            make.height.equalTo(31)
            make.top.equalTo(인기셀_이미지.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(18)
        }
        인기셀_전시장소.snp.makeConstraints { make in
            make.width.equalTo(91.9)
            make.height.equalTo(31)
            make.top.equalTo(인기셀_이미지.snp.bottom).offset(12)
            make.leading.equalTo(인기셀_아티스트.snp.trailing).offset(7.07)

        }
    }
}
