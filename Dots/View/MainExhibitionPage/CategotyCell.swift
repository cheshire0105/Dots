//
//  CategotyCell.swift
//  Dots
//
//  Created by cheshire on 10/23/23.
//

import Foundation
import UIKit

class CategotyCell: UICollectionViewCell {
    var label: UILabel!

    override var isSelected: Bool {
        didSet {
            updateBackgroundColor()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
    }

    private func setupCell() {
        label = UILabel()
        contentView.addSubview(label)
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name: "Pretendard-Regular", size: 14)
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        contentView.layer.borderWidth = 0.7
        contentView.layer.borderColor = UIColor.white.cgColor
        updateBackgroundColor()
    }


    private func updateBackgroundColor() {
        contentView.backgroundColor = isSelected ? .darkGray : .black
        contentView.layer.cornerRadius = 17  // 모서리 둥근 효과 추가
    }

}

