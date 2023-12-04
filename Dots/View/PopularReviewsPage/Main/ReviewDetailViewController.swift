//
//  ReviewDetailViewController.swift
//  Dots
//
//  Created by cheshire on 11/30/23.
//

import Foundation
import UIKit

class ReviewDetailViewController: UIViewController, UIGestureRecognizerDelegate {

    private func createCustomBackButton() -> UIButton {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "loginBack"), for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.layer.shadowOpacity = 0.9
        button.layer.shadowRadius = 2
        button.layer.shadowOffset = CGSize(width: 1, height: 1)
        button.layer.shadowColor = UIColor.black.cgColor
        button.frame = CGRect(x: 0, y: 0, width: 40, height: 40) // 버튼 크기 설정
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }

    private let detailLabel = UILabel()

    private let scrollView = UIScrollView()
    private let squareView = UIView()
    private let contentLabel = UILabel()

    private let profileImageView = UIImageView()
    private let nameLabel = UILabel()
    private let timeLabel = UILabel()

    // 새로운 컴포넌트 선언
    let additionalImageView1 = UIImageView()
    let additionalLabel1 = UILabel()
    let additionalImageView2 = UIImageView()
    let additionalLabel2 = UILabel()
    let reviewTitle = UILabel()

//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        // 탭바를 숨깁니다.
//        tabBarController?.tabBar.isHidden = true
//
//    }

//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.navigationBar.prefersLargeTitles = false
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        navigationController?.navigationBar.prefersLargeTitles = true
//    }

    


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupNavigationBackButton()
        setupNavigationTitleAndSubtitle() // 변경된 메서드 호출

        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self

        setupScrollView()
        setupSquareViewAndLabel()
        
        
       
    }


    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

    private func setupSquareViewAndLabel() {
        scrollView.addSubview(squareView)
        squareView.backgroundColor = .blue
        squareView.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.top).offset(20)
            make.leading.equalTo(scrollView.snp.leading).offset(20)
            make.trailing.equalTo(scrollView.snp.trailing).offset(-20)
            make.width.equalTo(scrollView.snp.width).offset(-40) // 화면 너비에 맞추기
            make.height.equalTo(squareView.snp.width) // 정사각형 유지
        }

        scrollView.addSubview(profileImageView)
        profileImageView.backgroundColor = .gray // 임시 색상, 실제 이미지로 교체 필요
        profileImageView.layer.cornerRadius = 16 // 동그란 이미지를 위해
        profileImageView.clipsToBounds = true
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(squareView.snp.bottom).offset(20)
            make.leading.equalTo(scrollView.snp.leading).offset(20)
            make.width.height.equalTo(32) // 동그란 이미지 크기
        }



        scrollView.addSubview(nameLabel)
        nameLabel.text = "닉네임"
        nameLabel.font =  UIFont(name: "Pretendard-SemiBold", size: 16)
        nameLabel.textColor = .white
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(profileImageView.snp.centerY)
            make.leading.equalTo(profileImageView.snp.trailing).offset(10)
        }

        scrollView.addSubview(timeLabel)
        timeLabel.text = "8분전"
        timeLabel.textColor = .white
        timeLabel.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        timeLabel.font = UIFont(name: "Pretendard-Light", size: 14)
        timeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(profileImageView.snp.centerY)
            make.trailing.equalTo(scrollView.snp.trailing).offset(-20)
        }


        scrollView.addSubview(reviewTitle)
        reviewTitle.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(20)
            make.leading.equalTo(profileImageView.snp.leading)
            make.trailing.equalTo(timeLabel.snp.trailing)
        }

        scrollView.addSubview(contentLabel)
            contentLabel.text = """
        최근 다녀온 인상주의 작가전에서 많은 영감을 받았습니다. 이번 전시에서는 다양한 작가들의 작품을 통해 인상주의의 다양한 표현과 미학에 대한 통찰을 얻을 수 있었습니다. 먼저, 전시에는 독특하고 선명한 색채가 돋보이는 작품들이 많았습니다. 작가들은 강렬한 색상을 통해 감정과 분위기를 전달하며 관람자에게 강한 인상을 남겼습니다. 특히, 대조적인 색감을 활용한 작품은 눈에 띄게 독창적이었습니다.
        인상주의는 자연의 아름다움을 강조하고 일상적인 풍경을 미적으로 해석하는 경향이 있습니다. 이번 전시에서는 도시의 소란스러운 풍경이나 자연의 고요함이 아름답게 표현된 작품들이 많았습니다. 이를 통해 작가들은 우리 주변의 일상에서도 예술을 발견할 수 있다는 메시지를 전달한 것 같았습니다.
        또한, 작품들은 각자의 시대적 맥락과 문화적 배경을 반영하면서도 개인적인 감성을 잘 표현했습니다. 이는 인상주의의 특징 중 하나로, 개인적인 경험과 감정을 작품에 담아내어 관람자와 소통하는 데 성공한 결과로 보입니다.
        이번 전시를 통해 인상주의의 다양한 스타일과 접근법을 경험하면서 예술의 폭넓은 가능성에 대한 새로운 시각을 얻을 수 있었습니다. 작가들의 창의적인 시도와 자유로운 표현이 예술의 다양성을 더욱 풍부하게 만들어준 것 같습니다.
        """
            contentLabel.numberOfLines = 0
            contentLabel.textColor = UIColor(red: 0.733, green: 0.733, blue: 0.733, alpha: 1)
            contentLabel.font = UIFont(name: "Pretendard-Regular", size: 18)
            contentLabel.lineBreakMode = .byWordWrapping
            var paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineHeightMultiple = 1.21
            // Line height: 18 pt
            paragraphStyle.alignment = .justified
            let attrString = NSMutableAttributedString(string: contentLabel.text!)
            paragraphStyle.lineSpacing = 1
            attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
            contentLabel.attributedText = attrString
            contentLabel.snp.makeConstraints { make in
              make.top.equalTo(reviewTitle.snp.bottom).offset(20)
              make.leading.equalTo(squareView.snp.leading)
              make.trailing.equalTo(squareView.snp.trailing)
        //      make.bottom.lessThanOrEqualTo(scrollView.snp.bottom).offset(-20)
            }


        // 첫 번째 추가 이미지 뷰 및 레이블 구성
        additionalImageView1.image = UIImage(named: "Vector 3")

