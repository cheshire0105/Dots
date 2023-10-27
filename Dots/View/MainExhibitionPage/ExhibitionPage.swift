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

        setupBackButton()
        setupRightBarButton()

        setupScrollView()
        setupExhibitionImage()

    }

    private func setupExhibitionImage() {
        // 이미지 뷰를 contentView에 추가합니다.
        contentView.addSubview(exhibitionImageView)

        // 이미지 뷰의 제약 조건을 설정합니다.
        exhibitionImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView) // 상단에서 16픽셀 떨어진 위치에 배치
            make.left.equalTo(contentView) // 왼쪽에서 16픽셀 떨어진 위치에 배치
            make.right.equalTo(contentView) // 오른쪽에서 16픽셀 떨어진 위치에 배치
            make.height.equalTo(400)
        }

        // 이미지 뷰에 이미지를 설정합니다. (원하는 이미지로 변경하실 수 있습니다.)
        exhibitionImageView.image = UIImage(named: "ExhibitionPageBack")
        exhibitionImageView.contentMode = .scaleAspectFill // 이미지의 콘텐츠 모드를 설정합니다.
        exhibitionImageView.clipsToBounds = true
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
        // 여기에 원하는 액션을 추가합니다.
    }
}
