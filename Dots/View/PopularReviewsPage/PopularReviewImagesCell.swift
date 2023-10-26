import RxCocoa
import RxSwift
import SnapKit
import UIKit

struct 이미지묶음 {
    let 첫번째: String?
    let 두번째: String?
    let 세번째: String?
    let 네번째: String?

    init(첫번째: String?, 두번째: String?, 세번째: String?, 네번째: String?) {
        self.첫번째 = 첫번째
        self.두번째 = 두번째
        self.세번째 = 세번째
        self.네번째 = 네번째
    }
}

struct 이미지모델 {
    let 이미지묶음들: [이미지묶음]

    init(이미지묶음들: [이미지묶음]) {
        self.이미지묶음들 = 이미지묶음들
    }
}

class 인기셀_이미지_묶음_셀: UICollectionViewCell {
    var 인기셀_이미지: UIImageView = {
        var imageView = UIImageView()
//        imageView.image = UIImage(named: "")
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()

    func configure(with 이미지묶음: 이미지모델) {
        // 여기서 이미지묶음 구조체의 어떤 프로퍼티를 사용할지 결정해서 설정해줘야 함
        // 예를 들어, 첫 번째 이미지를 사용한다면:

        if let 첫번째이미지 = 이미지묶음.이미지묶음들.first?.첫번째 {
            인기셀_이미지.image = UIImage(named: 첫번째이미지)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        addSubview(인기셀_이미지)
        인기셀_이미지.snp.makeConstraints { make in
            make.size.equalToSuperview()
        }
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
