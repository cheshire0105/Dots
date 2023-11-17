import Foundation
import UIKit
import SnapKit

class 마이페이지_전시_셀 : UICollectionViewCell {
    
   
    var 전시_셀_이미지 = {
            var imageView = UIImageView()
        imageView.image = UIImage(named: "Rectangle")
            imageView.layer.cornerRadius = 10
            imageView.clipsToBounds = true
            imageView.contentMode = .scaleAspectFill
        imageView.layer.borderWidth = 0.3
        imageView.layer.borderColor = UIColor(named: "neon")?.cgColor

            return imageView
        }()
    
    var 전시_셀_제목 = {
        let label = UILabel()
        label.text = "준비중인 전시 제목"
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    } ()
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.black
        layer.cornerRadius = 15
        마이페이지_전시_셀_레이아웃()
    }
    
    func 마이페이지_전시_셀_레이아웃() {
        contentView.addSubview(전시_셀_이미지)
        contentView.addSubview(전시_셀_제목)
        전시_셀_이미지.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-30)
        }
        전시_셀_제목.snp.makeConstraints { make in
            make.top.equalTo(전시_셀_이미지.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
