import UIKit
import SnapKit

class 미술관_리스트_셀: UICollectionViewCell {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    let 미술관_버튼 = {
        let button = UIButton()
        button.setTitle("", for: .selected)
        button.setTitle("", for: .normal)
        button.setTitleColor(UIColor(named: "neon"), for: .selected)
        button.setTitleColor(UIColor(named: "neon"), for: .normal)
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 15
        return button
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 15
        layer.borderWidth = 1
        layer.borderColor = UIColor(named: "neon")?.cgColor
        backgroundColor = .clear
        
        셀_레이아웃()
    }
    
    func 셀_레이아웃() {
        addSubview(미술관_버튼)
        미술관_버튼.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
