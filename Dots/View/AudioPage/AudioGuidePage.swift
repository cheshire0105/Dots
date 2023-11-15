//
//  AudioGuidePage.swift
//  Dots
//
//  Created by cheshire on 10/23/23.
//  브랜치 audio 생성 및 변경

import UIKit
import SnapKit

class AudioGuideViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CustomTableViewCellDelegate {

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

    // 테이블 뷰 선언
     lazy var tableView: UITableView = {
         let tableView = UITableView()
         tableView.delegate = self
         tableView.dataSource = self
         tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomTableViewCell")
         tableView.separatorStyle = .none // 셀 사이의 구분선을 없앱니다.
         tableView.backgroundColor = .black
         return tableView
     }()




    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black

        navigationController?.setNavigationBarHidden(true, animated: false)


        setupCustomBackButton()
        setupTitleLabel() // 타이틀 레이블 설정 메서드 호출
        setupSegmentControl()
        setupTableView() // 테이블 뷰 설정 메서드 호출



    }

    // 테이블 뷰 설정 메서드
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(segmentControl.snp.bottom).offset(20) // 세그먼트 컨트롤 아래에 20포인트 간격을 둡니다.
            make.left.right.bottom.equalTo(view.safeAreaLayoutGuide) // 좌우 및 하단 여백 설정
        }
    }

    // UITableViewDataSource 메서드 구현
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10 // 예시로 10개의 셀을 반환하도록 설정합니다.
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        // 셀의 커스텀 설정을 여기에 추가합니다.
        cell.delegate = self // 셀의 delegate로 self를 할당합니다.

        return cell
    }

    // UITableViewDelegate 메서드 구현
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110 // 셀의 높이를 100포인트로 설정합니다.
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

    func accessoryButtonTapped(inCell cell: CustomTableViewCell) {
         let fullScreenModalVC = DetailAudioPage()
         fullScreenModalVC.modalPresentationStyle = .fullScreen // 풀 스크린 스타일을 설정합니다.
         present(fullScreenModalVC, animated: true) // 모달 뷰 컨트롤러를 표시합니다.
     }
}



import UIKit
import SnapKit

protocol CustomTableViewCellDelegate: AnyObject {
    func accessoryButtonTapped(inCell cell: CustomTableViewCell)
}

class CustomTableViewCell: UITableViewCell {
    private let thumbnailImageView = UIImageView()
    private let titleLabel = UILabel()
    private let timeLabel = UILabel()
    private let paddingView = UIView()
    private let accessoryButton = UIButton()
    weak var delegate: CustomTableViewCellDelegate?



    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .black

        setupPaddingView()
        setupThumbnailImageView()
        setupTitleLabel()
        setupTimeLabel()
        setupAccessoryButton() // 버튼 설정 메서드 호출

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupAccessoryButton() {
        accessoryButton.setImage(UIImage(named: "Group 46"), for: .normal) // 버튼에 이미지를 설정합니다.
        accessoryButton.contentMode = .scaleAspectFit // 컨텐츠를 비율에 맞게 채우도록 설정합니다.
        accessoryButton.backgroundColor = .clear // 배경색을 투명하게 설정합니다.
        accessoryButton.addTarget(self, action: #selector(accessoryButtonTapped), for: .touchUpInside) // 버튼 탭 액션을 추가합니다.

        paddingView.addSubview(accessoryButton)
        accessoryButton.snp.makeConstraints { make in
            make.right.equalTo(paddingView.snp.right).offset(-20)
            make.centerY.equalTo(paddingView.snp.centerY)
            make.width.height.equalTo(40) // 버튼의 크기를 설정합니다.
        }
    }



    func setAccessoryImage(_ image: UIImage) {
        // 버튼에 이미지를 설정합니다. 이미지가 .alwaysOriginal 렌더링 모드로 설정되어
        // 버튼에 이미지의 원래 색상이 유지되도록 합니다.
        accessoryButton.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
    }

    @objc private func accessoryButtonTapped() {
         delegate?.accessoryButtonTapped(inCell: self) // 델리게이트에게 버튼 탭 이벤트를 알립니다.
     }

    private func setupPaddingView() {
        paddingView.backgroundColor = UIColor(red: 0.145, green: 0.145, blue: 0.145, alpha: 0.7)
        paddingView.layer.cornerRadius = 20
        paddingView.clipsToBounds = true
        contentView.addSubview(paddingView)
        paddingView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(10)
            make.bottom.equalTo(contentView.snp.bottom).offset(-10)
            make.left.equalTo(contentView.snp.left).offset(10)
            make.right.equalTo(contentView.snp.right).offset(-10)
        }
    }

    private func setupThumbnailImageView() {
        thumbnailImageView.layer.cornerRadius = 15
        thumbnailImageView.clipsToBounds = true
        thumbnailImageView.contentMode = .scaleAspectFill // 이미지가 뷰에 꽉 차도록 설정
        thumbnailImageView.backgroundColor = .lightGray // Placeholder color

        paddingView.addSubview(thumbnailImageView)
        thumbnailImageView.snp.makeConstraints { make in
            make.left.equalTo(paddingView.snp.left).offset(10)
            make.centerY.equalTo(paddingView.snp.centerY)
            make.width.height.equalTo(paddingView.snp.height).multipliedBy(0.8) // 정사각형으로 설정
        }
    }

    private func setupTitleLabel() {
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.text = "Signal Projection, 2023"

        paddingView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(thumbnailImageView.snp.right).offset(10)
            make.right.equalTo(paddingView.snp.right).offset(-10)
            make.top.equalTo(thumbnailImageView.snp.top).offset(10)
        }
    }

    private func setupTimeLabel() {
        timeLabel.textColor = .lightGray
        timeLabel.font = UIFont.systemFont(ofSize: 14)
        timeLabel.text = "03:44"

        paddingView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
            make.left.equalTo(thumbnailImageView.snp.right).offset(10)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.bottom.lessThanOrEqualTo(thumbnailImageView.snp.bottom) // 시간 레이블의 바텀이 이미지 바텀에 걸치지 않도록 설정
        }
    }

    // Configure cell with data
    func configure(with title: String, time: String, image: UIImage?, accessoryButtonImage: UIImage?) {
        titleLabel.text = title
        timeLabel.text = time
        thumbnailImageView.image = image ?? UIImage(named: "placeholder") // Use a placeholder image if none provided
        accessoryButton.setImage(accessoryButtonImage, for: .normal) // 버튼 이미지 설정

    }
}
