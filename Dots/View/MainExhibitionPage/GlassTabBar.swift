//
//  GlassTabBar.swift
//  Dots
//
//  Created by cheshire on 10/23/23.
//

import UIKit

class GlassTabBar: UITabBar {

    private var effectView: UIVisualEffectView?

    override func layoutSubviews() {
        super.layoutSubviews()
        setupGlassEffect()
    }

    private func setupGlassEffect() {
        let tabBarHeight: CGFloat = 50.0
        let tabBarMargin: CGFloat = 30.0
        let cornerRadius: CGFloat = 15.0

        let path = UIBezierPath(roundedRect: CGRect(x: tabBarMargin, y: self.frame.height - tabBarHeight - tabBarMargin, width: self.frame.width - 2 * tabBarMargin, height: tabBarHeight), cornerRadius: cornerRadius)

        let shape = CAShapeLayer()
        shape.path = path.cgPath

        if effectView == nil {
            let blurEffect = UIBlurEffect(style: .regular)
            effectView = UIVisualEffectView(effect: blurEffect)
            effectView?.layer.cornerRadius = cornerRadius
            effectView?.layer.masksToBounds = true
            if let effectView = effectView {
                addSubview(effectView)
                sendSubviewToBack(effectView)
            }
        }

        effectView?.frame = CGRect(x: tabBarMargin, y: self.frame.height - tabBarHeight - tabBarMargin, width: self.frame.width - 2 * tabBarMargin, height: tabBarHeight)

        shape.fillColor = UIColor.clear.cgColor
        self.layer.insertSublayer(shape, at: 0)
    }
}

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 다섯 개의 뷰 컨트롤러 및 탭 아이템 설정
        let firstVC = MainExhibitionPage()
        firstVC.view.backgroundColor = .red
        firstVC.tabBarItem = UITabBarItem(title: "First", image: nil, tag: 0)

        let secondVC = SearchPage()
        secondVC.view.backgroundColor = .green
        secondVC.tabBarItem = UITabBarItem(title: "Second", image: nil, tag: 1)

        let thirdVC = PopularReviewsPage()
        thirdVC.view.backgroundColor = .blue
        thirdVC.tabBarItem = UITabBarItem(title: "Third", image: nil, tag: 2)

        let fourthVC = MapPage()
        fourthVC.view.backgroundColor = .yellow
        fourthVC.tabBarItem = UITabBarItem(title: "Fourth", image: nil, tag: 3)

        let fifthVC = Mypage()
        fifthVC.view.backgroundColor = .purple
        fifthVC.tabBarItem = UITabBarItem(title: "Fifth", image: nil, tag: 4)

        self.viewControllers = [firstVC, secondVC, thirdVC, fourthVC, fifthVC]

        // 커스텀 탭바 설정
        self.setValue(GlassTabBar(), forKey: "tabBar")
    }
}
