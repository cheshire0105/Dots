import UIKit
import SnapKit

class 아티스트_리스트_셀: UICollectionViewCell {
    let 아티스트_이름: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor(named: "neon")
        label.backgroundColor = UIColor.green.withAlphaComponent(0.4)
        label.numberOfLines = 0
        label.clipsToBounds = true
        return label
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = frame.size.width / 2
        layer.cornerRadius = frame.size.height / 2
              layer.borderWidth = 1
              layer.borderColor = UIColor(named: "neon")?.cgColor
              backgroundColor = .clear
        
        셀_레이아웃()
    }
    
    func 셀_레이아웃() {
        contentView.addSubview(아티스트_이름)
        아티스트_이름.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            아티스트_이름.contentMode = .scaleAspectFit

        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