//        additionalLabel1.text = "123"
        additionalLabel1.text = "123"
        additionalLabel1.textColor = .white
        additionalLabel1.font = UIFont(name: "Pretendard-Light", size: 12)
        additionalLabel1.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        // 스타일 및 글꼴 설정 등


        reviewTitle.text = "후기 제목 입니다."
        reviewTitle.textColor = .white
        reviewTitle.font = UIFont(name: "Pretendard-Medium", size: 20)


        // 두 번째 추가 이미지 뷰 및 레이블 구성
        additionalImageView2.image = UIImage(named: "streamline_interface-edit-view-eye-eyeball-open-view")
        additionalLabel2.textColor = .white
        additionalLabel2.font = UIFont(name: "Pretendard-Light", size: 12)
        additionalLabel2.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)


//        additionalLabel2.text = "456"
        additionalLabel2.text = "456"

        // 스타일 및 글꼴 설정 등

        scrollView.addSubview(additionalImageView1)
        scrollView.addSubview(additionalLabel1)
        scrollView.addSubview(additionalImageView2)
        scrollView.addSubview(additionalLabel2)



        additionalImageView1.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(30)
            make.left.equalTo(contentLabel.snp.left)
            make.width.equalTo(17.5)
            make.height.equalTo(14.5)
//            make.bottom.equalToSuperview().offset(-10)//      
            make.bottom.lessThanOrEqualTo(scrollView.snp.bottom).offset(-20)


        }

        additionalLabel1.snp.makeConstraints { make in
            make.centerY.equalTo(additionalImageView1)
            make.left.equalTo(additionalImageView1.snp.right).offset(10)
        }

        // 두 번째 추가 이미지 뷰와 레이블 레이아웃
        additionalImageView2.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(25)
            make.left.equalTo(additionalLabel1.snp.right).offset(10)
            make.width.height.equalTo(24)
        }

        additionalLabel2.snp.makeConstraints { make in
            make.centerY.equalTo(additionalImageView2)
            make.left.equalTo(additionalImageView2.snp.right).offset(8)
        }


    }

    private func setupNavigationTitleAndSubtitle() {
        let titleLabel = UILabel()
        titleLabel.text = "올해의 작가상"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)

        let subtitleLabel = UILabel()
        subtitleLabel.text = "국립현대미술관 서울"
        subtitleLabel.textColor = .lightGray
        subtitleLabel.font = UIFont.systemFont(ofSize: 12)

        let titleStackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        titleStackView.axis = .vertical
        titleStackView.alignment = .center
        titleStackView.distribution = .equalCentering

        self.navigationItem.titleView = titleStackView
    }


    @objc func backButtonTapped() {
        // 네비게이션 컨트롤러로 뒤로 가기
        navigationController?.popViewController(animated: true)
    }

    private func setupNavigationBackButton() {
        let backButton = createCustomBackButton()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)

    }

}
