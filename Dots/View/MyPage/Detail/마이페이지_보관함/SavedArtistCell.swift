import UIKit

class 보관함_아티스트_셀 : UICollectionViewCell {
    var 보관함_아티스트_셀_이미지 = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "help")
        imageView.layer.cornerRadius = 52
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 0.3
        imageView.layer.borderColor = UIColor(named: "neon")?.cgColor
        imageView.contentMode = .scaleAspectFill
        return imageView
    } ()
    
    let 보관함_아티스트_셀_이름 = {
        let label = UILabel()
        label.text = "아티스트 이름"
        label.textColor = UIColor.white
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        label.textAlignment = .left
        return label
    } ()
  
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
//        layer.cornerRadius = 15
//        layer.borderWidth = 0.5
//        layer.borderColor = UIColor(named: "neon")?.cgColor
        보관함_아티스트_셀_레이아웃()
        
    }
    
    func 보관함_아티스트_셀_레이아웃() {
        contentView.addSubview(보관함_아티스트_셀_이미지)
        contentView.addSubview(보관함_아티스트_셀_이름)
        
        보관함_아티스트_셀_이미지.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(보관함_아티스트_셀_이미지.snp.width)
            make.bottom.equalToSuperview().offset(-30)
            
        }
        보관함_아티스트_셀_이름.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
        }
        
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
