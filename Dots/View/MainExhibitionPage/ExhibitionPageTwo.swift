//
//  ExhibitionPageTwo.swift
//  Dots
//
//  Created by cheshire on 11/10/23.
//

import Foundation
import UIKit
import SnapKit
import UIKit
import FirebaseStorage
import Firebase

class BackgroundImageViewController: UIViewController, UIGestureRecognizerDelegate {

    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "loginBack"), for: .normal) // 버튼의 기본 상태 이미지를 설정합니다.
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside) // 버튼 액션 추가
        return button
    }()

    lazy var headsetIcon: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "headset help_"), for: .normal) // 버튼의 기본 상태 이미지를 설정합니다.
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(presentAudioGuideViewController), for: .touchUpInside) // 버튼 액션 추가
        return button
    }()
    lazy var heartIcon: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "heartIcon"), for: .normal) // 버튼의 기본 상태 이미지를 설정합니다.
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(heartIconTapped), for: .touchUpInside) // 버튼 액션 추가
        return button
    }()

    lazy var recordButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Union 4"), for: .normal) // 버튼의 기본 상태 이미지를 설정합니다.
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(recordButtonTapped), for: .touchUpInside) // 버튼 액션 추가
        return button
    }()

    lazy var AddInfoButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(presentInfoModal), for: .touchUpInside) // 버튼 액션 추가
        return button
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "현대차 시리즈 2023 : 정연두 - 백년여행" // 타이틀 텍스트 설정
        label.textColor = .white // 텍스트 색상 설정
        label.font = UIFont(name: "Pretendard-Bold", size: 30)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()

    private lazy var blurEffectView: UIVisualEffectView = {
          let blurEffect = UIBlurEffect(style: .dark)
          let view = UIVisualEffectView(effect: blurEffect)
          view.frame = self.view.bounds
          view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
          view.isHidden = true // 처음에는 숨겨둡니다.
          return view
      }()

      private lazy var customAlertView: UIView = {
          let view = UIView()
          view.backgroundColor = UIColor(red: 0.882, green: 1, blue: 0, alpha: 1)
          view.layer.cornerRadius = 20
          view.isHidden = true // 처음에는 숨겨둡니다.
          return view
      }()

    private func setupTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(16) // 왼쪽 가장자리에서 10포인트 떨어진 위치
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-40)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-80) // 하단 가장자리에서 10포인트 떨어진 위치

        }
    }

    private lazy var alertTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "언제 다녀오셨나요?"
        label.textColor = .black
        label.font = UIFont(name: "Pretendard-SemiBold", size: 18)
        label.textAlignment = .center
        return label
    }()

    private lazy var alertSubtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "다녀온 날짜를 입력해주시면 마이페이지에 나만의 전시 캘린더가 제공됩니다."
        label.textColor = .darkGray
        label.font = UIFont(name: "Pretendard-Regular", size: 14)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private lazy var datePicker: UIDatePicker = {
         let picker = UIDatePicker()
         picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .wheels
         picker.addTarget(self, action: #selector(datePickerChanged(_:)), for: .valueChanged)
         return picker
     }()

     @objc func datePickerChanged(_ sender: UIDatePicker) {
         // 날짜가 변경될 때 수행할 동작을 여기에 추가합니다.
         // 예: 선택된 날짜를 어딘가에 저장하거나 표시합니다.
     }

    
    private lazy var confirmButton: UIButton = {
          let button = UIButton()
          button.setTitle("등록하기", for: .normal)
        button.backgroundColor = .black
          button.setTitleColor(.white, for: .normal)
          button.layer.cornerRadius = 25 // 모서리 둥글게
          button.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
          return button
      }()

    @objc func confirmButtonTapped() {
          // 버튼을 눌렀을 때 수행할 동작을 여기에 추가합니다.
        customAlertView.isHidden = true
               blurEffectView.isHidden = true
      }


    @objc func presentInfoModal() {
        let detailViewController = DetailViewController()
        detailViewController.posterImageName = self.posterImageName // 포스터 이름 설정

        // DetailViewController의 presentationController 설정
        if let sheetController = detailViewController.presentationController as? UISheetPresentationController {
            // 사용자 정의 detent 생성
            let customDetentIdentifier = UISheetPresentationController.Detent.Identifier("customDetent")
            let customDetent = UISheetPresentationController.Detent.custom(identifier: customDetentIdentifier) { _ in
                // 모든 기기에서 항상 높이가 700인 detent를 만들어낼 수 있습니다.
                let safeAreaBottom = UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0
                return 700 - safeAreaBottom
            }

            // 중간 높이와 사용자 정의 높이를 포함하는 detent 설정
            sheetController.detents = [.medium(), customDetent]
            detailViewController.isModalInPresentation = false

            sheetController.largestUndimmedDetentIdentifier = customDetentIdentifier // 최대 높이를 커스텀 detent로 설정합니다.
            sheetController.prefersScrollingExpandsWhenScrolledToEdge = true // 스크롤할 때 시트가 확장되도록 설정합니다.
            sheetController.preferredCornerRadius = 30 // 둥근 모서리 설정을 유지합니다.
        }

        // 모달 표시 설정
        detailViewController.modalPresentationStyle = .pageSheet
        self.present(detailViewController, animated: true, completion: nil)
    }


    var posterImageName: String?
    var titleName : String?

    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView(frame: self.view.bounds)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()


//    override func viewWillAppear(_ animated: Bool) {
//        if let glassTabBar = tabBarController as? GlassTabBar {
//            glassTabBar.customTabBarView.isHidden = true
//        }
//    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)

//        presentModalViewController() // 뷰가 나타날 때 모달을 바로 표시합니다.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 탭바를 숨깁니다.
        tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 다른 화면으로 이동하기 전에 탭바를 다시 표시합니다.
        tabBarController?.tabBar.isHidden = false
    }



    override func viewDidLoad() {
         super.viewDidLoad()
         view.backgroundColor = .black

         // 기존의 backgroundImageView 설정 코드를 제거하고 새로운 코드로 대체합니다.
         view.addSubview(backgroundImageView)
         view.sendSubviewToBack(backgroundImageView)

         setupBackButton()

         // 이미지 로딩을 위한 함수 호출
         if let posterName = posterImageName {
             setupBackgroundImage(with: posterName)
         }


        setupTitleLabel() // 타이틀 레이블 설정 호출

        if let titleName = titleName {
              titleLabel.text = titleName
          }

        view.addSubview(blurEffectView)
                view.addSubview(customAlertView)
                setupCustomAlertView()
     }

    private func setupCustomAlertView() {
        customAlertView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(310)
            make.height.equalTo(390)
        }

        customAlertView.addSubview(alertTitleLabel)
           customAlertView.addSubview(alertSubtitleLabel)

           alertTitleLabel.snp.makeConstraints { make in
               make.top.equalTo(customAlertView.snp.top).offset(20)
               make.left.right.equalTo(customAlertView).inset(10)
           }

           alertSubtitleLabel.snp.makeConstraints { make in
               make.top.equalTo(alertTitleLabel.snp.bottom).offset(10)
               make.left.right.equalTo(customAlertView).inset(30)
           }

        customAlertView.addSubview(datePicker)
              datePicker.snp.makeConstraints { make in
                  make.top.equalTo(alertSubtitleLabel.snp.bottom).offset(20)

                  make.centerX.equalTo(customAlertView.snp.centerX)
              }

        customAlertView.addSubview(confirmButton)
            confirmButton.snp.makeConstraints { make in
                make.top.equalTo(datePicker.snp.bottom).offset(10)
                make.centerX.equalTo(customAlertView.snp.centerX)
                make.width.equalTo(273) // 버튼의 너비
                make.height.equalTo(56) // 버튼의 높이
                make.bottom.equalTo(customAlertView.snp.bottom).inset(10)
            }
    }





    private func setupBackgroundImage(with imageName: String) {
           let storageRef = Storage.storage().reference(withPath: "images/\(imageName).png")
           storageRef.downloadURL { [weak self] (url, error) in
               if let error = error {
                   print("Error getting download URL: \(error)")
               } else if let url = url {
                   // 이미지 로드
                   URLSession.shared.dataTask(with: url) { (data, _, error) in
                       guard let data = data, error == nil else { return }
                       DispatchQueue.main.async {
                           self?.backgroundImageView.image = UIImage(data: data)
                       }
                   }.resume()
               }
           }
       }




    private func setupBackButton() {
        view.addSubview(backButton) // 백 버튼을 뷰에 추가합니다.
        view.addSubview(headsetIcon) // 백 버튼을 뷰에 추가합니다.
        view.addSubview(heartIcon)
        view.addSubview(recordButton)
        view.addSubview(AddInfoButton)



        backButton.snp.makeConstraints { make in // SnapKit을 사용하여 제약 조건 설정
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10) // 상단 safe area로부터 10포인트 아래에 위치
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(10) // leading edge로부터 10포인트 떨어진 곳에 위치
            make.width.height.equalTo(40) // 너비와 높이는 40포인트로 설정
        }
        
        recordButton.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-10)
            make.width.height.equalTo(40)
        }

        heartIcon.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.trailing.equalTo(recordButton.snp.leading).offset(-10)
            make.width.height.equalTo(40)
        }

        headsetIcon.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.trailing.equalTo(heartIcon.snp.leading).offset(-10)
            make.width.height.equalTo(40)
        }

        AddInfoButton.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.trailing.equalTo(headsetIcon.snp.leading).offset(-10)
            make.width.height.equalTo(40)
        }
    }



    @objc func heartIconTapped() {
        let isSelected = heartIcon.isSelected
        heartIcon.isSelected = !isSelected // 버튼의 선택 상태를 토글합니다.

        let newImageName = isSelected ? "heartIcon" : "Vector 1" // 새 이미지 이름
        heartIcon.setImage(UIImage(named: newImageName), for: .normal)
    }

    @objc func recordButtonTapped() {
        let isSelected = recordButton.isSelected
        recordButton.isSelected = !isSelected // 버튼의 선택 상태를 토글합니다.

        let newImageName = isSelected ? "Union 4" : "footprint_sleected" // 새 이미지 이름
        recordButton.setImage(UIImage(named: newImageName), for: .normal)

        blurEffectView.isHidden = false
        customAlertView.isHidden = false
    }




    @objc func backButtonTapped() {
        // 여기에 뒤로 가기 버튼을 눌렀을 때의 동작을 구현하세요.
        navigationController?.popViewController(animated: true) // 네비게이션 컨트롤러를 사용하는 경우
    }

    // 오디오 가이드 페이지로 이동하는 메서드
    // AudioGuideViewController를 표시하는 버튼 액션 또는 메서드 내부
    @objc func presentAudioGuideViewController() {
        // 현재 모달을 닫고, 완료 콜백에서 AudioGuideViewController를 푸시합니다.
        self.dismiss(animated: true) {
            if let navigationController = self.navigationController {
                let audioGuideViewController = AudioGuideViewController()
                navigationController.pushViewController(audioGuideViewController, animated: true)
            }
        }
    }



    private func presentModalViewController() {
          let detailViewController = DetailViewController()
          detailViewController.posterImageName = self.posterImageName // 포스터 이름 설정
      }



}




