//
//  선별_전시_컬렉션_셀.swift
//  Dots
//
//  Created by cheshire on 11/8/23.
// 폰트 수정 시작.

import Foundation
import UIKit

class 선별_전시_컬렉션_셀: UICollectionViewCell {

    var imageView: UIImageView!
    var titleLabel: UILabel!
    var dateLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)

        imageView = UIImageView()
        titleLabel = UILabel()
        dateLabel = UILabel()

        // SnapKit을 사용해 이미지 뷰를 추가합니다.
        imageView.backgroundColor = .gray
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(imageView.snp.width) // 가로 세로 비율 1:1로 설정
        }

        // 타이틀 레이블 설정
        titleLabel.font = .boldSystemFont(ofSize: 16)
        titleLabel.text = "올해의 전시"
        titleLabel.textColor = .white
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(10)
        }

        // 날짜 레이블 설정
        dateLabel.font = .systemFont(ofSize: 14)
        dateLabel.text = "2023. 12. 34 ~ 2024. 12. 34"
        dateLabel.textColor = .lightGray
        contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.lessThanOrEqualToSuperview().offset(-10)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class 선별_전시_컬렉션_셀_헤더: UICollectionReusableView {
    let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)

        // 폰트 사이즈와 스타일 설정
        label.font = UIFont.boldSystemFont(ofSize: 20) // 여기에서 폰트 사이즈와 스타일을 조정합니다.

        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .left
        label.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true // 왼쪽 정렬
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

