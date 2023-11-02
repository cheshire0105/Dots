//
//  searchPageTableViewCell.swift
//  Dots
//
//  Created by cheshire on 11/2/23.
//

import Foundation
import UIKit

class searchPageTableViewCell: UITableViewCell {

    let grayBox = UIView()
    let titleLabel = UILabel()
    let contentLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        self.backgroundColor = .black  // 셀의 배경색을 검정색으로 설정

        grayBox.backgroundColor = .gray
        contentView.addSubview(grayBox)

        titleLabel.textColor = .white
        contentView.addSubview(titleLabel)

        contentLabel.textColor = .white
        contentView.addSubview(contentLabel)

        // SnapKit을 사용하여 레이아웃 설정
        grayBox.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(contentView).offset(15)
            make.width.equalTo(130)
            make.height.equalTo(180)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(grayBox.snp.top).offset(50)
            make.leading.equalTo(grayBox.snp.trailing).offset(10)
        }

        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.equalTo(titleLabel)
        }
    }
}
