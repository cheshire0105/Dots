//
//  searchPageTableViewCell.swift
//  Dots
//
//  Created by cheshire on 11/2/23.
//

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

    func bindText(documentId: String) {
        if let cachedTitle = textCache.object(forKey: "\(documentId)-title" as NSString),
           let cachedMuseum = textCache.object(forKey: "\(documentId)-museum" as NSString) {
            // 캐시에서 데이터를 불러옵니다.
            DispatchQueue.main.async {
                self.ExhibitionTitleLabel.text = cachedTitle as String
                self.museumLabel.text = cachedMuseum as String
            }
            return
        }

        // Firestore에서 데이터를 가져오고 캐시에 저장
        let exhibitionDetailsRef = Firestore.firestore().collection("전시_상세").document(documentId)
        exhibitionDetailsRef.getDocument { [weak self] (document, error) in
            guard let self = self, let document = document, document.exists else {
                print("Document does not exist: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            let data = document.data()
            let exhibitionTitle = data?["전시_타이틀"] as? String ?? "Unknown Title"
            let museumName = data?["미술관_이름"] as? String ?? "Unknown Museum"

            // 캐시에 저장
            textCache.setObject(exhibitionTitle as NSString, forKey: "\(documentId)-title" as NSString)
            textCache.setObject(museumName as NSString, forKey: "\(documentId)-museum" as NSString)

            DispatchQueue.main.async {
                self.ExhibitionTitleLabel.text = exhibitionTitle
                self.museumLabel.text = museumName
            }
        }
    }



    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        self.backgroundColor = .black

        popularCellImageView.backgroundColor = .gray // 임시 배경색 설정
        popularCellImageView.layer.cornerRadius = 15 // 모서리 둥글게
           popularCellImageView.clipsToBounds = true    // 이미지가 뷰의 경계를 넘어가지 않도록
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
