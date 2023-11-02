//
//  GlassTabBar.swift
//  Dots
//
//  Created by cheshire on 10/23/23.
//

import UIKit

class GlassTabBar: UITabBarController {
    let customTabBarView = UIView()
    let stackView = UIStackView()
    
    let titles = ["홈", "검색", "인기", "지도", "마이"]
    let images = [UIImage(named: "home"), UIImage(named: "search"), UIImage(named: "hot"), UIImage(named: "map"), UIImage(named: "mypage")]
    let backgroundView = UIView() // 스택뷰의 백그라운드 뷰
    
    lazy var buttons: [UIButton] = {
        var buttons: [UIButton] = []
        for i in 0 ..< titles.count {
            let button = UIButton()
            button.setTitle(titles[i], for: .normal)
            
            let originalImage = images[i]?.withRenderingMode(.alwaysOriginal)
            button.setImage(originalImage, for: .normal)
            button.setImage(originalImage, for: .selected) // 동일한 이미지를 선택 상태에도 설정
            button.backgroundColor = .clear // 초기 배경색 설정
            
            // Set text font size
            button.titleLabel?.font = UIFont.systemFont(ofSize: 12) // Adjust the font size as desired
            
            button.setTitleColor(.white, for: .normal)
            
            let imageSize = button.imageView!.intrinsicContentSize
            let titleSize = button.titleLabel!.intrinsicContentSize
            
            let spacing: CGFloat = 10 // Adjust this value to increase or decrease the spacing
            
            button.titleEdgeInsets = UIEdgeInsets(top: imageSize.height + spacing, left: -imageSize.width, bottom: 0, right: 0)
            button.imageEdgeInsets = UIEdgeInsets(top: -titleSize.height - spacing, left: 0, bottom: 0, right: -titleSize.width)
            
            buttons.append(button)
        }
        return buttons
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBarItems()
        setupCustomTabBarView()
        updateTabBarAppearance()
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
        
        customTabBarView.backgroundColor = .clear
        customTabBarView.frame = CGRect(x: 0, y: view.frame.height - 100, width: view.frame.width, height: 90) // 여백을 위해 높이를 조금 늘림
        view.addSubview(customTabBarView)
        
        // 글래스 모피즘(Glassmorphism) 효과 추가
        let blurEffect = UIBlurEffect(style: .dark) // 또는 .light, .extraLight, .dark 중 선택
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.layer.cornerRadius = 25
        visualEffectView.layer.masksToBounds = true
        visualEffectView.translatesAutoresizingMaskIntoConstraints = false
        customTabBarView.addSubview(visualEffectView)
        
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
            else if index == titles.count - 1 {
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
                button.backgroundColor = .darkGray // 선택된 탭의 배경색
            } else {
                button.isSelected = false
                button.backgroundColor = .clear // 기본 배경색
            }
        }
    }


}
