
import Foundation
import UIKit

class MyPageTicketCell : UICollectionViewCell {
   
   
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.orange
        layer.borderWidth = 30
        layer.cornerRadius = 60
        
        
        
        
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
