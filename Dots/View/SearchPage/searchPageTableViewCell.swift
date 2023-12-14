//
//  searchPageTableViewCell.swift
//  Dots
//
//  Created by cheshire on 11/2/23.
// 최신화

import Foundation
import UIKit
import Firebase
import FirebaseStorage
import SDWebImage


class searchPageTableViewCell: UITableViewCell {

    let grayBox = UIView()
    let ExhibitionTitleLabel = UILabel()
    let museumLabel = UILabel()
    var popularCellImageView = UIImageView()
    let textCache = NSCache<NSString, NSString>()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViews()

        selectionStyle = .none  // 셀 선택 시 하이라이트 없음

    }

    override func prepareForReuse() {
         super.prepareForReuse()
         // 셀이 재사용될 때 초기화 작업을 수행합니다.
         popularCellImageView.image = nil
         ExhibitionTitleLabel.text = nil
         museumLabel.text = nil
         // SDWebImage 로딩 취소
         popularCellImageView.sd_cancelCurrentImageLoad()
     }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        self.backgroundColor = .black

        popularCellImageView.backgroundColor = .gray // 임시 배경색 설정
        popularCellImageView.layer.cornerRadius = 15 // 모서리 둥글게
           popularCellImageView.clipsToBounds = true    // 이미지가 뷰의 경계를 넘어가지 않도록
        popularCellImageView.contentMode = .scaleAspectFill // 이미지 콘텐츠 모드 설정

        contentView.addSubview(popularCellImageView)

        ExhibitionTitleLabel.textColor = .white
        ExhibitionTitleLabel.font = UIFont(name: "Pretendard-Regular", size: 20)
        ExhibitionTitleLabel.numberOfLines = 0
        contentView.addSubview(ExhibitionTitleLabel)

        museumLabel.textColor = .white
        museumLabel.font = UIFont(name: "Pretendard-Regular", size: 15)
        contentView.addSubview(museumLabel)


        // SnapKit을 사용하여 레이아웃 설정
        popularCellImageView.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(contentView).offset(15)
            make.width.equalTo(130)
            make.height.equalTo(180)
        }

        ExhibitionTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(popularCellImageView.snp.top).offset(20)
            make.leading.equalTo(popularCellImageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().inset(20)
        }

        museumLabel.snp.makeConstraints { make in
            make.top.equalTo(ExhibitionTitleLabel.snp.bottom).offset(10)
            make.leading.equalTo(ExhibitionTitleLabel)
            make.trailing.equalToSuperview().inset(20)
        }
    }

}
extension searchPageTableViewCell {
    func configure(with model: PopularCellModel) {
        ExhibitionTitleLabel.text = model.title
        museumLabel.text = model.subTitle
        loadImage(for: model.imageDocumentId)
    }

    private func loadImage(for documentId: String) {
        let imagePath = "images/\(documentId).png"
        let storageRef = Storage.storage().reference(withPath: imagePath)

        storageRef.downloadURL { [weak self] (url, error) in
            guard let self = self, let url = url, error == nil else {
                print("Error getting download URL: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            DispatchQueue.main.async {
                self.popularCellImageView.sd_setImage(with: url, placeholderImage: nil)
            }
        }
    }
}
