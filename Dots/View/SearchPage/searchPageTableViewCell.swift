//
//  searchPageTableViewCell.swift
//  Dots
//
//  Created by cheshire on 11/2/23.
//

import Foundation
import UIKit
import FirebaseStorage
import SDWebImage


class searchPageTableViewCell: UITableViewCell {

    let grayBox = UIView()
    let titleLabel = UILabel()
    let contentLabel = UILabel()
    var popularCellImageView = UIImageView()


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViews()
    }

    func loadImage(documentId: String) {
        let imagePath = "images/\(documentId).png" // Firebase Storage의 경로
        let storageRef = Storage.storage().reference(withPath: imagePath)

        // Firebase Storage URL을 얻기 위한 메서드
        storageRef.downloadURL { [weak self] (url, error) in
            guard let self = self else { return }
            if let error = error {
                print("Error getting download URL: \(error)")
                return
            }
            guard let downloadURL = url else {
                print("Download URL not found for document ID: \(documentId)")
                return
            }

            // SDWebImage를 사용하여 이미지 로드
            self.popularCellImageView.sd_setImage(with: downloadURL, placeholderImage: nil, options: [], completed: { (image, error, cacheType, url) in
                if let error = error {
                    print("Error downloading image: \(error.localizedDescription)")
                } else {
                    print("Image downloaded successfully for document ID: \(documentId)")
                }
            })
        }
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        self.backgroundColor = .black

        popularCellImageView.backgroundColor = .gray // 임시 배경색 설정
        contentView.addSubview(popularCellImageView)

        titleLabel.textColor = .white
        contentView.addSubview(titleLabel)

        contentLabel.textColor = .white
        contentView.addSubview(contentLabel)


        // SnapKit을 사용하여 레이아웃 설정
        popularCellImageView.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(contentView).offset(15)
            make.width.equalTo(130)
            make.height.equalTo(180)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(popularCellImageView.snp.top).offset(50)
            make.leading.equalTo(popularCellImageView.snp.trailing).offset(10)
        }

        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.equalTo(titleLabel)
        }
    }

}
