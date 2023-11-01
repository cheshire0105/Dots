//
//  MainExhibitionCollectionCell.swift
//  Dots
//
//  Created by cheshire on 10/23/23.
//

import Foundation
import UIKit

// 새로운 셀 클래스를 정의합니다.
class MainExhibitionCollectionCell: UICollectionViewCell {

    var label: UILabel!
    var imageView: UIImageView!

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = .black  // 셀의 배경색을 검은색으로 설정
        contentView.backgroundColor = .black  // contentView의 배경색도 검은색으로 설정

        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)

        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(370)
        }

        label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.numberOfLines = 0
        label.textColor = .white  // 텍스트 색상을 하얀색으로 설정
        label.textAlignment = .right
        contentView.addSubview(label)

        label.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.centerY).offset(10)
            make.right.equalToSuperview().inset(50)
            make.width.equalTo(270)
            make.height.equalTo(100)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setImage(image: UIImage?) {
        imageView.image = image
    }
}
