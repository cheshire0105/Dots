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

        let buttons = self.subviews.filter { $0 is UIControl } as! [UIControl]

        if buttons.count == 5 {
            let spacing: CGFloat = -20.0 // 이 값을 조절하여 탭바 아이템 간의 간격을 조절합니다.
            let totalButtonWidth = self.frame.width - (spacing * CGFloat(buttons.count - 1))
            let buttonWidth = totalButtonWidth / CGFloat(buttons.count)

            var x: CGFloat = 0
            for button in buttons {
                button.frame = CGRect(x: x, y: button.frame.origin.y, width: buttonWidth, height: button.frame.height)
                x += buttonWidth + spacing
            }
        }

        setupGlassEffect()
    }


    private func setupGlassEffect() {
        let tabBarHeight: CGFloat = 60.0
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

        setupTabBarItems()

        // 커스텀 탭바 설정
        self.setValue(GlassTabBar(), forKey: "tabBar")
    }

    // MARK: - TabBar Item Setup
    func setupTabBarItems() {

        let imageYOffset: CGFloat = -2.0
        let titleYOffset: CGFloat = 2.0

        let firstVC = MainExhibitionPage()
        firstVC.view.backgroundColor = .red
        firstVC.tabBarItem = UITabBarItem(title: "홈", image: UIImage(named: "home"), tag: 0)
        firstVC.tabBarItem.imageInsets = UIEdgeInsets(top: imageYOffset, left: 0, bottom: -imageYOffset, right: 0)
        firstVC.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: titleYOffset)

        // 동일한 방식으로 다른 뷰 컨트롤러의 탭바 아이템에도 적용
        let secondVC = SearchPage()
        secondVC.view.backgroundColor = .green
        secondVC.tabBarItem = UITabBarItem(title: "검색", image: UIImage(named: "search"), tag: 1)
        secondVC.tabBarItem.imageInsets = UIEdgeInsets(top: imageYOffset, left: 0, bottom: -imageYOffset, right: 0)
        secondVC.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: titleYOffset)

        let thirdVC = PopularReviewsPage()
        thirdVC.view.backgroundColor = .blue
        thirdVC.tabBarItem = UITabBarItem(title: "인기", image: UIImage(named: "hot"), tag: 2)
        thirdVC.tabBarItem.imageInsets = UIEdgeInsets(top: imageYOffset, left: 0, bottom: -imageYOffset, right: 0)
        thirdVC.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: titleYOffset)

        let fourthVC = MapPage()
        fourthVC.view.backgroundColor = .yellow
        fourthVC.tabBarItem = UITabBarItem(title: "지도", image: UIImage(named: "map"), tag: 3)
        fourthVC.tabBarItem.imageInsets = UIEdgeInsets(top: imageYOffset, left: 0, bottom: -imageYOffset, right: 0)
        fourthVC.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: titleYOffset)

        let fifthVC = Mypage()
        fifthVC.view.backgroundColor = .purple
        fifthVC.tabBarItem = UITabBarItem(title: "마이", image: UIImage(named: "mypage"), tag: 4)
        fifthVC.tabBarItem.imageInsets = UIEdgeInsets(top: imageYOffset, left: 0, bottom: -imageYOffset, right: 0)
        fifthVC.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: titleYOffset)


        self.viewControllers = [firstVC, secondVC, thirdVC, fourthVC, fifthVC]
    }
}

