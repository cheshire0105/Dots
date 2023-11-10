//
//  ExhibitionPageTwo.swift
//  Dots
//
//  Created by cheshire on 11/10/23.
//

import Foundation

import UIKit

class BackgroundImageViewController: UIViewController, UIGestureRecognizerDelegate {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presentModalViewController() // 뷰가 나타날 때 모달을 바로 표시합니다.
    }

    override func viewDidLoad() {

        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        super.viewDidLoad()
        // 배경으로 사용할 이미지 뷰를 설정합니다.
        let backgroundImageView = UIImageView(frame: self.view.bounds)
        backgroundImageView.image = UIImage(named: "ExhibitionPageBack")
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
        self.view.addSubview(backgroundImageView)
    }

    @objc func presentModalViewController() {
        // 상세 내용을 담은 뷰 컨트롤러를 생성하고 모달로 표시합니다.
        let detailViewController = DetailViewController()
        presentDetailViewController(detailViewController)
    }

    private func presentDetailViewController(_ detailViewController: DetailViewController) {
        if let sheetController = detailViewController.presentationController as? UISheetPresentationController {
            // 사용자 정의 detent 생성
            let detentIdentifier = UISheetPresentationController.Detent.Identifier("customDetent")
            let customDetent = UISheetPresentationController.Detent.custom(identifier: detentIdentifier) { _ in
                // safe area bottom을 구하기 위한 선언.
                let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                let safeAreaBottom = windowScene?.windows.first?.safeAreaInsets.bottom ?? 0

                // 모든 기기에서 항상 높이가 700인 detent를 만들어낼 수 있다.
                return 700 - safeAreaBottom
            }

            // 중간 높이와 사용자 정의 높이를 포함하는 detent 설정
            sheetController.detents = [.medium(), customDetent]
            sheetController.largestUndimmedDetentIdentifier = detentIdentifier // 최대 높이를 커스텀 detent로 설정합니다.
            sheetController.prefersScrollingExpandsWhenScrolledToEdge = true // 스크롤할 때 시트가 확장되도록 설정합니다.
            sheetController.preferredCornerRadius = 30 // 둥근 모서리 설정을 유지합니다.
        }

        // 모달 표시 설정
        detailViewController.modalPresentationStyle = .pageSheet
        self.present(detailViewController, animated: true, completion: nil)
    }


}

class DetailViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // 여기에 상세 내용을 나타내는 UI 구성 요소를 추가합니다.
    }
}
