//
//  DetailAudioPage.swift
//  Dots
//
//  Created by cheshire on 11/14/23.
//

import UIKit
import SnapKit

class DetailAudioPage: UIViewController {

    let closeButton = UIButton(type: .custom)
    let roundedRectangleView = UIView()
    let circleImageView = UIImageView()
    let label1 = UILabel()
    let label2 = UILabel()
    let rightActionButton = UIButton(type: .custom)
    let textView = UITextView()

    let leftCircleView = UIView() // 왼쪽 원형 뷰
    let rightCircleView = UIView() // 오른쪽 원형 뷰
    let leftButton = UIButton(type: .custom) // 왼쪽 버튼
    let rightButton = UIButton(type: .custom) // 오른쪽 버튼

    // 새로운 버튼 선언
    let leftButton1 = UIButton(type: .custom)
    let leftButton2 = UIButton(type: .custom)
    let leftButton3 = UIButton(type: .custom)
    let rightButton1 = UIButton(type: .custom)
    let rightButton2 = UIButton(type: .custom)
    let rightButton3 = UIButton(type: .custom)

    var isButtonImageToggled = false


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black // 배경색을 흰색으로 설정합니다.
        setupCloseButton() // 닫기 버튼을 설정하는 메서드 호출
        setupRoundedRectangleView()
        setupCircleImageView()
        setupLabels()
        setupRightActionButton() // 새로 정의한 메서드 호출
        setupTextView()
        setupLeftCircleView() // 새로 추가한 메서드 호출
        setupRightCircleView() // 새로 추가한 메서드 호출

    }

    private func setupLeftCircleView() {
        leftCircleView.backgroundColor = .darkGray
        leftCircleView.layer.cornerRadius = 30
        leftCircleView.clipsToBounds = true

        // 왼쪽 원형 뷰에 세 개의 버튼 추가 및 설정
        configureAdditionalButton(button: leftButton1, title: "x 0.5", fontSize: 16)
        configureAdditionalButton(button: leftButton2, title: "x 1", fontSize: 16)
        configureAdditionalButton(button: leftButton3, title: "x 2", fontSize: 16)

        view.addSubview(leftCircleView)
        leftCircleView.snp.makeConstraints { make in
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(30)
            make.bottom.equalTo(view.snp.bottom).inset(10)
            make.width.height.equalTo(60) // 원의 크기 설정
        }

        configureCircleButton(button: leftButton)
        leftCircleView.addSubview(leftButton)
        leftButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalToSuperview()
        }

        // 왼쪽 원형 뷰에 세 개의 버튼 추가
        [leftButton1, leftButton2, leftButton3].forEach {
            $0.isHidden = true // 초기에는 숨김
            //                 $0.backgroundColor = .red // 색상 예시
            leftCircleView.addSubview($0)
            $0.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.height.equalTo(40)
                // 각 버튼의 위치 조정 필요
            }
        }

    }

    private func setupRightCircleView() {
        rightCircleView.backgroundColor = .darkGray
        rightCircleView.layer.cornerRadius = 30
        rightCircleView.clipsToBounds = true

        // 오른쪽 원형 뷰에 세 개의 버튼 추가 및 설정
        // 각 버튼을 설정할 때 다른 폰트 크기를 지정합니다.
        configureAdditionalButton(button: rightButton1, title: "Aa", fontSize: 12)
        configureAdditionalButton(button: rightButton2, title: "Aa", fontSize: 16)
        configureAdditionalButton(button: rightButton3, title: "Aa", fontSize: 18)

        view.addSubview(rightCircleView)
        rightCircleView.snp.makeConstraints { make in
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-30)
            make.bottom.equalTo(view.snp.bottom).inset(10)
            make.width.height.equalTo(60) // 원의 크기 설정
        }

        configureCircleButton(button: rightButton)
        rightCircleView.addSubview(rightButton)
        rightButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalToSuperview()
        }

        [rightButton1, rightButton2, rightButton3].forEach {
            $0.isHidden = true // 초기에는 숨김
            //                $0.backgroundColor = .blue // 예시 색상
            configureButtonAppearance(button: $0)
            rightCircleView.addSubview($0)
            $0.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.height.equalTo(40)
                // 각 버튼의 위치 조정 필요
            }
        }
    }

    private func configureAdditionalButton(button: UIButton, title: String, fontSize: CGFloat) {
        button.setTitle(title, for: .normal)
        button.backgroundColor = .clear
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        button.isHidden = true
        button.addTarget(self, action: #selector(additionalButtonTapped(_:)), for: .touchUpInside)

        rightCircleView.addSubview(button)
        // 레이아웃 설정 코드...
    }

    @objc private func additionalButtonTapped(_ sender: UIButton) {
        // 버튼이 속한 원형 뷰의 높이를 원래대로 줄입니다.
        if leftCircleView.subviews.contains(sender) {
            leftCircleView.snp.updateConstraints { make in
                make.height.equalTo(60)
            }
            [leftButton1, leftButton2, leftButton3].forEach { $0.isHidden = true }
        } else if rightCircleView.subviews.contains(sender) {
            rightCircleView.snp.updateConstraints { make in
                make.height.equalTo(60)
            }
            [rightButton1, rightButton2, rightButton3].forEach { $0.isHidden = true }
        }
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        leftButton.isHidden = false
        rightButton.isHidden = false
    }

    private func configureCircleButton(button: UIButton) {
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = button.frame.size.height / 2
        button.clipsToBounds = true

        // 버튼에 텍스트 추가
        if button == leftButton {
            button.setTitle("x1", for: .normal) // 왼쪽 버튼에 텍스트 설정
        } else if button == rightButton {
            button.setTitle("Aa", for: .normal) // 오른쪽 버튼에 텍스트 설정
        }

        // 버튼에 액션 추가
        button.addTarget(self, action: #selector(circleButtonTapped(sender:)), for: .touchUpInside)
    }

    @objc private func circleButtonTapped(sender: UIButton) {
        sender.isHidden = true // 버튼 숨기기

        if sender == leftButton {
            leftCircleView.snp.updateConstraints { make in
                make.height.equalTo(150) // 높이를 늘립니다.
            }
            // 왼쪽 버튼들의 위치 조정
            configureButtonPositions(buttons: [leftButton1, leftButton2, leftButton3], inView: leftCircleView)
        } else if sender == rightButton {
            rightCircleView.snp.updateConstraints { make in
                make.height.equalTo(150) // 높이를 늘립니다.
            }
            // 오른쪽 버튼들의 위치 조정
            configureButtonPositions(buttons: [rightButton1, rightButton2, rightButton3], inView: rightCircleView)
        }

        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }


    private func configureButtonPositions(buttons: [UIButton], inView view: UIView) {
        // 각 버튼을 숨김 상태에서 보이게 하고 위치를 조정합니다.
        buttons.enumerated().forEach { (index, button) in
            button.isHidden = false
            button.snp.remakeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalToSuperview().offset(10 + (50 * index)) // 버튼간 간격 조정
                make.width.equalToSuperview().multipliedBy(0.8) // 버튼의 너비
                make.height.equalTo(40)
            }
        }
    }


    private func configureButtonAppearance(button: UIButton) {
        button.layer.cornerRadius = 30 // 반지름 설정으로 원형 버튼 만들기
        button.tintColor = .black
    }

    private func setupCloseButton() {
        // 'closeButton'을 이미지 버튼으로 설정합니다.
        if let image = UIImage(named: "Group 178") { // 'closeIcon'은 닫기 버튼으로 사용할 이미지의 이름입니다.
            closeButton.setImage(image, for: .normal)
            closeButton.tintColor = .white
        }
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)

        view.addSubview(closeButton)
        closeButton.snp.makeConstraints { make in
            // SnapKit을 사용하여 'closeButton'의 제약 조건을 설정합니다.
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).inset(20)
            make.width.height.equalTo(40) // 버튼의 너비와 높이를 설정합니다.
        }
    }

    @objc private func closeButtonTapped() {
        dismiss(animated: true, completion: nil) // 현재 뷰 컨트롤러를 닫습니다.
    }

    private func setupRoundedRectangleView() {
        roundedRectangleView.backgroundColor = .white // 뷰의 배경색 설정
        roundedRectangleView.layer.cornerRadius = 35 // 높이의 절반

        view.addSubview(roundedRectangleView)
        roundedRectangleView.snp.makeConstraints { make in
            make.top.equalTo(closeButton.snp.top).offset(50) // 'closeButton' 아래에 위치
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(20)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-20)
            make.height.equalTo(70) // 뷰의 높이 설정
        }
    }

    private func setupCircleImageView() {
        circleImageView.backgroundColor = .gray // 배경색 설정, 실제 이미지로 대체
        circleImageView.layer.cornerRadius = 27 // 반지름 설정
        circleImageView.clipsToBounds = true // 이미지가 뷰 경계를 넘지 않도록

        roundedRectangleView.addSubview(circleImageView)
        circleImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(54) // 원의 크기
        }
    }

    private func setupLabels() {
        label1.text = "Signal Projection, 2023"
        label1.textColor = .black
        label1.font = UIFont(name: "Pretendard-Bold", size: 18)
        label2.text = "Liam Gillick"
        label2.textColor = .black
        label2.font = UIFont(name: "Pretendard-Regular", size: 16)

        roundedRectangleView.addSubview(label1)
        roundedRectangleView.addSubview(label2)

        label1.snp.makeConstraints { make in
            make.left.equalTo(circleImageView.snp.right).offset(10)
            make.top.equalTo(circleImageView).offset(4)
            make.right.equalToSuperview().offset(-20)
        }

        label2.snp.makeConstraints { make in
            make.left.equalTo(circleImageView.snp.right).offset(10)
            make.top.equalTo(label1.snp.bottom).offset(6)
            make.right.equalToSuperview().offset(-20)
        }
    }

    private func setupRightActionButton() {
        if let image = UIImage(named: "Group 150") { // 사용할 이미지 이름
            rightActionButton.setImage(image, for: .normal)
        }

        rightActionButton.imageView?.contentMode = .scaleAspectFit
        rightActionButton.addTarget(self, action: #selector(rightActionButtonTapped), for: .touchUpInside)

        roundedRectangleView.addSubview(rightActionButton)
        rightActionButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(25) // 오른쪽 여백 설정
            make.centerY.equalToSuperview() // 세로 중앙 정렬
            make.width.height.equalTo(14) // 버튼 크기 설정
        }
    }
    @objc private func rightActionButtonTapped() {
        if isButtonImageToggled {
            rightActionButton.setImage(UIImage(named: "Group 150"), for: .normal)
        } else {
            rightActionButton.setImage(UIImage(named: "Polygon 6"), for: .normal)
        }
        isButtonImageToggled.toggle() // 상태 변경
    }



    private func setupTextView() {
        textView.textColor = .white
        textView.backgroundColor = .black // 배경색 설정
        textView.font = UIFont(name: "Pretendard-Bold", size: 22)
        textView.isEditable = false
        textView.isScrollEnabled = true
        textView.textAlignment = .justified



        // 여기에 긴 텍스트를 설정하세요.
        textView.text = """
         리암 길릭은 동시대 미술계를 주도하는 주요 작가로서 미술, 출판, 디자인, 전시 기획, 미술 비평 등 다방면에 걸쳐 자신의 예술세계를 진일보시켜왔다. 사회 현상의 분석과 미학적 접근을 통해 인간, 환경, 삶, 예술 사이의 관계를 다시 규정하고, 삶을 구획하는 여러 시스템에 주목하면서 다양한 형태로 자신의 이론과 아이디어를 시각화 해왔다. 사회 현상의 분석과 미학적 접근을 통해 인간, 환경, 삶, 예술 사이의 관계를 다시 규정하고, 삶을 구획하는 여러 시스템에 주목하면서 다양한 형태로 자신의 이론과 아이디어를 시각화 해왔다. 리암 길릭은 동시대 미술계를 주도하는 주요 작가로서 미술, 출판, 디자인, 전시 기획, 미술 비평 등 다방면에 걸쳐 자신의 예술세계를 진일보시켜왔다. 사회 현상의 분석과 미학적 접근을 통해 인간, 환경, 삶, 예술 사이의 관계를 다시 규정하고, 삶을 구획하는 여러 시스템에 주목하면서 다양한 형태로 자신의 이론과 아이디어를 시각화 해왔다. 사회 현상의 분석과 미학적 접근을 통해 인간, 환경, 삶, 예술 사이의 관계를 다시 규정하고, 삶을 구획하는 여러 시스템에 주목하면서 다양한 형태로 자신의 이론과 아이디어를 시각화 해왔다.
         """

        view.addSubview(textView)
        textView.snp.makeConstraints { make in
            make.top.equalTo(roundedRectangleView.snp.bottom).offset(20)
            make.left.right.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(80)
        }
    }

}

import SwiftUI

struct DetailAudioPagePreview: PreviewProvider {
    static var previews: some View {
        DetailAudioPageWrapper()
    }
}

struct DetailAudioPageWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        return DetailAudioPage()
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // 여기에 필요한 업데이트 로직을 추가합니다.
    }
}
