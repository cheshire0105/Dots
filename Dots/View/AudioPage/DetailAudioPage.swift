//
//  DetailAudioPage.swift
//  Dots
//
//  Created by cheshire on 11/14/23.
//

import UIKit
import SnapKit

class DetailAudioPage: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white // 배경색을 흰색으로 설정합니다.
        setupCloseButton() // 닫기 버튼을 설정하는 메서드 호출
    }

    private func setupCloseButton() {
        // 'closeButton'을 이미지 버튼으로 설정합니다.
        let closeButton = UIButton(type: .custom)
        if let image = UIImage(named: "Vector") { // 'closeIcon'은 닫기 버튼으로 사용할 이미지의 이름입니다.
            closeButton.setImage(image, for: .normal)
        }
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)

        view.addSubview(closeButton)
        closeButton.snp.makeConstraints { make in
            // SnapKit을 사용하여 'closeButton'의 제약 조건을 설정합니다.
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(20)
            make.width.height.equalTo(30) // 버튼의 너비와 높이를 설정합니다.
        }
    }

    @objc private func closeButtonTapped() {
        dismiss(animated: true, completion: nil) // 현재 뷰 컨트롤러를 닫습니다.
    }
}
