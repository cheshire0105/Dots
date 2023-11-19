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
    var buttonWidthConstraints: [NSLayoutConstraint] = []

    
    // 버튼 및 indicatorView의 너비에 대한 변수들
        let initialIndicatorWidth: CGFloat = 80 // 예시 값, 실제 화면에 맞게 조정 필요
        let expandedWidth: CGFloat = 100 // 예시 값, 실제 화면에 맞게 조정 필요
        let contractedWidth: CGFloat = 50 // 예시 값, 실제 화면에 맞게 조정 필요


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupCustomTabBarView()
        // 첫 번째 버튼이 프로그래매틱하게 선택되도록 설정
         if let firstButton = buttons.first {
             tabBarButtonTapped(firstButton)
         }

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabBarItems()
        // 기본 탭 설정 및 외관 업데이트


        // 각 indicatorView에 대한 너비 제약 조건을 설정하고 저장합니다.
               for indicatorView in indicatorViews {
                   let widthConstraint = indicatorView.widthAnchor.constraint(equalToConstant: initialIndicatorWidth) // 초기 너비 설정
                   widthConstraint.isActive = true
                   indicatorViewWidthConstraints.append(widthConstraint)
               }


        // 버튼 너비 제약 조건 설정
          for button in buttons {
              let widthConstraint = button.widthAnchor.constraint(equalToConstant: contractedWidth)
              widthConstraint.isActive = true
              buttonWidthConstraints.append(widthConstraint)
          }

        

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
            view.addSubview(customTabBarView)

            // 백그라운드 뷰 설정
            backgroundView.layer.cornerRadius = 25
            backgroundView.backgroundColor = UIColor(red: 0.145, green: 0.145, blue: 0.145, alpha: 1)
            customTabBarView.addSubview(backgroundView)

            // SnapKit을 사용한 제약 조건 설정
            customTabBarView.snp.makeConstraints { make in
                make.height.equalTo(50)
                make.bottom.equalToSuperview().offset(-25)
                make.leading.trailing.equalToSuperview().inset(view.frame.width * 0.1) // 왼쪽과 오른쪽 간격을 상위뷰 너비의 10%로 설정
            }

            backgroundView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }


    }
    func setupButtons() {
        let totalSpacing = customTabBarView.frame.width - (CGFloat(buttons.count) * contractedWidth)
        let spacing = totalSpacing / CGFloat(buttons.count - 1)
        var xPosition: CGFloat = 0
        let buttonTitles = ["전시", "검색", "인기", "지도", "마이"] // 탭에 따른 제목 설정


        for (index, button) in buttons.enumerated() {

            if let image = images[index]?.withRenderingMode(.alwaysTemplate) {
                       button.setImage(image, for: .normal)
                       button.setImage(image, for: .selected)
                       button.tintColor = UIColor.lightGray // 기본 색상 설정
                   }
            button.frame = CGRect(x: xPosition, y: 0, width: contractedWidth, height: 50)
            customTabBarView.addSubview(button)
            button.addTarget(self, action: #selector(tabBarButtonTapped(_:)), for: .touchUpInside)
            button.tag = index

            

            // 다음 버튼의 위치를 계산
            xPosition += contractedWidth + (index < buttons.count - 1 ? spacing : 0)

            let indicatorView = indicatorViews[index]
            customTabBarView.addSubview(indicatorView)

            // UIImageView를 indicatorView에 추가합니다.
            let imageView = indicatorImageViews[index]
            indicatorView.addSubview(imageView)

            // UILabel을 indicatorView에 추가합니다.
            let label = indicatorLabels[index]
                   label.text = buttonTitles[index] // 각 탭에 해당하는 텍스트 설정
            indicatorView.addSubview(label)

            // SnapKit을 사용한 제약 조건 설정
            imageView.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(8)
                make.centerY.equalToSuperview()
                make.width.equalToSuperview().multipliedBy(0.4)
                make.height.equalToSuperview().multipliedBy(0.4)
            }

            label.snp.makeConstraints { make in
                make.leading.equalTo(imageView.snp.trailing).offset(4)
                make.centerY.equalToSuperview()
                make.trailing.lessThanOrEqualToSuperview().offset(-8)
            }

            indicatorView.snp.makeConstraints { make in
                make.bottom.equalTo(backgroundView.snp.bottom)
                make.centerX.equalTo(button.snp.centerX)
                make.width.equalTo(initialIndicatorWidth) // 일정한 너비 설정
                make.height.equalTo(button.snp.height)
            }
            indicatorViewWidthConstraints.append(indicatorView.constraints.first { $0.firstAttribute == .width }!)
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupButtons()
    }

    @objc func tabBarButtonTapped(_ sender: UIButton) {
        // 모든 버튼의 선택 상태와 배경을 초기화
        for button in buttons {
            button.isSelected = false
            updateButtonAppearance(button: button, isSelected: false)
        }

        // 선택된 버튼의 너비를 확대하고, 나머지 버튼의 위치와 너비를 조정합니다.
        var xPosition: CGFloat = 0
        for (index, button) in buttons.enumerated() {
            let isExpanded = sender.tag == index
            let width = isExpanded ? expandedWidth : contractedWidth
            button.frame = CGRect(x: xPosition, y: 0, width: width, height: 50)

            // IndicatorView의 너비를 조정합니다.
            let widthConstraint = indicatorViewWidthConstraints[index]
            widthConstraint.constant = isExpanded ? expandedWidth : initialIndicatorWidth

            // 확장된 버튼을 기준으로 나머지 버튼의 위치를 조정합니다.
            xPosition += width
        }

        // 선택된 버튼의 상태를 업데이트
        sender.isSelected = true
        updateButtonAppearance(button: sender, isSelected: true)

        // 탭 인덱스 변경
        selectedIndex = sender.tag

        // 레이아웃 업데이트
        view.layoutIfNeeded()
    }


    // 버튼의 외관을 업데이트하는 메소드
    // updateButtonAppearance 메서드 수정
    // updateButtonAppearance 메서드에서 indicatorView의 너비를 변경하지 않도록 수정
    func updateButtonAppearance(button: UIButton, isSelected: Bool) {
        if isSelected {
            indicatorViews[button.tag].isHidden = false

            // 선택된 상태일 때 이미지와 텍스트의 색상 변경
            indicatorImageViews[button.tag].image = button.image(for: .normal)?.withRenderingMode(.alwaysTemplate)
            indicatorImageViews[button.tag].tintColor = UIColor.black // 선택된 이미지 색상 설정

            indicatorLabels[button.tag].textColor = UIColor.black // 선택된 텍스트 색상 설정
            // 이 부분은 필요에 따라 선택된 탭의 텍스트를 설정할 수 있습니다.
        } else {
            indicatorViews[button.tag].isHidden = true

            // 선택되지 않은 상태일 때 이미지와 텍스트의 색상 변경
            if let image = button.image(for: .normal)?.withRenderingMode(.alwaysTemplate) {
                indicatorImageViews[button.tag].image = image
                indicatorImageViews[button.tag].tintColor = UIColor.lightGray // 선택되지 않은 이미지 색상 설정
            }

            indicatorLabels[button.tag].textColor = UIColor.lightGray // 선택되지 않은 텍스트 색상 설정
        }
    }





    // 기본 선택된 탭의 외관을 업데이트하는 메소드
    func updateSelectedTabAppearance(index: Int) {
        var xPosition: CGFloat = 0
        for (buttonIndex, button) in buttons.enumerated() {
            let isSelected = buttonIndex == index
            button.isSelected = isSelected
            updateButtonAppearance(button: button, isSelected: isSelected)

            let width = isSelected ? expandedWidth : contractedWidth
            button.frame = CGRect(x: xPosition, y: 0, width: width, height: 50)

            // IndicatorView의 너비를 조정합니다.
            let widthConstraint = indicatorViewWidthConstraints[buttonIndex]
            widthConstraint.constant = isSelected ? expandedWidth : initialIndicatorWidth

            // 다음 버튼의 x 위치를 업데이트합니다.
            xPosition += width
        }

        // 선택된 탭에 대한 추가 처리 (예: 컨텐츠 뷰 컨트롤러 변경)
        selectedIndex = index

        // 레이아웃 업데이트
        view.layoutIfNeeded()
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
