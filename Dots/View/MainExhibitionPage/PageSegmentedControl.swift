//
//  PageSegmentedControl.swift
//  Dots
//
//  Created by cheshire on 11/1/23.
//

import Foundation
import UIKit

// MARK: - 사용자 정의 세그먼트 컨트롤 클래스를 선언합니다.
class PageSegmentedControl: UISegmentedControl {

    // 프레임을 사용하여 객체를 초기화하는 생성자입니다.
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.removeBackgroundAndDivider() // 백그라운드와 구분선을 제거합니다.

    }

    // 아이템 배열을 사용하여 객체를 초기화하는 생성자입니다.
    override init(items: [Any]?) {
        super.init(items: items)
        self.removeBackgroundAndDivider() // 백그라운드와 구분선을 제거합니다.

        // 세그먼트의 타이틀 색상을 하얀색으로 설정
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.setTitleTextAttributes(titleTextAttributes, for: .normal)
    }

    // 초기화에 필요한 코더를 사용하는 생성자입니다. 여기서는 사용되지 않습니다.
    required init?(coder: NSCoder) {
        fatalError()
    }

    // 세그먼트 컨트롤의 백그라운드와 구분선을 제거하는 메서드입니다.
    private func removeBackgroundAndDivider() {
        let image = UIImage()
        self.setBackgroundImage(image, for: .normal, barMetrics: .default) // 일반 상태의 백그라운드 이미지를 제거합니다.
        self.setBackgroundImage(image, for: .selected, barMetrics: .default) // 선택된 상태의 백그라운드 이미지를 제거합니다.
        self.setBackgroundImage(image, for: .highlighted, barMetrics: .default) // 강조된 상태의 백그라운드 이미지를 제거합니다.

        self.setDividerImage(image, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default) // 구분선 이미지를 제거합니다.
    }

    // 밑줄 뷰를 생성하고 설정합니다.
    private lazy var underlineView: UIView = {
        let width = self.bounds.size.width / CGFloat(self.numberOfSegments) // 밑줄의 너비를 계산합니다.
        let height = 2.0 // 밑줄의 높이를 설정합니다.
        let xPosition = CGFloat(self.selectedSegmentIndex * Int(width)) // 밑줄의 x 좌표를 계산합니다.
        let yPosition = self.bounds.size.height - 1.0 // 밑줄의 y 좌표를 계산합니다.
        let frame = CGRect(x: xPosition, y: yPosition, width: width, height: height) // 밑줄의 프레임을 생성합니다.
        let view = UIView(frame: frame) // 밑줄 뷰를 생성합니다.
        view.backgroundColor = .white // 밑줄의 배경색을 설정합니다.

        self.addSubview(view) // 밑줄 뷰를 세그먼트 컨트롤에 추가합니다.
        return view
    }()

    // 뷰의 서브뷰들의 레이아웃이 필요할 때 호출됩니다.
    override func layoutSubviews() {
        super.layoutSubviews()

        // 밑줄의 최종 x 좌표를 계산합니다.
        // 밑줄의 최종 x 좌표를 계산합니다.
        let underlineFinalXPosition = (self.bounds.width / CGFloat(self.numberOfSegments)) * CGFloat(self.selectedSegmentIndex)
        // 애니메이션을 사용하여 밑줄의 위치를 이동시킵니다.
        UIView.animate(
            withDuration: 0.1,
            animations: {
                self.underlineView.frame.origin.x = underlineFinalXPosition
            }
        )
    }
}




