import Foundation
import UIKit
import SnapKit

class 마이페이지_리뷰_셀 : UICollectionViewCell {
    
   
   
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.orange
        layer.cornerRadius = 15
        마이페이지_리뷰_셀_레이아웃()
    }
    
    func 마이페이지_리뷰_셀_레이아웃() {
      
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

