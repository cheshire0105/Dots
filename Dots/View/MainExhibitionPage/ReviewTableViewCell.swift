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
    let exhibitionPageReviewCellImage = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.backgroundColor = .black

        // UI 컴포넌트 추가
        contentView.addSubview(titleLabel)
        contentView.addSubview(contentLabel)
        contentView.addSubview(authorLabel)
        contentView.addSubview(exhibitionPageReviewCellImage)

        // 이미지 뷰의 레이아웃 설정 (오른쪽에 위치)
        exhibitionPageReviewCellImage.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.right.equalToSuperview().inset(10)
            make.width.height.equalTo(50)
        }

        // 레이블의 레이아웃 설정 (이미지 뷰의 왼쪽에 위치)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.left.equalToSuperview().inset(10)
            make.right.equalTo(exhibitionPageReviewCellImage.snp.left).offset(-10)
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
        titleLabel.textColor = .white

        contentLabel.font = UIFont.systemFont(ofSize: 14)
        contentLabel.textColor = .white

        authorLabel.font = UIFont.systemFont(ofSize: 12)
        authorLabel.textColor = .white
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with review: Review) {
        titleLabel.text = review.title
        contentLabel.text = review.content
        authorLabel.text = review.author
        exhibitionPageReviewCellImage.image = UIImage(named: review.imageName)
    }
}

struct Review {
    let title: String
    let content: String
    let author: String
    let imageName: String
}
