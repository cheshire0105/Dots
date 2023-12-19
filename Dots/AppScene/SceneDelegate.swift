//
//  SceneDelegate.swift
//  Dots
//
//  Created by cheshire on 10/23/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)
        // LaunchScreenViewController를 여기서 초기화합니다.
        let launchScreenVC = LaunchScreenViewController()

        // UserDefaults를 검사하여 로그인 여부를 확인합니다.
        if isUserLoggedIn() {
            // 로그인이 되어 있으면, 메인 탭 바를 설정합니다.
            launchScreenVC.completionHandler = { [weak self] in
                guard let self = self else { return }
                let mainTabBar = TabBar()
                self.window?.rootViewController = mainTabBar
            }
        } else {
            // 로그인이 되어 있지 않으면, 로그인/회원가입 뷰를 설정합니다.
            launchScreenVC.completionHandler = { [weak self] in
                guard let self = self else { return }
                let signUpVC = 로그인_회원가입_뷰컨트롤러()
                let navigationController = UINavigationController(rootViewController: signUpVC)
                self.window?.rootViewController = navigationController
            }
        }

        window?.rootViewController = launchScreenVC
        window?.makeKeyAndVisible()

        // 딥 링크 처리
        if let urlContext = connectionOptions.urlContexts.first {
            handleDeepLink(url: urlContext.url)
        }
    }


    private func handleDeepLink(url: URL) {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true),
              let host = components.host,
              let queryItems = components.queryItems,
              let posterImageName = queryItems.first(where: { $0.name == "poster" })?.value else {
            return
        }

        if host == "backgroundImage" {
            // 메인 탭 바 컨트롤러 생성
            let mainTabBar = TabBar()

            // 첫 번째 탭에 해당하는 네비게이션 컨트롤러를 가져옵니다.
            if let mainNavController = mainTabBar.viewControllers?.first as? UINavigationController {
                // MainExhibitionPage 인스턴스 생성 및 탭 아이템 설정
                let mainPage = MainExhibitionPage()
                mainPage.tabBarItem = UITabBarItem(title: "전시", image: UIImage(named: "home"), tag: 0)

                // 네비게이션 스택에 MainExhibitionPage 인스턴스를 루트로 설정
                mainNavController.viewControllers = [mainPage]

                // BackgroundImageViewController 설정 및 네비게이션 스택에 푸시
                let backgroundImageVC = BackgroundImageViewController()
                backgroundImageVC.posterImageName = posterImageName
                mainNavController.pushViewController(backgroundImageVC, animated: false)
            }

            // 탭 바 컨트롤러를 루트 뷰 컨트롤러로 설정
            window?.rootViewController = mainTabBar
            window?.makeKeyAndVisible()
        }
    }









    private func isUserLoggedIn() -> Bool {
        return UserDefaults.standard.bool(forKey: "isUserLoggedIn")
    }


    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else { return }
        handleDeepLink(url: url)


        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true),
              let host = components.host else {
            return
        }



    }


}

