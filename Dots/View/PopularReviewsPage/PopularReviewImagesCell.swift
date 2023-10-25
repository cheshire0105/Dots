import RxCocoa
import RxSwift
import SnapKit
import UIKit
class 인기셀_이미지_묶음_셀: UICollectionViewCell {
    var 인기셀_이미지: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "")
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(인기셀_이미지)
        인기셀_이미지.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
