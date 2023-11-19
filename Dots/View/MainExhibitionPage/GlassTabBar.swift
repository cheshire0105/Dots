//
//  GlassTabBar.swift
//  Dots
//
//  Created by cheshire on 10/23/23.
//  브랜치 생성 테스트 커밋 푸쉬 2023년 11월 18일 오후 11시 15분
//  최신화 머지 - dev 11월 19일 오전 12 : 28

import UIKit

class GlassTabBar: UITabBarController {
    let customTabBarView = UIView()
    let stackView = UIStackView()

    let images = [UIImage(named: "home"), UIImage(named: "search"), UIImage(named: "hot"), UIImage(named: "map"), UIImage(named: "mypage")]
    let backgroundView = UIView() // 스택뷰의 백그라운드 뷰

    lazy var indicatorViews: [UIView] = {
        var views: [UIView] = []
        for _ in 0 ..< 5 {
            let view = UIView()
            view.backgroundColor = UIColor.white // 색상은 원하는 대로 설정
            view.layer.cornerRadius = 25 // 원하는 모양으로 조정
            view.translatesAutoresizingMaskIntoConstraints = false
            view.isHidden = true // 기본적으로 숨김
            views.append(view)
        }
        return views
    }()

    lazy var indicatorImageViews: [UIImageView] = {
        return indicatorViews.map { _ in
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }
    }()


    lazy var buttons: [UIButton] = {
        var buttons: [UIButton] = []
        for i in 0 ..< 5 {
            let button = UIButton()

            let originalImage = images[i]?.withRenderingMode(.alwaysTemplate)
            button.setImage(originalImage, for: .normal)
            button.setImage(originalImage, for: .selected) // 동일한 이미지를 선택 상태에도 설정
            button.backgroundColor = .clear // 초기 배경색 설정

            // Set text font size
            button.titleLabel?.font = UIFont.systemFont(ofSize: 12) // Adjust the font size as desired

            button.setTitleColor(.white, for: .normal)

            let imageSize = button.imageView!.intrinsicContentSize



            buttons.append(button)
        }
        return buttons
    }()

