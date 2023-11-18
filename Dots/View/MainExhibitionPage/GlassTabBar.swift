//
//  GlassTabBar.swift
//  Dots
//
//  Created by cheshire on 10/23/23.
//  브랜치 생성 테스트 커밋 푸쉬 2023년 11월 18일 오후 11시 15분

import UIKit

class GlassTabBar: UITabBarController {
    let customTabBarView = UIView()
    let stackView = UIStackView()
    
//    let titles = ["홈", "검색", "인기", "지도", "마이"]
    let images = [UIImage(named: "home"), UIImage(named: "search"), UIImage(named: "hot"), UIImage(named: "map"), UIImage(named: "mypage")]
    let backgroundView = UIView() // 스택뷰의 백그라운드 뷰
    
    lazy var buttons: [UIButton] = {
        var buttons: [UIButton] = []
        for i in 0 ..< 5 {
            let button = UIButton()
//            button.setTitle(titles[i], for: .normal)
            
            let originalImage = images[i]?.withRenderingMode(.alwaysOriginal)
            button.setImage(originalImage, for: .normal)
            button.setImage(originalImage, for: .selected) // 동일한 이미지를 선택 상태에도 설정
            button.backgroundColor = .clear // 초기 배경색 설정
            
            // Set text font size
            button.titleLabel?.font = UIFont.systemFont(ofSize: 12) // Adjust the font size as desired
            
            button.setTitleColor(.white, for: .normal)
            
            let imageSize = button.imageView!.intrinsicContentSize
//            let titleSize = button.titleLabel!.intrinsicContentSize
            
            let spacing: CGFloat = 10 // Adjust this value to increase or decrease the spacing

            button.titleEdgeInsets = UIEdgeInsets(top: imageSize.height + spacing, left: -imageSize.width, bottom: 0, right: 0)
//            button.imageEdgeInsets = UIEdgeInsets(top: -titleSize.height - spacing, left: 0, bottom: 0, right: -titleSize.width)
            
            buttons.append(button)
        }
        return buttons
    }()

    override func viewWillAppear(_ animated: Bool) {
        updateTabBarAppearance() // 여기에 추가

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabBarItems()
        setupCustomTabBarView()
    }

    
    func setupTabBarItems() {
        let firstVC = MainExhibitionPage()
        firstVC.view.backgroundColor = .black
        let firstNavController = UINavigationController(rootViewController: firstVC) // 이 줄을 추가합니다.
        
        
        let secondVC = SearchPage()
        
        secondVC.view.backgroundColor = .black
        
        let thirdVC = PopularReviewsPage()
        let thirdNavController = UINavigationController(rootViewController: thirdVC)
        
        let fourthVC = MapPage()
        fourthVC.view.backgroundColor = .yellow
        
        let fifthVC = Mypage()
        let fifthNavController = UINavigationController(rootViewController: fifthVC)
        
        viewControllers = [firstNavController, secondVC, thirdNavController, fourthVC, fifthNavController]
    }
    
