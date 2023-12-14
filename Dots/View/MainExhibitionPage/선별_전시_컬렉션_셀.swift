//
//  선별_전시_컬렉션_셀.swift
//  Dots
//
//  Created by cheshire on 11/8/23.
// 폰트 수정 시작.

import Foundation
import UIKit
import FirebaseStorage

class 선별_전시_컬렉션_셀: UICollectionViewCell {

    var imageView: UIImageView!
    var titleLabel: UILabel!
    var dateLabel: UILabel!

    override func prepareForReuse() {
          super.prepareForReuse()
          imageView.image = nil
          titleLabel.text = nil
      }

    override init(frame: CGRect) {
        super.init(frame: frame)



        imageView = UIImageView()
        titleLabel = UILabel()
        dateLabel = UILabel()

        // SnapKit을 사용해 이미지 뷰를 추가합니다.
        imageView.backgroundColor = .gray
        imageView.layer.cornerRadius = 15 // 모서리 둥글게
        imageView.clipsToBounds = true    // 이미지가 뷰의 경계를 넘어가지 않도록
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8) // 화면 폭의 80%
            make.height.equalTo(imageView.snp.width).multipliedBy(1.41) // 가로 세로 비율 1:1.41로 설정
        }


        // 타이틀 레이블 설정
        titleLabel.font =  UIFont(name: "Pretendard-Regular", size: 16)
        titleLabel.text = "올해의 전시"
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 2
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
        }

        // 날짜 레이블 설정
        dateLabel.font = UIFont(name: "Pretendard-Regular", size: 12)
        dateLabel.text = "2023. 12. 34 ~ 2024. 12. 34"
        dateLabel.numberOfLines = 0 
        dateLabel.textColor = .lightGray
        contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.bottom.lessThanOrEqualToSuperview().offset(-10)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var currentImageName: String?

    func configure(with exhibition: ExhibitionModel) {
        titleLabel.text = exhibition.title
        currentImageName = exhibition.poster
        loadImage(for: imageView, with: exhibition.poster)
    }

    private func loadImage(for imageView: UIImageView, with imageName: String) {
        let storageRef = Storage.storage().reference(withPath: "images/\(imageName).png")
        storageRef.downloadURL { [weak self] (url, error) in
            guard let url = url, error == nil else {
                print("이미지 다운로드 URL 가져오기 실패: \(error?.localizedDescription ?? "알 수 없는 오류")")
                return
            }
            DispatchQueue.main.async {
                if self?.currentImageName == imageName {
                    imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
                }
            }
        }
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

