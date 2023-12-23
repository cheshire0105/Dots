//
//  ExhibitionPageTwo.swift
//  Dots
//
//  Created by cheshire on 11/10/23.
//
// 최신화

import Foundation
import UIKit
import SnapKit
import UIKit
import FirebaseStorage
import Firebase
import Toast_Swift

class BackgroundImageViewController: UIViewController, UIGestureRecognizerDelegate {

    lazy var createCustomBackButton : UIButton = {
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
    }()


    lazy var createCustomHeadsetIcon :  UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "headset help_"), for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.layer.shadowOpacity = 0.9
        button.layer.shadowRadius = 2
        button.layer.shadowOffset = CGSize(width: 1, height: 1)
        button.layer.shadowColor = UIColor.black.cgColor
        button.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        button.addTarget(self, action: #selector(presentAudioGuideViewController), for: .touchUpInside)
        return button
    }()

    lazy var heartIcon: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "라이크"), for: .normal) // 버튼의 기본 상태 이미지를 설정합니다.



        button.addTarget(self, action: #selector(heartIconTapped), for: .touchUpInside) // 버튼 액션 추가
        return button
    }()

    lazy var recordButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "footprint"), for: .normal) // 버튼의 기본 상태 이미지를 설정합니다.


        button.addTarget(self, action: #selector(recordButtonTapped), for: .touchUpInside) // 버튼 액션 추가
        return button
    }()

    lazy var mapPageButton: UIButton = {
        let button = UIButton()

        button.setImage(UIImage(named: "쉐어"), for: .normal) // 버튼의 기본 상태 이미지를 설정합니다.


        button.addTarget(self, action: #selector(mapPageLoad), for: .touchUpInside) // 버튼 액션 추가
        return button
    }()

    lazy var modalLoadButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Union 6"), for: .normal) // 버튼의 기본 상태 이미지를 설정합니다.
        // 그림자 설정
        button.layer.shadowOpacity = 0.9
        button.layer.shadowRadius = 2
        button.layer.shadowOffset = CGSize(width: 1, height: 1)
        button.layer.shadowColor = UIColor.black.cgColor
        button.addTarget(self, action: #selector(presentInfoModal), for: .touchUpInside) // 버튼 액션 추가
        return button
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "현대차 시리즈 2023 : 정연두 - 백년여행"
        label.textColor = .white
        label.font = UIFont(name: "Pretendard-Bold", size: 25)
        label.textAlignment = .left
        label.numberOfLines = 0

        // 그림자 설정
        label.layer.shadowOpacity = 0.9
        label.layer.shadowRadius = 2
        label.layer.shadowOffset = CGSize(width: 1, height: 1)
        label.layer.shadowColor = UIColor.black.cgColor

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
        view.backgroundColor = UIColor(red: 0.153, green: 0.157, blue: 0.165, alpha: 1)
        view.layer.cornerRadius = 20
        view.isHidden = true // 처음에는 숨겨둡니다.
        return view
    }()

    private lazy var alertTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "언제 다녀오셨나요?"
        label.textColor = UIColor(red: 0.875, green: 0.871, blue: 0.886, alpha: 1)
        label.font = UIFont(name: "Pretendard-SemiBold", size: 18)
//        label.textAlignment = .center
        return label
    }()

    private lazy var alertSubtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "다녀온 날짜를 입력해주시면 마이페이지에 나만의 전시 캘린더가 제공됩니다."
        label.textColor = UIColor(red: 0.757, green: 0.753, blue: 0.773, alpha: 1)
        label.font = UIFont(name: "Pretendard-Regular", size: 14)
