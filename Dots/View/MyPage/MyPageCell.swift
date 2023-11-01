import Foundation
import UIKit
import SnapKit

class MyPageCell : UICollectionViewCell {
    
    
    var 마이페이지_셀_이미지 = {
        let image = UIImage()
        
        
        return image
    } ()
    
    var 마이페이지_셀_제목 = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    } ()
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.orange
        layer.borderWidth = 7
        layer.cornerRadius = 14
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}