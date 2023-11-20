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
        label.font = UIFont(name: "Pretendard-Bold", size: 40)
        label.numberOfLines = 0
        label.textColor = .white  // 텍스트 색상을 하얀색으로 설정
        label.textAlignment = .right
        contentView.addSubview(label)

        label.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.centerY).offset(10)
            make.left.right.equalToSuperview().inset(16) // 여백을 일관성 있게 유지합니다.
            // 고정된 높이 제약을 제거하고 레이블의 하단과 셀의 하단 간의 관계를 설정합니다.
            // 이는 레이블이 필요한 만큼의 높이를 가질 수 있도록 합니다.
            make.bottom.lessThanOrEqualToSuperview().inset(16) // 레이블의 하단이 셀의 하단에서 16pt의 여백을 가짐
        }

        
    }

    func configureCellLayout(isEven: Bool) {
        // 공통 제약 조건을 설정합니다.
        imageView.snp.remakeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(370)
        }

        // 짝수와 홀수 셀의 레이아웃을 다르게 설정합니다.
        if isEven {
            imageView.snp.makeConstraints { make in
                make.right.equalToSuperview()
                make.top.equalToSuperview()
            }
            label.textAlignment = .left
            label.snp.remakeConstraints { make in
                make.top.equalTo(imageView.snp.top).offset(30)
                make.left.equalToSuperview().offset(16)
                make.right.equalToSuperview().offset(-16)
            }
        } else {
            imageView.snp.makeConstraints { make in
                make.left.equalToSuperview()
                make.top.equalToSuperview()
            }
            label.textAlignment = .right
            label.snp.remakeConstraints { make in
                make.top.equalTo(imageView.snp.centerY).offset(-80)
                make.right.equalToSuperview().inset(16)
                make.left.equalToSuperview().offset(-16)
            }
        }
    }


}
