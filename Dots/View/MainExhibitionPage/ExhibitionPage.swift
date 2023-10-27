//
//  ExhibitionPage.swift
//  Dots
//
//  Created by cheshire on 10/27/23.
//

import UIKit
import SnapKit

class ExhibitionPage: UIViewController {

    // 스크롤 뷰와 콘텐츠 뷰를 정의합니다.
    let scrollView = UIScrollView()
    let contentView = UIView()
    let exhibitionImageView = UIImageView() // 이미지 뷰를 정의합니다.
    let titleLabel = UILabel()
    let galleryButtonLabel = UILabel()

    let iconImageView = UIImageView()
    let descriptionLabel = UILabel()
    let stackView = UIStackView()

    let iconImageViewTwo = UIImageView()
    let descriptionLabelTwo = UILabel()
    let stackViewTwo = UIStackView()

    let mySegmentedControl = MyPageSegmentedControl(items: ["페이지 1", "페이지 2"])


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(false, animated: animated)
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        // 네비게이션 바의 배경을 투명하게 설정
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true

        self.view.backgroundColor = .black

        setupBackButton()
        setupRightBarButton()

        setupScrollView()
        setupExhibitionImage()



    }



    private func setupExhibitionImage() {
        // 이미지 뷰를 contentView에 추가합니다.
        contentView.addSubview(exhibitionImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(galleryButtonLabel)

        stackView.addArrangedSubview(iconImageView)
        stackView.addArrangedSubview(descriptionLabel)
        contentView.addSubview(stackView)

        stackViewTwo.addArrangedSubview(iconImageViewTwo)
        stackViewTwo.addArrangedSubview(descriptionLabelTwo)
        contentView.addSubview(stackViewTwo)

        contentView.addSubview(mySegmentedControl)

        // 이미지 뷰의 제약 조건을 설정합니다.
        exhibitionImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView) // 상단에서 16픽셀 떨어진 위치에 배치
            make.left.equalTo(contentView) // 왼쪽에서 16픽셀 떨어진 위치에 배치
            make.right.equalTo(contentView) // 오른쪽에서 16픽셀 떨어진 위치에 배치
            make.height.equalTo(350)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(200) // 이미지 아래에 10픽셀 떨어진 위치에 배치
            make.left.equalTo(contentView).offset(16) // 왼쪽에서 16픽셀 떨어진 위치에 배치
            make.right.equalTo(contentView).offset(-16) // 오른쪽에서 16픽셀 떨어진 위치에 배치
        }

        galleryButtonLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(13) // titleLabel 아래에 20픽셀 떨어진 위치에 배치
            make.left.equalTo(contentView).offset(16) // 왼쪽에서 16픽셀 떨어진 위치에 배치
            make.right.equalTo(contentView).offset(-16) // 오른쪽에서 16픽셀 떨어진 위치에 배치
        }

        stackView.snp.makeConstraints { make in
            make.top.equalTo(galleryButtonLabel.snp.bottom).offset(13)
            make.left.equalTo(contentView).offset(16)
            make.right.lessThanOrEqualTo(contentView).offset(-16)
        }

        stackViewTwo.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(13)
            make.left.equalTo(contentView).offset(16)
            make.right.lessThanOrEqualTo(contentView).offset(-16)
        }

        // MyPageSegmentedControl 설정
        mySegmentedControl.snp.makeConstraints { make in
            make.top.equalTo(exhibitionImageView.snp.bottom).offset(16)
            make.left.equalTo(contentView).offset(16)
            make.height.equalTo(40)  // 높이 지정
        }


        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center

        stackViewTwo.axis = .horizontal
        stackViewTwo.spacing = 10
        stackViewTwo.alignment = .center


        // 이미지 뷰에 이미지를 설정합니다. (원하는 이미지로 변경하실 수 있습니다.)
        exhibitionImageView.image = UIImage(named: "ExhibitionPageBack")
        exhibitionImageView.contentMode = .scaleAspectFill // 이미지의 콘텐츠 모드를 설정합니다.
        exhibitionImageView.clipsToBounds = true

        titleLabel.text = "리암 길릭 : The Alterants"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24) // 폰트 크기를 24로 설정하고 볼드체로 지정
        titleLabel.textColor = .white

        galleryButtonLabel.text = "갤러리바튼"
        galleryButtonLabel.font = UIFont.systemFont(ofSize: 16) // 폰트 크기를 20로 설정하고 일반 체로 지정
        galleryButtonLabel.textColor = .white

        iconImageView.image = UIImage(named: "exhibitionGeoIcon")
        iconImageView.contentMode = .scaleAspectFit
        descriptionLabel.text = "서울 종로구 삼청로 30"
        descriptionLabel.font = UIFont.systemFont(ofSize: 12)
        descriptionLabel.textColor = .white

        iconImageViewTwo.image = UIImage(named: "exhibitionCalendarIcon")
        iconImageViewTwo.contentMode = .scaleAspectFit
        descriptionLabelTwo.text = "~ 2024.02.12"
        descriptionLabelTwo.font = UIFont.systemFont(ofSize: 12)
        descriptionLabelTwo.textColor = .white


        mySegmentedControl.selectedSegmentIndex = 0
        mySegmentedControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        mySegmentedControl.setTitle("후기", forSegmentAt: 0)
        mySegmentedControl.setTitle("전시정보", forSegmentAt: 1)

    }

    @objc func segmentChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            // 첫 번째 세그먼트 선택됨
            break
        case 1:
            // 두 번째 세그먼트 선택됨
            break
        default:
            break
        }
    }

    // 스크롤 뷰 설정
    private func setupScrollView() {
        // 스크롤 뷰를 뷰에 추가
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview() // 스크롤 뷰를 전체 화면으로 설정
        }

        // 콘텐츠 뷰를 스크롤 뷰에 추가
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.top.equalTo(view) // 변경된 부분: 콘텐츠 뷰의 상단을 뷰의 상단에 맞춤
            make.left.right.bottom.equalToSuperview()
            make.width.equalTo(scrollView) // 콘텐츠 뷰의 너비를 스크롤 뷰의 너비와 같게 설정
        }
    }




    private func setupBackButton() {
        let backButtonImage = UIImage(named: "backButton")
        let backButton = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(backButtonTapped))
        backButton.tintColor = .white
        navigationItem.leftBarButtonItem = backButton
    }

    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

    private func setupRightBarButton() {
        let rightButtonImage = UIImage(named: "audioGuide")
        let rightButton = UIBarButtonItem(image: rightButtonImage, style: .plain, target: self, action: #selector(rightButtonTapped))
        rightButton.tintColor = .white
        navigationItem.rightBarButtonItem = rightButton
    }

    @objc func rightButtonTapped() {
    }
}

// MARK: - 사용자 정의 세그먼트 컨트롤 클래스를 선언합니다.
class MyPageSegmentedControl: UISegmentedControl {

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