class 새로운_ReviewTableViewCell: UITableViewCell {

    // UI 컴포넌트 선언
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()

    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        label.numberOfLines = 0 // 멀티라인을 허용합니다.
        return label
    }()

    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var nicknameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        return label
    }()

    private let container = UIView()


    // 초기화 메서드
    // 초기화 메서드
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        // 컨테이너 뷰 설정
        container.backgroundColor = .darkGray
        container.layer.cornerRadius = 10
        container.clipsToBounds = true

        contentView.backgroundColor = .black
        selectionStyle = .none

        // 컨테이너 뷰를 contentView에 추가합니다.
        contentView.addSubview(container)

        // 모든 서브뷰를 컨테이너 뷰에 추가합니다.
        container.addSubview(titleLabel)
        container.addSubview(contentLabel)
        container.addSubview(profileImageView)
        container.addSubview(nicknameLabel)

        // 컨테이너 뷰에 대한 제약조건을 설정합니다.
        container.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(10) // 상단에 10포인트의 여백을 추가합니다.
            make.bottom.equalTo(contentView.snp.bottom).offset(-10) // 하단에 10포인트의 여백을 추가합니다.
            make.left.equalTo(contentView.snp.left).offset(10) // 좌측에 10포인트의 여백을 추가합니다.
            make.right.equalTo(contentView.snp.right).offset(-10) // 우측에 10포인트의 여백을 추가합니다.
        }

        // 다른 UI 컴포넌트들의 레이아웃 설정을 업데이트합니다. (titleLabel, contentLabel, profileImageView, nicknameLabel 제약조건은 container 기준으로 업데이트합니다)
        setupLayout()
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // 레이아웃 설정 메서드
    private func setupLayout() {

        // 제목 레이블의 레이아웃 설정
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15) // 상단 여백 설정
            make.left.equalToSuperview().offset(10) // 좌측 여백 설정
            make.right.equalToSuperview().offset(-10) // 우측 여백 설정
        }

        // 내용 레이블의 레이아웃 설정
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(10) // 제목 레이블 아래 간격을 둡니다.
            make.left.right.equalTo(titleLabel)
            make.bottom.lessThanOrEqualToSuperview().offset(-10) // 셀 하단 여백 설정 // 유동적으로 늘어나야 할 때 사용 하는 메서드.

        }

        // 프로필 이미지 뷰의 레이아웃 설정
        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10) // 좌측 여백 설정
            make.width.height.equalTo(30) // 이미지 크기를 30x30으로 설정
        }

        // 닉네임 레이블의 레이아웃 설정
        nicknameLabel.snp.makeConstraints { make in
            make.right.equalTo(profileImageView.snp.left).offset(-10) // 프로필 이미지 오른쪽에 위치
            make.centerY.equalTo(profileImageView.snp.centerY) // 프로필 이미지와 중앙 정렬
        }
    }

    // 셀에 리뷰 정보를 설정하는 메서드
    func setReview(title: String, content: String, profileImage: UIImage?, nickname: String) {
        titleLabel.text = title
        contentLabel.text = content
        profileImageView.image = profileImage
        nicknameLabel.text = nickname
    }
}