    // UILabel을 추가하기 위한 배열
    lazy var indicatorLabels: [UILabel] = {
        return indicatorViews.map { _ in
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 15)
            label.textColor = .black
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }
    }()

    // 각 indicatorView에 대한 너비 제약 조건을 저장하기 위한 배열
       var indicatorViewWidthConstraints: [NSLayoutConstraint] = []

    
    // 버튼 및 indicatorView의 너비에 대한 변수들
        let initialIndicatorWidth: CGFloat = 50 // 예시 값, 실제 화면에 맞게 조정 필요
        let expandedWidth: CGFloat = 100 // 예시 값, 실제 화면에 맞게 조정 필요
        let contractedWidth: CGFloat = 50 // 예시 값, 실제 화면에 맞게 조정 필요


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupCustomTabBarView()

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabBarItems()
        // 기본 탭 설정 및 외관 업데이트
        let defaultTabIndex = 0


        // 각 indicatorView에 대한 너비 제약 조건을 설정하고 저장합니다.
               for indicatorView in indicatorViews {
                   let widthConstraint = indicatorView.widthAnchor.constraint(equalToConstant: initialIndicatorWidth) // 초기 너비 설정
                   widthConstraint.isActive = true
                   indicatorViewWidthConstraints.append(widthConstraint)
               }

        updateSelectedTabAppearance(index: defaultTabIndex)

        
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
        customTabBarView.frame = CGRect(x: tabBarX, y: view.frame.height - 75, width: tabBarWidth, height: 50)
        view.addSubview(customTabBarView)

        // 스택뷰의 백그라운드 뷰 설정
        backgroundView.layer.cornerRadius = 25
        backgroundView.backgroundColor = UIColor(red: 0.145, green: 0.145, blue: 0.145, alpha: 1)

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
            backgroundView.topAnchor.constraint(equalTo: customTabBarView.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: customTabBarView.bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: customTabBarView.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: customTabBarView.trailingAnchor),

            stackView.topAnchor.constraint(equalTo: backgroundView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor)
        ])

        for (index, button) in buttons.enumerated() {
            stackView.addArrangedSubview(button)
            button.addTarget(self, action: #selector(tabBarButtonTapped(_:)), for: .touchUpInside)
            button.tag = index

            button.heightAnchor.constraint(equalToConstant: 50).isActive = true

            // 각 버튼에 해당하는 indicatorView를 추가합니다.
            let indicatorView = indicatorViews[index]
            customTabBarView.addSubview(indicatorView)

            // UIImageView를 indicatorView에 추가합니다.
            let imageView = indicatorImageViews[index]
            indicatorView.addSubview(imageView)

            // UILabel을 indicatorView에 추가합니다.
            let label = indicatorLabels[index]
            indicatorView.addSubview(label)



            NSLayoutConstraint.activate([
                // ImageView 제약 조건
                imageView.leadingAnchor.constraint(equalTo: indicatorView.leadingAnchor, constant: 8),
                imageView.centerYAnchor.constraint(equalTo: indicatorView.centerYAnchor),
                imageView.widthAnchor.constraint(equalTo: indicatorView.widthAnchor, multiplier: 0.3),
                imageView.heightAnchor.constraint(equalTo: indicatorView.heightAnchor, multiplier: 0.3),

                // Label 제약 조건
                label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8),
                label.centerYAnchor.constraint(equalTo: indicatorView.centerYAnchor),
                label.trailingAnchor.constraint(lessThanOrEqualTo: indicatorView.trailingAnchor, constant: -8),
                // label.widthAnchor, label.heightAnchor 등 필요한 경우 추가 제약 조건 설정
                indicatorView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor), // 탭바의 하단에 맞춤
                indicatorView.centerXAnchor.constraint(equalTo: button.centerXAnchor),
                indicatorView.widthAnchor.constraint(equalTo: button.widthAnchor), // 버튼의 너비와 일치
                indicatorView.heightAnchor.constraint(equalTo: button.heightAnchor) // 원하는 높이

            ])
        }


    }

    @objc func tabBarButtonTapped(_ sender: UIButton) {
        // 모든 버튼의 선택 상태와 배경을 초기화
        for button in buttons {
            button.isSelected = false
            updateButtonAppearance(button: button, isSelected: false)
        }

        for (index, constraint) in indicatorViewWidthConstraints.enumerated() {
                   constraint.constant = (sender.tag == index) ? expandedWidth : contractedWidth
               }

        // 선택된 버튼의 상태를 업데이트
        sender.isSelected = true
        updateButtonAppearance(button: sender, isSelected: true)

        // 탭 인덱스 변경
        selectedIndex = sender.tag
    }

    // 버튼의 외관을 업데이트하는 메소드
    // updateButtonAppearance 메서드 수정
    func updateButtonAppearance(button: UIButton, isSelected: Bool) {
        if isSelected {
            indicatorViews[button.tag].isHidden = false
            indicatorImageViews[button.tag].image = button.image(for: .normal) // 이미지 설정
            indicatorLabels[button.tag].text = "전시" // 여기에 원하는 텍스트를 설정
        } else {
            indicatorViews[button.tag].isHidden = true
        }
    }



    // 기본 선택된 탭의 외관을 업데이트하는 메소드
    func updateSelectedTabAppearance(index: Int) {
        for (buttonIndex, button) in buttons.enumerated() {
            let isSelected = buttonIndex == index
            button.isSelected = isSelected
            updateButtonAppearance(button: button, isSelected: isSelected)

            // 추가된 부분: 버튼의 레이아웃이 결정된 후에 배경을 업데이트
            DispatchQueue.main.async {
                self.updateButtonAppearance(button: button, isSelected: isSelected)
            }
        }
        selectedIndex = index
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
