//
//  MainExhibitionCollectionCell.swift
//  Dots
//
//  Created by cheshire on 10/23/23.
//

import UIKit
import SDWebImage

// 새로운 셀 클래스를 정의합니다.
class MainExhibitionFirstSectionCollectionCell: UICollectionViewCell {

    var label: UILabel!
    var imageView: UIImageView!

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = .black  // 셀의 배경색을 검은색으로 설정
        contentView.backgroundColor = .black  // contentView의 배경색도 검은색으로 설정

        setupImageView()
        setupLabel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupImageView() {
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
    }

    private func setupLabel() {
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

    // 이미지를 로드하는 메소드를 추가합니다.
    func loadImage(with url: URL) {
        imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"), options: .continueInBackground, completed: nil)
    }
}
