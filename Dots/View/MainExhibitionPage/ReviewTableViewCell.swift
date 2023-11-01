//
//  ReviewTableViewCell.swift
//  Dots
//
//  Created by cheshire on 11/1/23.
//

import Foundation
import UIKit
import SnapKit

class ReviewTableViewCell: UITableViewCell {

    let titleLabel = UILabel()
    let contentLabel = UILabel()
    let authorLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        // UI 컴포넌트 추가 및 레이아웃 설정
        contentView.addSubview(titleLabel)
        contentView.addSubview(contentLabel)
        contentView.addSubview(authorLabel)

        titleLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview().inset(10)
            make.right.equalToSuperview().inset(10)
        }

        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.right.equalTo(titleLabel)
        }

        authorLabel.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(10)
            make.left.right.equalTo(contentLabel)
            make.bottom.equalToSuperview().inset(10)
        }

        // 스타일 설정
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        contentLabel.font = UIFont.systemFont(ofSize: 14)
        authorLabel.font = UIFont.systemFont(ofSize: 12)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with review: Review) {
        titleLabel.text = review.title
        contentLabel.text = review.content
        authorLabel.text = review.author
    }
}

struct Review {
    let title: String
    let content: String
    let author: String
}
