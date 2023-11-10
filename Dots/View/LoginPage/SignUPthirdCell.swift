import UIKit
import SnapKit

class 아티스트_리스트_셀: UICollectionViewCell {
    let 아티스트_이름: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 15
        layer.borderWidth = 1
        layer.borderColor = UIColor(named: "neon")?.cgColor
        backgroundColor = .clear
        
        셀_레이아웃()
    }
    
    func 셀_레이아웃() {
        addSubview(아티스트_이름)
        아티스트_이름.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

