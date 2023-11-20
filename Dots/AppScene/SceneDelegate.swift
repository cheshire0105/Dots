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


}