//        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .wheels
        picker.overrideUserInterfaceStyle = .dark

        // 한국어 로케일 설정
        picker.locale = Locale(identifier: "ko-KR")

        picker.addTarget(self, action: #selector(datePickerChanged(_:)), for: .valueChanged)
        return picker
    }()

    private lazy var visitorIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "footprint_sleected 1") // 방문자 아이콘 이미지 설정
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var visitorCountLabel: UILabel = {
        let label = UILabel()
        label.text = "아직 방문 등록이 되지 않았네요!" // 초기 텍스트 설정
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        label.font = UIFont(name: "Pretendard-SemiBold", size: 16)
        return label
    }()

    private lazy var visitorStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [visitorIconImageView, visitorCountLabel])
        stackView.axis = .horizontal
        stackView.spacing = 5 // 이미지와 레이블 사이 간격
        stackView.alignment = .center
        return stackView
    }()

    private lazy var confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle("수정", for: .normal)
        button.backgroundColor = UIColor(red: 0.882, green: 1, blue: 0, alpha: 1)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 20 // 모서리 둥글게

        // 폰트 설정
        button.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 16)

        button.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        return button
    }()


    private lazy var mapAlertView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.882, green: 1, blue: 0, alpha: 1)
        view.layer.cornerRadius = 20
        view.isHidden = true // 처음에는 숨겨둡니다.
        return view
    }()

    var posterImageName: String?
    var titleName : String?

    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView(frame: self.view.bounds)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("기록 삭제", for: .normal)
        button.backgroundColor = .red
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        button.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 16)
        button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        return button
    }()


    func checkIfVisitAlreadyRegistered(posterName: String, completion: @escaping (Bool, String?) -> Void) {
        guard let userID = Auth.auth().currentUser?.uid else {
            completion(false, nil)
            return
        }

        let userVisitDocument = Firestore.firestore().collection("posters").document(posterName).collection("reviews").document(userID)

        userVisitDocument.getDocument { (documentSnapshot, error) in
            if let error = error {
                print("Error fetching document: \(error)")
                completion(false, nil)
                return
            }

            if let document = documentSnapshot, document.exists {
                let visited = document.data()?["visited"] as? Bool ?? false
                let visitDate = document.data()?["유저_다녀옴_날짜"] as? String
                completion(visited, visitDate)
            } else {
                completion(false, nil)
            }
        }
    }


    // 사용자가 이미 방문을 등록했는지 확인하는 함수
    func checkIfVisitAlreadyRegistered(posterName: String, completion: @escaping (Bool) -> Void) {
        guard let userID = Auth.auth().currentUser?.uid else {
            completion(false)
            return
        }

        let userVisitDocument = Firestore.firestore().collection("posters").document(posterName).collection("reviews").document(userID)

        userVisitDocument.getDocument { (documentSnapshot, error) in
            if let error = error {
                print("Error fetching document: \(error)")
                completion(false)
                return
            }

            if let document = documentSnapshot, document.exists {
                // 'visited' 필드를 확인하여 이미 방문했는지 검사
                let visited = document.data()?["visited"] as? Bool ?? false
                completion(visited)
            } else {
                // 문서가 없으면 아직 방문을 등록하지 않은 것으로 간주
                completion(false)
            }
        }
    }

    // 전시 타이틀을 조회하고 설정하는 함수
    func fetchAndSetExhibitionTitle(posterId: String) {
        let db = Firestore.firestore()
        let docRef = db.collection("전시_상세").document(posterId)

        docRef.getDocument { [weak self] (document, error) in
            if let document = document, document.exists {
                if let exhibitionTitle = document.data()?["전시_타이틀"] as? String {
                    DispatchQueue.main.async {
                        self?.titleLabel.text = exhibitionTitle
                    }
                }
            } else {
                print("Document does not exist or error: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
    }


    func showAlreadyRegisteredAlert() {
        let alert = UIAlertController(title: "알림", message: "이미 이 전시를 방문하셨습니다.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    func showVisitRegistrationAlert(withEditing: Bool, existingDate: String?) {
        if withEditing {
            alertSubtitleLabel.text = "방문 날짜를 수정하실 수 있습니다."

            // 날짜 형식 설정
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"

            if let existingDate = existingDate, let date = dateFormatter.date(from: existingDate) {
                datePicker.date = date // UIDatePicker에 날짜 설정
            }

            // 수정하는 경우에만 삭제 버튼을 보여줍니다.
            deleteButton.isHidden = false
            // 버튼 제목을 "수정"으로 설정
            confirmButton.setTitle("수정 하기", for: .normal)
            confirmButton.setTitleColor(UIColor(red: 0.745, green: 0.741, blue: 0.761, alpha: 1), for: .normal)

            confirmButton.backgroundColor = UIColor(red: 0.224, green: 0.231, blue: 0.243, alpha: 1)

        } else {
            alertSubtitleLabel.text = "다녀온 날짜를 입력해주시면 마이페이지에 나만의 전시 캘린더가 제공됩니다."

            // 새로 등록하는 경우 삭제 버튼을 숨깁니다.
            deleteButton.isHidden = true

            // 버튼 제목을 "등록하기"로 설정
            confirmButton.setTitle("등록하기", for: .normal)
            confirmButton.backgroundColor = UIColor(red: 0.882, green: 1, blue: 0, alpha: 1)
            confirmButton.setTitleColor(.black, for: .normal)


        }

        self.blurEffectView.isHidden = false
        self.customAlertView.isHidden = false
    }





    private func setupTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(16) // 왼쪽 가장자리에서 10포인트 떨어진 위치
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).inset(50)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-110) // 하단 가장자리에서 10포인트 떨어진 위치

        }

        // titleLabel 아래에 스택 뷰 추가
        view.addSubview(visitorStackView)
        visitorStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalTo(titleLabel.snp.leading)
        }
    }




    @objc func datePickerChanged(_ sender: UIDatePicker) {
        // 날짜가 변경될 때 수행할 동작을 여기에 추가합니다.
        // 예: 선택된 날짜를 어딘가에 저장하거나 표시합니다.
    }


    @objc func confirmButtonTapped() {
        let selectedDate = datePicker.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: selectedDate)

        if let posterName = self.posterImageName {
            checkIfVisitAlreadyRegistered(posterName: posterName) { [weak self] alreadyVisited, _ in
                if alreadyVisited {
                    // 이미 방문을 등록한 경우, 날짜만 업데이트합니다.
                    self?.updateVisitDateInFirestore(visitDate: dateString, posterName: posterName) {
                        self?.dismissAlertViews()
                    }
                } else {
                    // 방문을 처음 등록하는 경우, 날짜를 추가하고 방문 횟수를 증가시킵니다.
                    self?.addVisitDateToFirestore(visitDate: dateString, posterName: posterName) {
                        self?.dismissAlertViews()
                    }
                }
            }
        } else {
            print("Poster name is not available")
        }
    }

    func dismissAlertViews() {
        DispatchQueue.main.async {
            self.customAlertView.isHidden = true
            self.mapAlertView.isHidden = true // mapAlertView도 숨깁니다.
            self.blurEffectView.isHidden = true
        }
    }

    func updateVisitDateInFirestore(visitDate: String, posterName: String, completion: @escaping () -> Void) {
        guard let userID = Auth.auth().currentUser?.uid else {
            print("User ID is not available")
            return
        }

        let userVisitDocument = Firestore.firestore().collection("posters").document(posterName).collection("reviews").document(userID)

        userVisitDocument.updateData(["유저_다녀옴_날짜": visitDate, "visited": true]) { error in
            if let error = error {
                print("Error updating document: \(error)")
            } else {
                print("Document successfully updated")
                completion()
            }
        }
    }







    func addVisitDateToFirestore(visitDate: String, posterName: String, completion: @escaping () -> Void) {
        guard let userID = Auth.auth().currentUser?.uid else {
            print("User ID is not available")
            return
        }

        let db = Firestore.firestore()
        let userVisitDocument = db.collection("posters").document(posterName).collection("reviews").document(userID)
        let posterDocument = db.collection("posters").document(posterName)

        // Firestore의 트랜잭션을 사용하여 방문 횟수를 안전하게 증가시킵니다.
        db.runTransaction({ (transaction, errorPointer) -> Any? in
            let posterDocumentSnapshot: DocumentSnapshot
            do {
                try posterDocumentSnapshot = transaction.getDocument(posterDocument)
            } catch let fetchError as NSError {
                errorPointer?.pointee = fetchError
                return nil
            }

            // 현재 방문 횟수를 가져옵니다.
            let currentVisitorCount = posterDocumentSnapshot.data()?["visits"] as? Int ?? 0
            // 방문 횟수를 1 증가시킵니다.
            let newVisitorCount = currentVisitorCount + 1

            // 사용자 방문 데이터와 포스터의 방문 횟수를 업데이트합니다.
            transaction.setData(["유저_다녀옴_날짜": visitDate, "visited": true], forDocument: userVisitDocument, merge: true)

            transaction.updateData(["visits": newVisitorCount], forDocument: posterDocument)

            return nil
        }) { (object, error) in
               if let error = error {
                   print("트랜잭션 실패: \(error)")
               } else {
                   print("트랜잭션이 성공적으로 완료됨")
                   self.recordButton.setImage(UIImage(named: "footprint 1"), for: .normal)

                   completion()
                   self.fetchVisitorCountAndUpdateLabel() // 방문자 수 레이블을 업데이트합니다.
               }
        }
    }





    // 서버에서 방문자 수를 가져오고 레이블 업데이트하는 메서드
    func fetchVisitorCountAndUpdateLabel() {
        guard let posterName = self.posterImageName else {
            print("Poster name is not available")
            return
        }

        let db = Firestore.firestore()
        let posterDocument = db.collection("posters").document(posterName)

        posterDocument.getDocument { [weak self] (documentSnapshot, error) in
            if let error = error {
                print("Error fetching document: \(error)")
                return
            }

            if let document = documentSnapshot, document.exists {
                let visitorCount = document.data()?["visits"] as? Int ?? 0
                DispatchQueue.main.async {
                    if visitorCount > 0 {
                        self?.visitorCountLabel.text = "\(visitorCount)명이 다녀왔어요"
                    } else {
                        // 방문자 수가 0명일 경우의 메시지
                        self?.visitorCountLabel.text = "아직 방문 등록이 되지 않았네요!"
                    }
                }
            } else {
                print("Document does not exist")
            }
        }
    }







    @objc func presentInfoModal() {
        let detailViewController = DetailViewController()
        detailViewController.posterImageName = self.posterImageName // 포스터 이름을 전달합니다.

        // DetailViewController의 presentationController 설정
        if let sheetController = detailViewController.presentationController as? UISheetPresentationController {
            sheetController.prefersGrabberVisible = true

            // 중간 높이와 사용자 정의 높이를 포함하는 detent 설정
            sheetController.detents = [.medium(), .large()]
            detailViewController.isModalInPresentation = false
            sheetController.largestUndimmedDetentIdentifier = .large // 최대 높이를 커스텀 detent로 설정합니다.
            sheetController.prefersScrollingExpandsWhenScrolledToEdge = true // 스크롤할 때 시트가 확장되도록 설정합니다.
            sheetController.preferredCornerRadius = 30 // 둥근 모서리 설정을 유지합니다.
        }

        // 모달 표시 설정
        detailViewController.modalPresentationStyle = .pageSheet
        self.present(detailViewController, animated: true, completion: nil)
    }






    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 탭바를 숨깁니다.
        tabBarController?.tabBar.isHidden = true
        navigationController?.setNavigationBarHidden(true, animated: animated)
        updateHeartIconStateFromFirestore()


    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)



    }

    func updateHeartIconStateFromFirestore() {
        guard let posterName = self.posterImageName, let userID = Auth.auth().currentUser?.uid else {
            return
        }

        let db = Firestore.firestore()
        let posterDocument = db.collection("posters").document(posterName)

        posterDocument.getDocument { [weak self] (documentSnapshot, error) in
            if let error = error {
                print("Error fetching document: \(error)")
                return
            }

            if let document = documentSnapshot, document.exists {
                let userLikes = document.data()?["userLikes"] as? [String: Bool] ?? [:]
                let isLiked = userLikes[userID] ?? false

                DispatchQueue.main.async {
                    self?.heartIcon.isSelected = isLiked
                    self?.updateHeartIconState()
                }
            }
        }
    }





    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self

        // 네비게이션 바 대형 타이틀 비활성화

        // 네비게이션 백 버튼 설정
        setupNavigationBackButton()
        // 기존의 backgroundImageView 설정 코드를 제거하고 새로운 코드로 대체합니다.
        view.addSubview(backgroundImageView)
        view.sendSubviewToBack(backgroundImageView)

        let gradientView = UIView()
        view.insertSubview(gradientView, aboveSubview: backgroundImageView)

        // 스냅킷을 사용하여 그라데이션 뷰의 제약 조건 설정
        gradientView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor,
            UIColor(red: 0, green: 0, blue: 0, alpha: 0.35).cgColor,
            UIColor(red: 0, green: 0, blue: 0, alpha: 0.80).cgColor,
            UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        ]
        gradientLayer.locations = [0, 0.37, 0.68, 1]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0) // 그라데이션 시작점을 위쪽 중앙으로 설정
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1) // 그라데이션 끝점을 아래쪽 중앙으로 설정

        // 뷰의 크기가 결정된 후에 그라데이션 레이어의 크기를 업데이트합니다.
        gradientView.layer.layoutIfNeeded()
        gradientLayer.frame = gradientView.bounds

        gradientView.layer.addSublayer(gradientLayer)
        setupBackButton()

        // 이미지 로딩을 위한 함수 호출
        if let posterName = posterImageName {
            setupBackgroundImage(with: posterName)
        }

        // 딥링크에서 poster 매개변수 값을 사용하여 전시 타이틀을 설정합니다.
            if let posterId = self.posterImageName {
                fetchAndSetExhibitionTitle(posterId: posterId)
            }

        if let posterName = self.posterImageName {
            checkIfVisitAlreadyRegistered(posterName: posterName) { [weak self] visited in
                DispatchQueue.main.async {
                    if visited {
                        // 이미 방문을 등록했다면 변경된 이미지로 설정
                        self?.recordButton.setImage(UIImage(named: "footprint 1"), for: .normal)
                    } else {
                        // 아직 방문을 등록하지 않았다면 기본 이미지로 설정
                        self?.recordButton.setImage(UIImage(named: "footprint"), for: .normal)
                    }
                }
            }
        }


        setupTitleLabel() // 타이틀 레이블 설정 호출

        if let titleName = titleName {
            titleLabel.text = titleName
        }



        view.addSubview(blurEffectView)
        view.addSubview(customAlertView)
        setupCustomAlertView()

        // blurEffectView에 탭 제스처 인식기 추가
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(blurViewTapped))
        blurEffectView.addGestureRecognizer(tapGesture)
        blurEffectView.isUserInteractionEnabled = true // 사용자 상호작용 활성화


        view.addSubview(mapAlertView)
        setupAlertView()

        fetchVisitorCountAndUpdateLabel()


    }

    private func setupNavigationBackButton() {

    }


    @objc func backButtonTapped() {
        // 네비게이션 컨트롤러로 뒤로 가기
        navigationController?.popViewController(animated: true)
    }

    private func setupAlertView() {

        mapAlertView.backgroundColor = UIColor(red: 0.153, green: 0.157, blue: 0.165, alpha: 1)
        mapAlertView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(310)
            make.height.equalTo(180)
        }


        // "공유" 타이틀 레이블 생성 및 설정
        let titleLabel = UILabel()
        titleLabel.text = "전시를 공유할까요?"
        titleLabel.textColor = UIColor(red: 0.875, green: 0.871, blue: 0.886, alpha: 1)
        titleLabel.font = UIFont(name: "Pretendard-SemiBold", size: 18)

        mapAlertView.addSubview(titleLabel)

        // 타이틀 레이블의 제약 조건 설정
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(mapAlertView.snp.top).offset(20)
            make.left.equalTo(mapAlertView).inset(24)
        }

        // "공유" 타이틀 레이블 생성 및 설정
        let titleLabelTwo = UILabel()
        titleLabelTwo.text = "함께 하고 싶은 친구에게 전시정보를 공유해보세요."
        titleLabelTwo.textColor = UIColor(red: 0.875, green: 0.871, blue: 0.886, alpha: 1)
        titleLabelTwo.font = UIFont(name: "Pretendard-Regular", size: 16)
        titleLabelTwo.numberOfLines = 2
        titleLabelTwo.lineBreakMode = .byCharWrapping // 단어 단위로 줄 바꿈 설정


        mapAlertView.addSubview(titleLabelTwo)

        // 타이틀 레이블의 제약 조건 설정
        titleLabelTwo.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalTo(mapAlertView.snp.leading).inset(24)
            make.trailing.equalTo(mapAlertView.snp.trailing).inset(24)
        }




        // 딥 링크 URL 생성
        let deepLink = createDeepLink()

        // 딥 링크를 표시하는 레이블 생성
        let deepLinkLabel = UILabel()
        deepLinkLabel.text = deepLink
        deepLinkLabel.textColor = .black
        deepLinkLabel.font = UIFont(name: "Pretendard-Regular", size: 14)
        deepLinkLabel.numberOfLines = 0
        deepLinkLabel.isUserInteractionEnabled = true // 사용자 상호작용 활성화

        mapAlertView.addSubview(deepLinkLabel)


        let confirmButton = UIButton()
        confirmButton.setTitle("공유 하기", for: .normal)
        confirmButton.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 16)
        confirmButton.backgroundColor = UIColor(red: 0.882, green: 1, blue: 0, alpha: 1)
        confirmButton.setTitleColor(.black, for: .normal)
        confirmButton.layer.cornerRadius = 20 // 모서리 둥글게
        confirmButton.addTarget(self, action: #selector(shareDeepLink), for: .touchUpInside)




        mapAlertView.addSubview(confirmButton)

        confirmButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabelTwo.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(50)
            make.height.equalTo(40)
        }

    }

    @objc private func shareDeepLink() {
        let deepLink = createDeepLink()
        let items = [deepLink]

        let activityViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // 아이패드에서 사용할 경우

        self.present(activityViewController, animated: true, completion: nil)
    }


    @objc func blurViewTapped() {
        customAlertView.isHidden = true
        mapAlertView.isHidden = true // mapAlertView도 숨깁니다.
        blurEffectView.isHidden = true
    }


    @objc func mapPageLoad() {
        // mapAlertView를 표시하는 코드
        mapAlertView.isHidden = false
        blurEffectView.isHidden = false

        // 필요한 경우 여기에 추가적인 동작을 구현합니다.
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
            make.left.right.equalTo(customAlertView).inset(30)
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
//            make.width.equalTo(273) // 버튼의 너비
//            make.height.equalTo(56) // 버튼의 높이
            make.bottom.equalTo(customAlertView.snp.bottom).inset(10)
        }

        let buttonStackView = UIStackView(arrangedSubviews: [confirmButton, deleteButton])
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .fillEqually
        buttonStackView.spacing = 20
        buttonStackView.spacing = 10

        customAlertView.addSubview(buttonStackView)
        buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(datePicker.snp.bottom).offset(13)
            make.centerX.equalTo(customAlertView.snp.centerX)
            make.width.equalTo(273) // 스택 뷰의 너비
            make.height.equalTo(40) // 스택 뷰의 높이
        }
    }

    @objc func deleteButtonTapped() {
        guard let posterName = self.posterImageName else {
            print("Poster name is not available")
            return
        }

        deleteVisitDateInFirestore(posterName: posterName) {
            self.dismissAlertViews() // 얼럿창 숨김
            self.recordButton.setImage(UIImage(named: "footprint"), for: .normal) // 아이콘을 기본 이미지로 변경
            self.fetchVisitorCountAndUpdateLabel() // 방문자 수 레이블 업데이트
        }
    }



    func deleteVisitDateInFirestore(posterName: String, completion: @escaping () -> Void) {
        guard let userID = Auth.auth().currentUser?.uid else {
            print("User ID is not available")
            return
        }

        let db = Firestore.firestore()
        let userVisitDocument = db.collection("posters").document(posterName).collection("reviews").document(userID)
        let posterDocument = db.collection("posters").document(posterName)

        db.runTransaction({ (transaction, errorPointer) -> Any? in
            let posterDocumentSnapshot: DocumentSnapshot
            do {
                try posterDocumentSnapshot = transaction.getDocument(posterDocument)
            } catch let fetchError as NSError {
                errorPointer?.pointee = fetchError
                return nil
            }

            if let visitorCount = posterDocumentSnapshot.data()?["visits"] as? Int, visitorCount > 0 {
                let newVisitorCount = visitorCount - 1
                transaction.updateData(["visits": newVisitorCount], forDocument: posterDocument)
            }

            transaction.updateData(["유저_다녀옴_날짜": FieldValue.delete(), "visited": false], forDocument: userVisitDocument)

            return nil
        }) { (object, error) in
            if let error = error {
                print("트랜잭션 실패: \(error)")
            } else {
                print("트랜잭션이 성공적으로 완료됨")
                self.recordButton.setImage(UIImage(named: "footprint 1"), for: .normal)

                completion()
                self.fetchVisitorCountAndUpdateLabel() // 방문자 수 레이블을 업데이트합니다.
            }
        }
    }





    func createDeepLink() -> String {
        // 여기서는 'backgroundImage'를 페이지 식별자로 사용하고 'posterImageName'을 쿼리 매개변수로 추가합니다.
        let deepLinkURL = "Dots://backgroundImage?poster=\(posterImageName ?? "")"
        return deepLinkURL
    }




    private func setupBackgroundImage(with imageName: String) {
        let storageRef = Storage.storage().reference(withPath: "images/\(imageName).png")
        storageRef.downloadURL { [weak self] (url, error) in
            if let error = error {
                print("Error getting download URL: \(error)")
            } else if let url = url {
                // 이미지를 SDWebImage를 사용하여 다운로드 및 캐시합니다.
                DispatchQueue.main.async {
                    self?.backgroundImageView.sd_setImage(with: url, completed: { (image, error, cacheType, url) in
                        if let error = error {
                            print("Error downloading image: \(error)")
                        } else {
                            switch cacheType {
                            case .none:
                                print("Image was downloaded and cached: \(url?.absoluteString ?? "Unknown URL")")
                            default:
                                print("Image was retrieved from cache")
                            }
                        }
                    })
                }
            }
        }
    }





    private func setupBackButton() {

        view.addSubview(createCustomBackButton)
        view.addSubview(createCustomHeadsetIcon)

        view.addSubview(heartIcon)
        view.addSubview(recordButton)
        view.addSubview(mapPageButton)
        view.addSubview(modalLoadButton)


        createCustomBackButton.snp.makeConstraints { make in // SnapKit을 사용하여 제약 조건 설정
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10) // 상단 safe area로부터 10포인트 아래에 위치
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16) // leading edge로부터 10포인트 떨어진 곳에 위치
            make.width.height.equalTo(40) // 너비와 높이는 40포인트로 설정
        }



        createCustomHeadsetIcon.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.trailing.equalTo(view.snp.trailing).offset(-16)
            make.width.height.equalTo(40)
        }

        recordButton.snp.makeConstraints{ make in
            make.bottom.equalTo(heartIcon.snp.top).inset(-10)
            make.trailing.equalTo(view.snp.trailing).inset(16)
            make.width.height.equalTo(40)
        }

        heartIcon.snp.makeConstraints{ make in
            make.bottom.equalTo(mapPageButton.snp.top).inset(-10)
            make.trailing.equalTo(view.snp.trailing).inset(16)
            make.width.height.equalTo(40)
        }

        mapPageButton.snp.makeConstraints{ make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(73)
            make.trailing.equalTo(view.snp.trailing).inset(16)
            make.width.height.equalTo(40)
        }

        modalLoadButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(26)
            make.leading.trailing.equalToSuperview().inset(150)
        }
    }



    @objc func heartIconTapped() {
        guard let posterName = self.posterImageName, let userID = Auth.auth().currentUser?.uid else {
            print("Poster name or user ID is not available")
            return
        }

        let db = Firestore.firestore()
        let posterDocument = db.collection("posters").document(posterName)

        db.runTransaction({ (transaction, errorPointer) -> Any? in
            let posterSnapshot: DocumentSnapshot

            do {
                // posters 컬렉션에서 포스터 문서를 가져오려고 시도합니다.
                try posterSnapshot = transaction.getDocument(posterDocument)
            } catch let fetchError as NSError {
                errorPointer?.pointee = fetchError
                return nil
            }

            var newLikes = (posterSnapshot.data()?["likes"] as? Int ?? 0)
            var userLikes = (posterSnapshot.data()?["userLikes"] as? [String: Bool] ?? [:])

            // 좋아요 상태를 변경합니다.
            if let liked = userLikes[userID] {
                newLikes += liked ? -1 : 1
                userLikes[userID] = !liked
            } else {
                newLikes += 1
                userLikes[userID] = true
            }

            // 포스터 문서가 존재하면 업데이트하고, 존재하지 않으면 새로 생성합니다.
            if posterSnapshot.exists {
                transaction.updateData(["likes": newLikes, "userLikes": userLikes], forDocument: posterDocument)
            } else {
                transaction.setData(["likes": newLikes, "userLikes": userLikes], forDocument: posterDocument)
            }

            return nil
        }) { [weak self] (object, error) in
            if let error = error {
                print("Transaction failed: \(error)")
            } else {
                print("Transaction successfully committed!")
                DispatchQueue.main.async {
                    // 좋아요 상태의 UI를 토글합니다.
                    self?.heartIcon.isSelected.toggle()
                    self?.updateHeartIconState()
                }
            }
        }
    }


    func updateHeartIconState() {
        if heartIcon.isSelected {
            // 좋아요 상태일 때
            heartIcon.setImage(UIImage(named: "Vector 2"), for: .normal)
        } else {
            // 좋아요 상태가 아닐 때
            heartIcon.setImage(UIImage(named: "라이크"), for: .normal)
        }
    }





    @objc func recordButtonTapped() {
        guard let posterName = self.posterImageName else {
            print("Poster name is not available")
            return
        }

        checkIfVisitAlreadyRegistered(posterName: posterName) { [weak self] (alreadyRegistered, visitDate) in
            DispatchQueue.main.async {
                if alreadyRegistered {
                    // 이미 방문을 등록한 경우, 날짜 선택 뷰를 표시
                    self?.showVisitRegistrationAlert(withEditing: true, existingDate: visitDate)
                } else {
                    // 방문을 아직 등록하지 않은 경우, 날짜 선택 뷰를 표시
                    self?.showVisitRegistrationAlert(withEditing: false, existingDate: nil)
                }
            }
        }
    }






    @objc func presentAudioGuideViewController() {
        // 현재 모달을 닫고, 완료 콜백에서 AudioGuideViewController를 푸시합니다.
        self.dismiss(animated: true) {
            if let navigationController = self.navigationController {
                let audioGuideViewController = AudioGuideViewController()
                audioGuideViewController.hidesBottomBarWhenPushed = true // 탭 바 숨기기

                navigationController.pushViewController(audioGuideViewController, animated: true)
            }
        }
    }



    private func presentModalViewController() {
        let detailViewController = DetailViewController()
        detailViewController.posterImageName = self.posterImageName // 포스터 이름 설정
    }



}



