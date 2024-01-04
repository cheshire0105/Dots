//
//  LaunchScreenViewController.swift
//  Dots
//
//  Created by cheshire on 11/5/23.
//

import Foundation
import UIKit

// LaunchScreenViewController.swift 파일에서
class LaunchScreenViewController: UIViewController {

    var completionHandler: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()


        // 여기에 런칭 이미지 또는 로고를 표시하는 코드를 추가합니다.
        view.backgroundColor = UIColor.black
        let imageView = UIImageView(frame: view.bounds)
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "AppIcon")
        view.addSubview(imageView)

        // 애니메이션 또는 추가 초기화 작업 후에 completionHandler를 호출합니다.
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            self?.completionHandler?()
        }
    }
}
