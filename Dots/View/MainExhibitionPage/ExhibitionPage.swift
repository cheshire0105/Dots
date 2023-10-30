//
//  ExhibitionPage.swift
//  Dots
//
//  Created by cheshire on 10/27/23.
//

import UIKit
import SnapKit

class ExhibitionPage: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate, UIScrollViewDelegate {

    // MARK: - 변수들

    let scrollView = UIScrollView()
    let contentView = UIView()

    let exhibitionImageView = UIImageView()
    let titleLabel = UILabel()
    let galleryButtonLabel = UILabel()

    let iconImageView = UIImageView()
    let descriptionLabel = UILabel()
    let stackView = UIStackView()

    let iconImageViewTwo = UIImageView()
    let descriptionLabelTwo = UILabel()
    let stackViewTwo = UIStackView()

    private lazy var firstPageViewController: FirstPageViewController = {
        let viewController = FirstPageViewController()
        return viewController
    }()

    private let segmentedControl: MyPageSegmentedControl = {
        let items = ["후기", "전시 정보"]
        let segmentedControl = MyPageSegmentedControl(items: items)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        segmentedControl.setTitleTextAttributes(
            [
                NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
                .font: UIFont.systemFont(ofSize: 13, weight: .semibold)
            ],
            for: .selected
        )
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()

    private lazy var pageViewController: UIPageViewController = {
        let pageVC = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageVC.dataSource = self
        pageVC.delegate = self
        pageVC.view.backgroundColor = .yellow

        return pageVC
    }()

    private lazy var viewControllers: [UIViewController] = {
        let firstVC = FirstPageViewController()
        let secondVC = SecondPageViewController()
        return [firstVC, secondVC]
    }()


    // MARK: - 뷰의 생명주기

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.delegate = self

        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        self.view.backgroundColor = .black

        setupBackButton()
        setupRightBarButton()
        setupExhibitionImage()
        segmentedControl.addTarget(self, action: #selector(didChangeSegmentControl), for: .valueChanged)
        setupScrollView()

        addChild(pageViewController)
        contentView.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        pageViewController.setViewControllers([viewControllers[0]], direction: .forward, animated: true, completion: nil)
        setupPageViewControllerConstraints()

        addChild(firstPageViewController)
        scrollView.addSubview(firstPageViewController.view)
        firstPageViewController.didMove(toParent: self)

        firstPageViewController.view.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(10)
            make.left.right.equalTo(scrollView)
            make.width.equalTo(scrollView)
            make.height.equalTo(1000)
            make.bottom.equalTo(scrollView)
        }
    }

    // MARK: - 함수들

    // 세그먼트의 값이 변경 되었을 때
    @objc private func didChangeSegmentControl(_ sender: UISegmentedControl) {
        let direction: UIPageViewController.NavigationDirection = (pageViewController.viewControllers?.first == viewControllers[sender.selectedSegmentIndex]) ? .reverse : .forward
        pageViewController.setViewControllers([viewControllers[sender.selectedSegmentIndex]], direction: direction, animated: true, completion: nil)
    }
    