class ReviewTableViewCell: UITableViewCell {

    // UI 컴포넌트 선언
    private lazy var nickNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-Bold", size: 14)
        label.textColor = .white
        return label
    }()

    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-Regular", size: 14)
        label.textColor = UIColor(red: 0.497, green: 0.497, blue: 0.497, alpha: 1)
        label.numberOfLines = 3 // 멀티라인을 허용합니다.
        return label
    }()

    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-Regular", size: 12)
        label.textColor = .white
        return label
    }()

    private let container = UIView()

    private lazy var newTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-Regular", size: 18)
        label.textColor = UIColor(red: 0.875, green: 0.871, blue: 0.886, alpha: 1)
        return label
    }()

    private lazy var extraImageView1: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var extraImageView2: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var likeCount: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-Regular", size: 12)
        label.textColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
        return label
    }()

    private lazy var viewCount: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-Regular", size: 12)
        label.textColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
        return label
    }()



    // 초기화 메서드
    // 초기화 메서드
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        // 컨테이너 뷰 설정
        container.backgroundColor = UIColor(red: 0.169, green: 0.169, blue: 0.169, alpha: 1)
        container.layer.cornerRadius = 10
        container.clipsToBounds = true

        contentView.backgroundColor = .black
        selectionStyle = .none

        // 컨테이너 뷰를 contentView에 추가합니다.
        contentView.addSubview(container)

        // 모든 서브뷰를 컨테이너 뷰에 추가합니다.
        container.addSubview(nickNameLabel)
        container.addSubview(contentLabel)
        container.addSubview(profileImageView)
        container.addSubview(timeLabel)
        // 컨테이너 뷰에 새로운 서브뷰를 추가합니다.
        container.addSubview(newTitleLabel)
        // 컨테이너 뷰에 새로운 서브뷰들을 추가합니다.
        container.addSubview(extraImageView1)
        container.addSubview(extraImageView2)
        // 새로운 서브뷰들을 컨테이너 뷰에 추가합니다.
        container.addSubview(likeCount)
        container.addSubview(viewCount)

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
        nickNameLabel.snp.makeConstraints { make in
            //            make.top.equalToSuperview().offset(15) // 상단 여백 설정
            make.centerY.equalTo(profileImageView)
            make.left.equalTo(profileImageView.snp.right).offset(10)
        }

        // 내용 레이블의 레이아웃 설정
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(newTitleLabel.snp.bottom).offset(10) // 제목 레이블 아래 간격을 둡니다.
            make.left.right.equalToSuperview().inset(10)

        }

        // 프로필 이미지 뷰의 레이아웃 설정
        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10) // 좌측 여백 설정
            make.width.height.equalTo(30) // 이미지 크기를 30x30으로 설정
        }

        // 닉네임 레이블의 레이아웃 설정
        timeLabel.snp.makeConstraints { make in
            make.left.equalTo(nickNameLabel.snp.right).offset(10) // 프로필 이미지 오른쪽에 위치
            make.centerY.equalTo(nickNameLabel.snp.centerY) // 프로필 이미지와 중앙 정렬
        }

        // 새로운 제목 레이블 레이아웃 설정
        newTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(10)
        }

        // 첫 번째 이미지 뷰 레이아웃 설정
        extraImageView1.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(10)
            make.width.equalTo(15.82)
            make.height.equalTo(14) // 원하는 크기로 조정
            make.bottom.lessThanOrEqualToSuperview().offset(-10) // 셀 하단 여백 설정 // 유동적으로 늘어나야 할 때 사용 하는 메서드.

        }

        // 두 번째 이미지 뷰 레이아웃 설정
        extraImageView2.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(14)
            make.left.equalTo(likeCount.snp.right).offset(10)
            make.width.height.equalTo(17) // 원하는 크기로 조정
        }

        // label123 레이아웃 설정
        likeCount.snp.makeConstraints { make in
            make.centerY.equalTo(extraImageView1.snp.centerY)
            make.left.equalTo(extraImageView1.snp.right).offset(4)
        }

        // label456 레이아웃 설정
        viewCount.snp.makeConstraints { make in
            make.centerY.equalTo(extraImageView2.snp.centerY)
            make.left.equalTo(extraImageView2.snp.right).offset(4)
        }
    }

    // 셀에 리뷰 정보를 설정하는 메서드
    // 셀에 리뷰 정보를 설정하는 메서드
    func setReview(nikeName: String, content: String, profileImageUrl: String, nickname: String, newTitle: String, extraImageView1: UIImage?, extraImageView2: UIImage?, text123: String, text456: String) {
        nickNameLabel.text = nikeName
        contentLabel.text = content
        timeLabel.text = nickname
        newTitleLabel.text = newTitle
        self.extraImageView1.image = extraImageView1
        self.extraImageView2.image = extraImageView2
        likeCount.text = text123
        viewCount.text = text456

        // 프로필 이미지 URL을 사용하여 이미지 다운로드
        if let url = URL(string: profileImageUrl) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.profileImageView.image = image
                    }
                }
            }.resume()
        }
    }


}