    func setupCustomTabBarView() {
        // 기본 탭바 숨기기
        tabBar.isHidden = true

        let tabBarWidth = view.frame.width * 0.8 // 전체 너비의 80%
            let tabBarX = (view.frame.width - tabBarWidth) / 2 // 중앙 정렬

        customTabBarView.backgroundColor = .clear
           customTabBarView.frame = CGRect(x: tabBarX, y: view.frame.height - 80, width: tabBarWidth, height: 70)
           view.addSubview(customTabBarView)

        // 글래스 모피즘(Glassmorphism) 효과 추가
        let blurEffect = UIBlurEffect(style: .dark) // 또는 .light, .extraLight, .dark 중 선택
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.layer.cornerRadius = 25
        visualEffectView.layer.masksToBounds = true
        visualEffectView.translatesAutoresizingMaskIntoConstraints = false
        customTabBarView.addSubview(visualEffectView)
        
        // 글래스 모피즘 효과를 강화하기 위해 블러 뷰의 알파 값을 조정할 수 있습니다.
        visualEffectView.alpha = 0.8 // 이 값을 조정하여 불투명도를 변경하세요.
        
        // 반사 효과를 추가하고 싶다면, 여기에 그라디언트 레이어를 추가하거나 반사 이미지를 사용할 수 있습니다.
        // 예를 들어, 그라디언트 레이어를 추가하는 코드는 다음과 같습니다.
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = visualEffectView.bounds
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.white.withAlphaComponent(0.2).cgColor, UIColor.clear.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        gradientLayer.locations = [0, 0.5, 1] // 이 값들을 조정하여 그라디언트의 위치를 변경하세요.
        visualEffectView.layer.addSublayer(gradientLayer)
        
        // 스택뷰의 백그라운드 뷰 설정
        backgroundView.layer.cornerRadius = 25
        backgroundView.backgroundColor = .clear // 변경: 배경을 투명하게 설정
        backgroundView.layer.shadowColor = UIColor.black.cgColor
        backgroundView.layer.shadowOpacity = 0.1
        backgroundView.layer.shadowOffset = CGSize(width: 0, height: -1)
        backgroundView.layer.shadowRadius = 4
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        customTabBarView.addSubview(backgroundView)
        
        // 스택뷰 설정
        stackView.axis = .horizontal 
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        customTabBarView.addSubview(stackView)
        
        // 제약 조건 설정
        NSLayoutConstraint.activate([
            visualEffectView.topAnchor.constraint(equalTo: customTabBarView.topAnchor, constant: 10),
            visualEffectView.bottomAnchor.constraint(equalTo: customTabBarView.bottomAnchor, constant: -10),
            visualEffectView.leadingAnchor.constraint(equalTo: customTabBarView.leadingAnchor, constant: 30),
            visualEffectView.trailingAnchor.constraint(equalTo: customTabBarView.trailingAnchor, constant: -30),
            
            backgroundView.topAnchor.constraint(equalTo: visualEffectView.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: visualEffectView.bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: visualEffectView.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: visualEffectView.trailingAnchor),
            
            stackView.topAnchor.constraint(equalTo: backgroundView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor)
        ])
        
        for (index, button) in buttons.enumerated() {
            stackView.addArrangedSubview(button)
            button.addTarget(self, action: #selector(tabBarButtonTapped(_:)), for: .touchUpInside)
            button.tag = index
            
            button.heightAnchor.constraint(equalToConstant: 70).isActive = true

            // 첫 번째 버튼의 왼쪽 모서리만 둥글게 설정
            if index == 0 {
                button.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
                button.layer.cornerRadius = 25
            }
            // 마지막 버튼의 오른쪽 모서리만 둥글게 설정
            else if index == 5 - 1 {
                button.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
                button.layer.cornerRadius = 25
            }
        }
    }
    
    @objc func tabBarButtonTapped(_ sender: UIButton) {
        selectedIndex = sender.tag
        updateTabBarAppearance()
    }
    
    func updateTabBarAppearance() {
        for (index, button) in buttons.enumerated() {
            if index == selectedIndex {
                button.isSelected = true
                button.backgroundColor = .white // 선택된 탭의 배경색

                // 원형 배경 설정
                button.layer.cornerRadius = button.frame.height / 2
                button.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
                button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            } else {
                button.isSelected = false
                button.backgroundColor = UIColor(red: 0.145, green: 0.145, blue: 0.145, alpha: 0.55) // 기본 배경색

                // 원래 모양으로 되돌리기
                if index == 0 {
                    button.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
                } else if index == buttons.count - 1 {
                    button.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
                } else {
                    button.layer.maskedCorners = []
                }
                button.layer.cornerRadius = 25 // 원래 모서리 둥글기 값
                // 이미지와 텍스트 간격 재조정
                let imageSize = button.imageView!.intrinsicContentSize
                let spacing: CGFloat = 10
                button.titleEdgeInsets = UIEdgeInsets(top: imageSize.height + spacing, left: -imageSize.width, bottom: 0, right: 0)
            }
        }
    }

    
    
}

import SwiftUI
import UIKit

// UIKit의 GlassTabBar를 SwiftUI에서 사용할 수 있도록 래핑하는 뷰
struct GlassTabBarWrapper: UIViewControllerRepresentable {
    typealias UIViewControllerType = GlassTabBar

    // SwiftUI에서 UIViewController를 생성합니다.
    func makeUIViewController(context: Context) -> GlassTabBar {
        return GlassTabBar()
    }

    // UIViewController를 업데이트합니다.
    func updateUIViewController(_ uiViewController: GlassTabBar, context: Context) {
        // 필요한 업데이트 로직을 추가합니다.
    }
}

// SwiftUI 프리뷰
struct GlassTabBarWrapper_Previews: PreviewProvider {
    static var previews: some View {
        GlassTabBarWrapper()
    }
}

// cn0105@naver.com
// 111111!
