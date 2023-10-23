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
    var imageView: UIImageView! // 이미지 뷰를 추가

    override init(frame: CGRect) {
        super.init(frame: frame)

//        contentView.backgroundColor = .gray // 셀의 배경색을 회색으로 설정

        // 이미지 뷰를 설정
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)

        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview() // 이미지를 셀의 왼쪽에 붙입니다.
            make.width.equalTo(200)
            make.height.equalTo(370)
        }

        label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.numberOfLines = 0  // 여러 줄의 텍스트를 표시하도록 설정
        label.textColor = .white
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

    // 이미지를 설정하는 메소드를 추가
    func setImage(image: UIImage?) {
        imageView.image = image
    }
}


