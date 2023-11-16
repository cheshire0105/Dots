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
    let rightImageView = UIImageView() // 오른쪽에 추가할 이미지 뷰 선언
    let textView = UITextView()

    let leftButton = UIButton(type: .system)
    let centerButton = UIButton(type: .system)
    let rightButton = UIButton(type: .system)



    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black // 배경색을 흰색으로 설정합니다.
        setupCloseButton() // 닫기 버튼을 설정하는 메서드 호출
        setupRoundedRectangleView()
        setupCircleImageView()
        setupLabels()
        setupRightImageView() // 이미지 뷰 설정 메서드 호출
        setupTextView()

        setupButtons()

    }

    private func setupButtons() {
        // 왼쪽 버튼 설정
        leftButton.setTitle("x1", for: .normal)
        leftButton.backgroundColor = UIColor(red: 0.412, green: 0.412, blue: 0.412, alpha: 1)
        configureButtonAppearance(button: leftButton)



        // 오른쪽 버튼 설정
        rightButton.setTitle("Aa", for: .normal)
        rightButton.backgroundColor = UIColor(red: 0.412, green: 0.412, blue: 0.412, alpha: 1)
        configureButtonAppearance(button: rightButton)

        view.addSubview(leftButton)
        view.addSubview(centerButton)
        view.addSubview(rightButton)

        leftButton.snp.makeConstraints { make in
            make.left.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(textView.snp.bottom).offset(20)
            make.width.height.equalTo(60) // 버튼 크기
        }

        centerButton.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(textView.snp.bottom).offset(20)
            make.width.height.equalTo(60) // 버튼 크기
        }

        rightButton.snp.makeConstraints { make in
            make.right.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(textView.snp.bottom).offset(20)
            make.width.height.equalTo(60) // 버튼 크기
        }
    }

    private func configureButtonAppearance(button: UIButton) {
        //           button.backgroundColor = .white
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
        label2.text = "Liam Gillick"
        label2.textColor = .black

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

    private func setupRightImageView() {
        // 에셋에서 이미지 로드 (이미지 이름을 'yourImageName'으로 가정)
        if let image = UIImage(named: "Group 150") {
            rightImageView.image = image
        }

        roundedRectangleView.addSubview(rightImageView)
        rightImageView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20) // 오른쪽 여백 설정
            make.centerY.equalToSuperview() // 세로 중앙 정렬
            make.width.height.equalTo(20) // 이미지 크기 설정
        }
    }

    private func setupTextView() {
        textView.textColor = .white
        textView.backgroundColor = .black // 배경색 설정
        textView.font = .systemFont(ofSize: 24)
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
