import SnapKit
import UIKit
class PopularReviewDetailPanModalCell: UITableViewCell {
    
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.blue
        
        
        
        
    }
    
    convenience init() {
        self.init(style: .default, reuseIdentifier: "youtubeCell")
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
