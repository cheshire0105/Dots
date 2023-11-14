//import Foundation
//import UIKit
//import SnapKit
//
//class MyPageCell : UICollectionViewCell {
//    
//    var 백_블록 = {
//        let uiView = UIView()
//        uiView.backgroundColor = UIColor.orange
//        uiView.layer.cornerRadius = 15
//        return uiView
//    } ()
//    var 마이페이지_셀_이미지 = {
//        let image = UIImage()
//        
//        
//        return image
//    } ()
//    
//    var 마이페이지_셀_제목 = {
//        let label = UILabel()
//        label.text = ""
//        label.textColor = UIColor.white
//        label.font = UIFont.boldSystemFont(ofSize: 16)
//        return label
//    } ()
//    
//    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//    }
//    
//    
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        backgroundColor = UIColor.black
//        layer.cornerRadius = 15
//        마이페이지셀_레이아웃()
//    }
//    
//    func 마이페이지셀_레이아웃() {
//        contentView.addSubview(백_블록)
//        
//        백_블록.snp.makeConstraints { make in
//            make.top.leading.equalToSuperview().offset(1)
//            make.bottom.trailing.equalToSuperview().offset(-1)
//        }
//    }
//    
//    @available(*, unavailable)
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//}
