//
//  DetailAudioPage.swift
//  Dots
//
//  Created by cheshire on 11/14/23.
//

import Foundation
import UIKit

class DetailAudioPage: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white // 배경색을 흰색으로 설정합니다.
        setupCloseButton() // 닫기 버튼을 설정하는 메서드 호출
    }

    private func setupCloseButton() {
        let closeButton = UIButton(type: .system)
        closeButton.setTitle("Close", for: .normal) // 닫기 버튼의 타이틀 설정
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)

        view.addSubview(closeButton)
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-20)
        }
    }

    @objc private func closeButtonTapped() {
        dismiss(animated: true) // 현재 뷰 컨트롤러를 닫습니다.
    }
}

