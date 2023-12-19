//
//  GlassTabBar.swift
//  Dots
//
//  Created by cheshire on 10/23/23.
//  브랜치 생성 테스트 커밋 푸쉬 2023년 11월 18일 오후 11시 15분
//  최신화 머지 - dev 11월 19일 오전 12 : 28
//  최신화 머지 - dev 11월 20일 오전 1시 : 6분
//  최신화 머지 - dev 11월 20일 오후 9시 48분 - 철우님과 데브에서 만남....
//  테스트 2...

import UIKit

class TabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarItems()
        customizeTabBarAppearance()
    }

    func setupTabBarItems() {
        let firstVC = MainExhibitionPage()
        firstVC.tabBarItem = UITabBarItem(title: "전시", image: UIImage(named: "home"), tag: 0)

        let secondVC = SearchPage()
        secondVC.tabBarItem = UITabBarItem(title: "검색", image: UIImage(named: "search"), tag: 1)

//        let thirdVC = PopularReviewsPage()
//        thirdVC.tabBarItem = UITabBarItem(title: "인기", image: UIImage(named: "hot"), tag: 2)

//        let fourthVC = MapPage()
//        fourthVC.tabBarItem = UITabBarItem(title: "지도", image: UIImage(named: "map"), tag: 3)

        let fifthVC = Mypage()
        fifthVC.tabBarItem = UITabBarItem(title: "마이", image: UIImage(named: "mypage"), tag: 3)

        viewControllers = [firstVC, secondVC, fifthVC].map {
            UINavigationController(rootViewController: $0)
        }
    }

    func customizeTabBarAppearance() {
        // iOS 15 이상에서는 UITabBarAppearance를 사용합니다.
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .black

            // 선택되지 않은 탭 아이템의 색상
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray]
            // 선택된 탭 아이템의 색상
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            // 선택된 탭 아이템의 이미지 색상
            appearance.stackedLayoutAppearance.selected.iconColor = UIColor.white

            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        } else {
            // iOS 15 미만에서는 아래 코드를 사용합니다.
            tabBar.barTintColor = .black
            tabBar.tintColor = .white // 선택된 아이템의 색상 설정 (텍스트와 이미지 모두)
            tabBar.unselectedItemTintColor = .gray
        }
    }

}

