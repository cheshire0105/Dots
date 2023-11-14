//
//  AudioGuidePage.swift
//  Dots
//
//  Created by cheshire on 10/23/23.
//

import UIKit
import SnapKit

class AudioGuideViewController: UIViewController {

    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "loginBack"), for: .normal) // 버튼의 기본 상태 이미지를 설정합니다.
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside) // 버튼 액션 추가
        return button
    }()

    // 타이틀 레이블 선언
     lazy var titleLabel: UILabel = {
         let label = UILabel()
         label.textColor = .white
         label.textAlignment = .center
         label.text = "리암 길릭 : The Alterants" // 여기에 원하는 타이틀을 입력하세요.
         // 폰트 크기는 원하는 대로 설정할 수 있습니다.
         label.font = UIFont(name: "HelveticaNeue-Bold", size: 24) // 원하는 폰트로 변경하세요.
         return label
     }()

    // 세그먼트 컨트롤 선언
    lazy var segmentControl: UISegmentedControl = {
        let items = ["작품별", "흐름별"]
        let segmentControl = UISegmentedControl(items: items)
        segmentControl.selectedSegmentIndex = 0 // 기본 선택 인덱스를 설정합니다.
        segmentControl.backgroundColor = UIColor.black // 배경색 설정
        segmentControl.selectedSegmentTintColor = UIColor(red: 0.388, green: 0.388, blue: 0.4, alpha: 1)// 선택된 아이템의 배경색 설정

        // 텍스트 색상 변경을 위한 설정
        let normalTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let selectedTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

        segmentControl.setTitleTextAttributes(normalTextAttributes, for: .normal)
        segmentControl.setTitleTextAttributes(selectedTextAttributes, for: .selected)
        segmentControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged) // 세그먼트 변경 액션 추가
        return segmentControl
    }()




    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black

        navigationController?.setNavigationBarHidden(true, animated: false)


        setupCustomBackButton()
        setupTitleLabel() // 타이틀 레이블 설정 메서드 호출
        setupSegmentControl()


    }

    private func setupCustomBackButton() {


        // 백 버튼 레이아웃 설정
        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in // SnapKit을 사용하여 제약 조건 설정
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10) // 상단 safe area로부터 10포인트 아래에 위치
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(10) // leading edge로부터 10포인트 떨어진 곳에 위치
            make.width.height.equalTo(40) // 너비와 높이는 40포인트로 설정
        }
    }

    // 타이틀 레이블 설정 메서드
    private func setupTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(10) // 백 버튼 바로 아래에 위치하도록 설정
            make.centerX.equalToSuperview() // X축 중앙에 위치하도록 설정
            make.left.right.equalTo(view.safeAreaLayoutGuide).inset(20) // 좌우 여백 설정
        }
    }

    // 세그먼트 컨트롤 설정 메서드
     private func setupSegmentControl() {
         view.addSubview(segmentControl)
         segmentControl.snp.makeConstraints { make in
             make.top.equalTo(titleLabel.snp.bottom).offset(20) // 타이틀 레이블 아래에 20포인트 간격을 둡니다.
             make.left.right.equalTo(view.safeAreaLayoutGuide).inset(110) // 좌우 여백 설정
             make.height.equalTo(30) // 세그먼트 컨트롤의 높이 설정
         }
     }

     // 세그먼트 변경 시 호출될 메서드
     @objc private func segmentChanged(_ sender: UISegmentedControl) {
         // 세그먼트 컨트롤 값이 변경되었을 때의 처리를 여기에 작성합니다.
         print("Selected Segment Index is \(sender.selectedSegmentIndex)")
     }


    @objc private func backButtonPressed() {
        // 현재 뷰 컨트롤러를 네비게이션 스택에서 제거합니다.
        navigationController?.popViewController(animated: true)
    }
}