    // 세그먼트 컨트롤에서 보여지는 PageView의 레이아웃
    private func setupPageViewControllerConstraints() {
        pageViewController.view.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(10)
            make.left.right.equalTo(contentView)
            make.height.equalTo(view.snp.height)
        }
    }
    
    // 페이지 컨트롤러의 첫번째 인덱스
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let index = viewControllers.firstIndex(of: viewController), index > 0 {
            return viewControllers[index - 1]
        }
        return nil
    }
    
    // 페이지 컨트롤러의 두번째 인덱스
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let index = viewControllers.firstIndex(of: viewController), index < viewControllers.count - 1 {
            return viewControllers[index + 1]
        }
        return nil
    }

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed, let currentViewController = pageViewController.viewControllers?.first, let index = viewControllers.firstIndex(of: currentViewController) {
            segmentedControl.selectedSegmentIndex = index
        }
    }
    
    // 스크롤 뷰의 레이아웃을 정하는 함수 - 스크롤 뷰 안에 콘텐츠 뷰를 동일하게 추가
    private func setupScrollView() {

        view.addSubview(scrollView)

        scrollView.snp.makeConstraints { (make) in
            make.top.right.left.bottom.equalTo(view)
        }

        scrollView.addSubview(contentView)

        contentView.snp.remakeConstraints { (make) in
            make.top.equalTo(scrollView)
            make.left.right.equalTo(scrollView)
            make.bottom.equalTo(pageViewController.view.snp.bottom)
        }
    }

    // 상단의 전시 이미지를 설정 하는 함수
    private func setupExhibitionImage() {
        // 이미지 뷰를 contentView에 추가합니다.

        // 전시 이미지와 레이블을 추가
        contentView.addSubview(exhibitionImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(galleryButtonLabel)
        
        // 그 밑에 위치와 날짜 레이블의 스택뷰를 추가
        stackView.addArrangedSubview(iconImageView)
        stackView.addArrangedSubview(descriptionLabel)
        contentView.addSubview(stackView)

        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center

        stackViewTwo.addArrangedSubview(iconImageViewTwo)
        stackViewTwo.addArrangedSubview(descriptionLabelTwo)
        contentView.addSubview(stackViewTwo)

        stackViewTwo.axis = .horizontal
        stackViewTwo.spacing = 10
        stackViewTwo.alignment = .center

        // 세그먼트 컨트롤을 추가
        contentView.addSubview(segmentedControl)

        // 세그먼트 컨트롤로 연결 되는 페이지 뷰를 추가
        contentView.addSubview(pageViewController.view)

        exhibitionImageView.snp.updateConstraints { make in
            make.top.equalTo(contentView)
            make.left.equalTo(contentView)
            make.right.equalTo(contentView)
            make.height.equalTo(350)
        }

        exhibitionImageView.image = UIImage(named: "morningStar")
        exhibitionImageView.contentMode = .scaleAspectFill
        exhibitionImageView.clipsToBounds = true

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(200)
            make.left.equalTo(contentView).offset(16)
            make.right.equalTo(contentView).offset(-16)
        }

        titleLabel.text = "리암 길릭 : The Alterants"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textColor = .white

        galleryButtonLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(13)
            make.left.equalTo(contentView).offset(16)
            make.right.equalTo(contentView).offset(-16)
        }

        galleryButtonLabel.text = "갤러리바튼"
        galleryButtonLabel.font = UIFont.systemFont(ofSize: 16)
        galleryButtonLabel.textColor = .white

        stackView.snp.makeConstraints { make in
            make.top.equalTo(galleryButtonLabel.snp.bottom).offset(13)
            make.left.equalTo(contentView).offset(16)
            make.right.lessThanOrEqualTo(contentView).offset(-16)
        }

        iconImageView.image = UIImage(named: "exhibitionGeoIcon")
        iconImageView.contentMode = .scaleAspectFit
        descriptionLabel.text = "서울 종로구 삼청로 30"
        descriptionLabel.font = UIFont.systemFont(ofSize: 12)
        descriptionLabel.textColor = .white

        stackViewTwo.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(13)
            make.left.equalTo(contentView).offset(16)
            make.right.lessThanOrEqualTo(contentView).offset(-16)
        }

        iconImageViewTwo.image = UIImage(named: "exhibitionCalendarIcon")
        iconImageViewTwo.contentMode = .scaleAspectFit
        descriptionLabelTwo.text = "~ 2024.02.12"
        descriptionLabelTwo.font = UIFont.systemFont(ofSize: 12)
        descriptionLabelTwo.textColor = .white

        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(exhibitionImageView.snp.bottom).offset(16)
            make.left.equalTo(contentView).offset(16)
            make.height.equalTo(40)  // 높이 지정
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

extension ExhibitionPage {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yOffset = scrollView.contentOffset.y
        if yOffset < 0 {
            // 스크롤이 위로 이동할 때
            let newHeight = 350 - yOffset  // 원래 이미지 뷰 높이에서 스크롤 양을 빼서 새 높이를 계산
            let newTopOffset = 200 - yOffset  // 원래 titleLabel의 상단 위치에서 스크롤 양을 빼서 새 위치를 계산

            exhibitionImageView.snp.updateConstraints { make in
                make.height.equalTo(newHeight)
            }

            titleLabel.snp.updateConstraints { make in
                make.top.equalTo(contentView).offset(newTopOffset)
            }

            exhibitionImageView.layoutIfNeeded()
            titleLabel.layoutIfNeeded()
        }
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



class FirstPageViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        print("FirstPageViewController loaded")

        // FirstPageViewController의 뷰의 배경색을 설정
        view.backgroundColor = .white

        let redView = UIView()
        redView.backgroundColor = .red
        view.addSubview(redView)

        // redView의 레이아웃 제약 조건을 설정
        redView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(1000) // 빨강색 뷰의 높이를 1000으로 설정
        }
    }
}


class SecondPageViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        print("SecondPageViewController loaded")

        let blueView = UIView()
        blueView.backgroundColor = .blue
        view.addSubview(blueView)

        blueView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(1500) // 파랑색 뷰의 높이를 1500으로 설정
        }
    }
}


