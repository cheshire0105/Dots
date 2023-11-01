import RxCocoa
import RxSwift
import SnapKit
import UIKit

class 인기리뷰_디테일_셀: UICollectionViewCell {
    var 인기셀_이미지 = {
        var imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderWidth = 10
        imageView.layer.borderColor = UIColor.darkGray.withAlphaComponent(0.7).cgColor

        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        contentView.addSubview(인기셀_이미지)
        인기셀_이미지.snp.makeConstraints { make in
            make.size.equalToSuperview()
        }
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
