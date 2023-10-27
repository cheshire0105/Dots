//
//  ExhibitionPage.swift
//  Dots
//
//  Created by cheshire on 10/27/23.
//

import UIKit
import SnapKit

class ExhibitionPage: UIViewController {

    // 스크롤 뷰와 콘텐츠 뷰를 정의합니다.
    let scrollView = UIScrollView()
    let contentView = UIView()
    let exhibitionImageView = UIImageView() // 이미지 뷰를 정의합니다.
    let titleLabel = UILabel()
    let galleryButtonLabel = UILabel()

    let iconImageView = UIImageView()
    let descriptionLabel = UILabel()
    let stackView = UIStackView()

    let iconImageViewTwo = UIImageView()
    let descriptionLabelTwo = UILabel()
    let stackViewTwo = UIStackView()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(false, animated: animated)
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        // 네비게이션 바의 배경을 투명하게 설정
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true

        self.view.backgroundColor = .black

        setupBackButton()
        setupRightBarButton()

        setupScrollView()
        setupExhibitionImage()

    }

    private func setupExhibitionImage() {
        // 이미지 뷰를 contentView에 추가합니다.
        contentView.addSubview(exhibitionImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(galleryButtonLabel)

        stackView.addArrangedSubview(iconImageView)
        stackView.addArrangedSubview(descriptionLabel)
        contentView.addSubview(stackView)

        stackViewTwo.addArrangedSubview(iconImageViewTwo)
        stackViewTwo.addArrangedSubview(descriptionLabelTwo)
        contentView.addSubview(stackViewTwo)


        // 이미지 뷰의 제약 조건을 설정합니다.
        exhibitionImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView) // 상단에서 16픽셀 떨어진 위치에 배치
            make.left.equalTo(contentView) // 왼쪽에서 16픽셀 떨어진 위치에 배치
            make.right.equalTo(contentView) // 오른쪽에서 16픽셀 떨어진 위치에 배치
            make.height.equalTo(400)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(200) // 이미지 아래에 10픽셀 떨어진 위치에 배치
            make.left.equalTo(contentView).offset(16) // 왼쪽에서 16픽셀 떨어진 위치에 배치
            make.right.equalTo(contentView).offset(-16) // 오른쪽에서 16픽셀 떨어진 위치에 배치
        }

        galleryButtonLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(13) // titleLabel 아래에 20픽셀 떨어진 위치에 배치
            make.left.equalTo(contentView).offset(16) // 왼쪽에서 16픽셀 떨어진 위치에 배치
            make.right.equalTo(contentView).offset(-16) // 오른쪽에서 16픽셀 떨어진 위치에 배치
        }

        stackView.snp.makeConstraints { make in
            make.top.equalTo(galleryButtonLabel.snp.bottom).offset(13)
            make.left.equalTo(contentView).offset(16)
            make.right.lessThanOrEqualTo(contentView).offset(-16)
        }

        stackViewTwo.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(13)
            make.left.equalTo(contentView).offset(16)
            make.right.lessThanOrEqualTo(contentView).offset(-16)
        }

        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center

        stackViewTwo.axis = .horizontal
        stackViewTwo.spacing = 10
        stackViewTwo.alignment = .center


        // 이미지 뷰에 이미지를 설정합니다. (원하는 이미지로 변경하실 수 있습니다.)
        exhibitionImageView.image = UIImage(named: "ExhibitionPageBack")
        exhibitionImageView.contentMode = .scaleAspectFill // 이미지의 콘텐츠 모드를 설정합니다.
        exhibitionImageView.clipsToBounds = true

        titleLabel.text = "리암 길릭 : The Alterants"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24) // 폰트 크기를 24로 설정하고 볼드체로 지정
        titleLabel.textColor = .white

        galleryButtonLabel.text = "갤러리바튼"
        galleryButtonLabel.font = UIFont.systemFont(ofSize: 16) // 폰트 크기를 20로 설정하고 일반 체로 지정
        galleryButtonLabel.textColor = .white
        
        iconImageView.image = UIImage(named: "exhibitionGeoIcon")
        iconImageView.contentMode = .scaleAspectFit
        descriptionLabel.text = "서울 종로구 삼청로 30"
        descriptionLabel.font = UIFont.systemFont(ofSize: 12)
        descriptionLabel.textColor = .white

        iconImageViewTwo.image = UIImage(named: "exhibitionCalendarIcon")
        iconImageViewTwo.contentMode = .scaleAspectFit
        descriptionLabelTwo.text = "~ 2024.02.12"
        descriptionLabelTwo.font = UIFont.systemFont(ofSize: 12)
        descriptionLabelTwo.textColor = .white
    }

    // 스크롤 뷰 설정
    private func setupScrollView() {
        // 스크롤 뷰를 뷰에 추가
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview() // 스크롤 뷰를 전체 화면으로 설정
        }

        // 콘텐츠 뷰를 스크롤 뷰에 추가
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.top.equalTo(view) // 변경된 부분: 콘텐츠 뷰의 상단을 뷰의 상단에 맞춤
            make.left.right.bottom.equalToSuperview()
            make.width.equalTo(scrollView) // 콘텐츠 뷰의 너비를 스크롤 뷰의 너비와 같게 설정
        }
    }




    private func setupBackButton() {
        let backButtonImage = UIImage(named: "backButton")
        let backButton = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(backButtonTapped))
        backButton.tintColor = .white
        navigationItem.leftBarButtonItem = backButton
    }

    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

    private func setupRightBarButton() {
        let rightButtonImage = UIImage(named: "audioGuide")
        let rightButton = UIBarButtonItem(image: rightButtonImage, style: .plain, target: self, action: #selector(rightButtonTapped))
        rightButton.tintColor = .white
        navigationItem.rightBarButtonItem = rightButton
    }

    @objc func rightButtonTapped() {
    }
}
