//
//  ExhibitionPage.swift
//  Dots
//
//  Created by cheshire on 10/27/23.
//

import UIKit
import SnapKit

class ExhibitionPage: UIViewController {




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