import UIKit
import MapKit
import FirebaseFirestore


class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    var mapView: MKMapView!
    let database = Firestore.firestore()
    var imageName: String? // 이미지 이름을 저장할 프로퍼티

    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "loginBack"), for: .normal) // 버튼의 기본 상태 이미지를 설정합니다.
        button.backgroundColor = .white
        button.layer.cornerRadius = 20

        button.layer.shadowOpacity = 0.9
        button.layer.shadowRadius = 2
        button.layer.shadowOffset = CGSize(width: 1, height: 1)
        button.layer.shadowColor = UIColor.black.cgColor


        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside) // 버튼 액션 추가
        return button
    }()

    lazy var floatingButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 23 // 모서리 둥글게 설정
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 2
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowColor = UIColor.black.cgColor

        button.setImage(UIImage(named: "🦆 icon _add pin alt_"), for: .normal) // 길찾기 이미지
        button.setTitle("길찾기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -13, bottom: 0, right: 0) // 이미지와 텍스트 간격 조정
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(floatingButtonTapped), for: .touchUpInside) // 액션 추가

        return button
    }()

    var locationData: CLLocationCoordinate2D? // 위치 데이터를 저장할 프로퍼티 추가
    var locationManager: CLLocationManager!

    var museumName: String? // 미술관 이름을 저장할 프로퍼티 추가

    private lazy var mapAlertView: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor(red: 0.153, green: 0.157, blue: 0.165, alpha: 1)
            view.layer.cornerRadius = 20
            view.isHidden = true // 처음에는 숨겨둡니다.
            return view
        }()

    private lazy var blurEffectView: UIVisualEffectView = {
          let blurEffect = UIBlurEffect(style: .dark)
          let view = UIVisualEffectView(effect: blurEffect)
          view.frame = self.view.bounds
          view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
          view.isHidden = true // 처음에는 숨겨둡니다.
          return view
      }()

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 탭바를 숨깁니다.
        tabBarController?.tabBar.isHidden = true
        navigationController?.setNavigationBarHidden(true, animated: animated)


    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 다른 화면으로 이동하기 전에 탭바를 다시 표시합니다.
        tabBarController?.tabBar.isHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMapView()
        fetchLocationData()
        print(imageName)
        view.addSubview(backButton)

        backButton.snp.makeConstraints { make in // SnapKit을 사용하여 제약 조건 설정
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10) // 상단 safe area로부터 10포인트 아래에 위치
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16) // leading edge로부터 10포인트 떨어진 곳에 위치
            make.width.height.equalTo(40) // 너비와 높이는 40포인트로 설정
        }


        // 먼저 blurEffectView를 추가합니다.
        view.addSubview(blurEffectView)
        blurEffectView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        // blurEffectView가 추가된 후에 tapGesture를 추가합니다.
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissMapAlertView))
        blurEffectView.addGestureRecognizer(tapGesture)
        blurEffectView.isUserInteractionEnabled = true

        view.addSubview(floatingButton)
        setupFloatingButtonConstraints()

        // 이제 mapAlertView를 추가합니다.
        view.addSubview(mapAlertView)
        setupMapAlertViewConstraints()

        configureLocationManager()
    }

    private func setupFloatingButtonConstraints() {
        floatingButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(106)
            make.height.equalTo(46)
        }
    }

    private func setupMapAlertViewConstraints() {
        mapAlertView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(320)
            make.height.equalTo(180)
        }
        // 여기에 mapAlertView 내부에 들어갈 컴포넌트들을 추가하고 제약 조건을 설정합니다.
    }


    @objc func modalLoadButtonTapped() {
           blurEffectView.isHidden = false
           mapAlertView.isHidden = false
       }

    @objc func dismissMapAlertView() {
        // 얼럿 창을 닫고, 길찾기 버튼을 다시 표시합니다.
        mapAlertView.isHidden = true
        blurEffectView.isHidden = true
        floatingButton.isHidden = false  // 길찾기 버튼 다시 표시
    }


    private func setupMapAlertView() {
        // "길찾기" 레이블 설정
        let guideLabel = UILabel()
        guideLabel.text = "길찾기"
        guideLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        guideLabel.textColor = .white

        // 네이버 지도 버튼 및 레이블 설정
        let naverButton = UIButton()
        naverButton.setImage(UIImage(named: "image 72"), for: .normal)
        let naverLabel = UILabel()
        naverLabel.text = "네이버 지도"
        naverLabel.font = UIFont(name: "Pretendard-Regular", size: 14)
        naverLabel.textColor = .white
        naverLabel.textAlignment = .center
        // 네이버 지도 버튼에 액션 추가
           naverButton.addTarget(self, action: #selector(naverMapMove), for: .touchUpInside)


        // 카카오맵 버튼 및 레이블 설정
        let kakaoButton = UIButton()
        kakaoButton.setImage(UIImage(named: "image 73"), for: .normal)
        let kakaoLabel = UILabel()
        kakaoLabel.text = "카카오맵"
        kakaoLabel.font = UIFont(name: "Pretendard-Regular", size: 14)
        kakaoLabel.textColor = .white
        kakaoLabel.textAlignment = .center
        // 카카오맵 버튼에 액션 추가
            kakaoButton.addTarget(self, action: #selector(openKakaoMap), for: .touchUpInside)

        // 네이버 스택 뷰 설정
        let naverStackView = UIStackView(arrangedSubviews: [naverButton, naverLabel])
        naverStackView.axis = .vertical
        naverStackView.spacing = 10
        naverStackView.alignment = .center

        // 카카오 스택 뷰 설정
        let kakaoStackView = UIStackView(arrangedSubviews: [kakaoButton, kakaoLabel])
        kakaoStackView.axis = .vertical
        kakaoStackView.spacing = 10
        kakaoStackView.alignment = .center

        // 메인 스택 뷰 설정
        let mainStackView = UIStackView(arrangedSubviews: [naverStackView, kakaoStackView])
        mainStackView.axis = .horizontal
        mainStackView.spacing = 10
        mainStackView.distribution = .fillEqually

        mapAlertView.addSubview(guideLabel)
        mapAlertView.addSubview(mainStackView)

        guideLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().inset(20)
        }

        mainStackView.snp.makeConstraints { make in
            make.top.equalTo(guideLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
        }
    }



    func configureLocationManager() {
         locationManager = CLLocationManager()
         locationManager.delegate = self
         locationManager.desiredAccuracy = kCLLocationAccuracyBest
         locationManager.requestWhenInUseAuthorization()
         locationManager.startUpdatingLocation()
     }

     // CLLocationManagerDelegate 메서드
     func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
         if let location = locations.first {
             // 현재 위치 처리
             print("Current location: \(location.coordinate)")
         }
     }

     func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
         print("Failed to find user's location: \(error.localizedDescription)")
     }

    @objc func backButtonTapped() {
        // 여기에 뒤로 가기 버튼을 눌렀을 때의 동작을 구현하세요.
        navigationController?.popViewController(animated: true) // 네비게이션 컨트롤러를 사용하는 경우
        self.dismiss(animated: true, completion: nil)

    }




    @objc func floatingButtonTapped() {
        // 길찾기 버튼을 누르면 얼럿 창을 표시하고, 길찾기 버튼을 숨깁니다.
        blurEffectView.isHidden = false
        mapAlertView.isHidden = false
        floatingButton.isHidden = true  // 길찾기 버튼 숨기기

        // 얼럿 창에 추가될 내용 구성 및 설정
        setupMapAlertView()
    }

    @objc func naverMapMove() {
        guard let museumName = self.museumName else {
            print("미술관 이름이 설정되지 않았습니다.")
            return
        }

        let appname = Bundle.main.bundleIdentifier ?? "yourAppName"
        let naverMapURLString = "nmap://search?query=\(museumName)&appname=\(appname)"
        guard let encodedURLString = naverMapURLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: encodedURLString) else {
            print("유효하지 않은 URL입니다.")
            return
        }

        // 네이버 지도 앱 열기 또는 앱 스토어로 이동
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            let appStoreURL = URL(string: "http://itunes.apple.com/app/id311867728?mt=8")!
            UIApplication.shared.open(appStoreURL)
        }

    }

    @objc func openKakaoMap() {
        guard let museumName = self.museumName else {
            print("미술관 이름이 설정되지 않았습니다.")
            return
        }

        let kakaoMapURLString = "kakaomap://search?q=\(museumName)"
        guard let encodedURLString = kakaoMapURLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: encodedURLString) else {
            print("유효하지 않은 URL입니다.")
            return
        }

        // 카카오맵 앱 열기 또는 앱 스토어로 이동
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            let appStoreURL = URL(string: "https://apps.apple.com/app/id304608425")!
            UIApplication.shared.open(appStoreURL)
        }
    }



    private func setupMapView() {


        mapView = MKMapView(frame: self.view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView = MKMapView(frame: self.view.bounds)
        mapView.delegate = self // MapView의 델리게이트를 설정합니다.
        // 여기에 추가적인 지도 설정을 할 수 있습니다. 예를 들어, 사용자의 현재 위치를 표시하거나 특정 위치로 지도 중심을 이동시킬 수 있습니다.
        mapView.overrideUserInterfaceStyle = .dark

        self.view.addSubview(mapView)
    }

    private func fetchLocationData() {
           guard let imageName = self.imageName else {
               print("이미지 이름이 설정되지 않았습니다.")
               return
           }

           let docRef = database.collection("전시_상세").document(imageName)
           docRef.getDocument { (document, error) in
               if let document = document, document.exists {
                   let geoPoint = document.get("전시_좌표") as? GeoPoint
                   self.museumName = document.get("미술관_이름") as? String ?? "미술관 이름 없음"

                   if let geoPoint = geoPoint {
                       let location = CLLocationCoordinate2D(latitude: geoPoint.latitude, longitude: geoPoint.longitude)
                       self.locationData = location // 위치 데이터 저장
                       self.centerMapOnLocation(location: location, museumName: self.museumName!)
                   } else {
                       print("장소_좌표 필드가 없습니다.")
                   }
               } else {
                   print("문서를 찾을 수 없거나 오류가 발생했습니다: \(error?.localizedDescription ?? "Unknown error")")
               }
           }
       }

    // 지도에 핀을 추가하는 메서드
    private func addPinAtLocation(location: CLLocationCoordinate2D, museumName: String) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = museumName // "미술관_이름"을 타이틀로 설정
        mapView.addAnnotation(annotation)
    }
    // MKMapViewDelegate 메서드
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "MyPin"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            annotationView?.image = UIImage(named: "place 2")
//            annotationView?.backgroundColor = .gray

            let label = UILabel()
            label.text = annotation.title ?? "미술관 이름 없음"
            label.textColor = .white // 글자색을 하얀색으로 설정
            label.font = UIFont(name: "Pretendard-Medium", size: 20)
//            label.backgroundColor = .gray
            label.textAlignment = .center
            label.sizeToFit()

            // 레이블의 위치를 이미지의 아래 중앙에 맞춥니다.
            let imageWidth = annotationView?.image?.size.width ?? 0 // 이미지 너비
            let imageHeight = annotationView?.image?.size.height ?? 0 // 이미지 높이

            let labelX = (imageWidth - label.frame.width) / 2 // 중앙 정렬을 위한 X좌표 계산
            let labelY = imageHeight // 이미지 아래에 위치하도록 Y좌표 설정

            label.frame = CGRect(x: labelX, y: labelY, width: label.frame.width, height: label.frame.height)

            annotationView?.addSubview(label)
        } else {
            annotationView?.annotation = annotation
        }

        return annotationView
    }



    private func centerMapOnLocation(location: CLLocationCoordinate2D, museumName: String) {
        let regionRadius: CLLocationDistance = 200
        let coordinateRegion = MKCoordinateRegion(center: location,
                                                  latitudinalMeters: regionRadius,
                                                  longitudinalMeters: regionRadius)
        addPinAtLocation(location: location, museumName: museumName)

        mapView.setRegion(coordinateRegion, animated: true)
    }

}
