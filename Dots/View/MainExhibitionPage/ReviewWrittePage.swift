//
//  ReviewWrittePage.swift
//  Dots
//
//  Created by cheshire on 11/13/23.
// 최신화 커밋 푸쉬 2023년 11월 13일 월 오후 11:23

import Foundation
import UIKit
import PhotosUI // iOS 14 이상의 사진 라이브러리를 사용하기 위해 필요합니다.
import SnapKit
import Firebase
import FirebaseStorage
import Toast_Swift

protocol ReviewWritePageDelegate: AnyObject {
    func didSubmitReview()
}


class ReviewWritePage: UIViewController, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate,  UICollectionViewDelegate, UICollectionViewDataSource {

    // 텍스트 필드 속성 정의
    let titleTextField = UITextField()
    let contentTextView = UITextView()
    let separatorView = UIView() // 선을 위한 뷰

    // 선택된 이미지를 저장할 배열
    var selectedImages = [UIImage]()

    // UICollectionView 속성 정의
    var collectionView: UICollectionView!

    // 컬렉션 뷰 높이 제약 조건을 위한 변수 선언
    var collectionViewHeightConstraint: Constraint?

    var posterName: String?

    var reviewTitle: String?

    weak var delegate: ReviewWritePageDelegate?

    var contentTextViewBottomConstraint: Constraint?




    override func viewDidLoad() {
        super.viewDidLoad()



        titleTextField.becomeFirstResponder()
        // 텍스트 필드 커서 색상 설정
            titleTextField.tintColor = UIColor(red: 0.882, green: 1, blue: 0, alpha: 1)
            // 텍스트 뷰 커서 색상 설정
            contentTextView.tintColor = UIColor(red: 0.882, green: 1, blue: 0, alpha: 1)

        // posterName 값 확인
        if let posterName = posterName {
            print("Poster name: \(posterName)")
        } else {
            print("Poster name not provided")
        }




        self.view.backgroundColor = .black

        // 타이틀 설정
        self.title = "리암 길릭 : Alterants"

        // Custom Title View 생성 및 설정
        let exhibitionTitleLabel = UILabel()
        exhibitionTitleLabel.numberOfLines = 0 // 여러 줄 표시 허용
        exhibitionTitleLabel.text = reviewTitle ?? "기본 타이틀" // 여기에 여러 줄 텍스트 설정
        exhibitionTitleLabel.textAlignment = .center
        exhibitionTitleLabel.textColor = .white
        exhibitionTitleLabel.font = UIFont(name: "Pretendard-Regular", size: 14)
        exhibitionTitleLabel.lineBreakMode = .byWordWrapping

        // Navigation Item에 Title View 설정
        self.navigationItem.titleView = exhibitionTitleLabel

        // Title View의 제약 조건 설정 (필요한 경우)
        exhibitionTitleLabel.snp.makeConstraints { make in
            make.width.lessThanOrEqualTo(self.view.frame.width - 40) // 적절한 너비 제한 설정
        }

        // 타이틀 설정
        if let reviewTitle = reviewTitle {
            self.title = reviewTitle // 여기에서 reviewTitle을 self.title에 바인딩합니다.
        } else {
            self.title = "기본 타이틀" // reviewTitle이 nil일 경우의 기본 값
        }

        // 취소 버튼 설정
        let cancelButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancelButtonTapped))
        cancelButton.tintColor = .white
        self.navigationItem.leftBarButtonItem = cancelButton

        // 등록 버튼 설정
        let registerButton = UIBarButtonItem(title: "등록", style: .done, target: self, action: #selector(registerButtonTapped))
        registerButton.tintColor = UIColor(red: 0.882, green: 1, blue: 0, alpha: 1)
        self.navigationItem.rightBarButtonItem = registerButton

        // Navigation Bar 배경색과 타이틀 색상 설정
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .black // 배경색 설정
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white] // 타이틀 색상 설정
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white] // 큰 타이틀 색상 설정

        // 현재 Navigation Bar에 appearance 적용
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance // 작은 사이즈에도 적용 (예: 스크롤 시)
        navigationController?.navigationBar.scrollEdgeAppearance = appearance // 큰 타이틀에도 적용

        // 레거시 Navigation Bar 스타일링에 대한 처리
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = .white

        // 텍스트 필드 설정
        setupTextField(titleTextField, placeholder: "제목", fontSize: 18)
        setupTextView(contentTextView, text: "자유롭게 후기를 작성해주세요.", fontSize: 16)
        contentTextView.delegate = self // UITextViewDelegate 지정


        // 레이아웃 설정
        setupLayout()

        configureInputAccessoryView()

        setupCollectionView()
        updateCollectionViewLayout()
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "ImageCollectionViewCell")

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)


        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

        // contentTextView 레이아웃 설정
        contentTextView.snp.makeConstraints { make in
            make.top.equalTo(separatorView.snp.bottom).offset(10)
            make.left.right.equalTo(view).inset(10)
            self.contentTextViewBottomConstraint = make.bottom.equalTo(view.safeAreaLayoutGuide).constraint
        }

        // 장기간 눌러서 드래그 앤 드롭을 활성화
           let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture(_:)))
           collectionView.addGestureRecognizer(longPressGesture)
    }

    @objc func handleLongPressGesture(_ gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .began:
            guard let targetIndexPath = collectionView.indexPathForItem(at: gesture.location(in: collectionView)) else { return }
            collectionView.beginInteractiveMovementForItem(at: targetIndexPath)
        case .changed:
            collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
        case .ended:
            collectionView.endInteractiveMovement()
        default:
            collectionView.cancelInteractiveMovement()
        }
    }

    // 이미지 순서 변경 처리
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedImage = selectedImages.remove(at: sourceIndexPath.item)
        selectedImages.insert(movedImage, at: destinationIndexPath.item)
        collectionView.reloadData()

        // 순서 변경 로그 출력
        print("이미지 이동됨: \(sourceIndexPath.item) 에서 \(destinationIndexPath.item) 으로")
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height

            contentTextViewBottomConstraint?.update(inset: keyboardHeight)
            view.layoutIfNeeded()
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        contentTextViewBottomConstraint?.update(inset: 0)
        view.layoutIfNeeded()
    }




    func setupCollectionView() {
        // 레이아웃 설정
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 100)

        // 컬렉션 뷰 초기화 및 설정
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.backgroundColor = .black

        // 컬렉션 뷰를 뷰의 서브뷰로 추가합니다.
        view.addSubview(collectionView)

        // 컬렉션 뷰 오토레이아웃 설정 (스냅킷 사용)
        collectionView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.left.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-10)
            make.height.equalTo(100) // 여기서는 높이를 100으로 설정했습니다.
            self.collectionViewHeightConstraint = make.height.equalTo(0).constraint // 초기 높이를 0으로 설정

        }
    }

    func updateCollectionViewLayout() {
        // selectedImages 배열의 내용에 따라 컬렉션 뷰의 높이를 업데이트합니다.
        let shouldShowCollectionView = !selectedImages.isEmpty
        collectionViewHeightConstraint?.update(offset: shouldShowCollectionView ? 100 : 0)
        collectionView.isHidden = !shouldShowCollectionView

        if shouldShowCollectionView {
            // 이미지가 있을 경우 컬렉션 뷰 아래로 제목 텍스트 필드의 위치를 조정합니다.
            titleTextField.snp.remakeConstraints { make in
                make.top.equalTo(collectionView.snp.bottom).offset(20)
                make.left.right.equalTo(view).inset(15)
                make.height.equalTo(40)
            }
        } else {
            // 이미지가 없을 경우 제목 텍스트 필드의 위치를 원래대로 복원합니다.
            titleTextField.snp.remakeConstraints { make in
                make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
                make.left.right.equalTo(view).inset(15)
                make.height.equalTo(40)
            }
        }

        // 애니메이션과 함께 레이아웃 변경을 적용합니다.
        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
        }
    }




    // 컬렉션 뷰 데이터 소스 메서드
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedImages.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as? ImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.imageView.image = selectedImages[indexPath.row]
        cell.deleteButton.tag = indexPath.row // 태그를 사용하여 어떤 셀의 'x' 버튼이 탭되었는지 식별합니다.
        cell.deleteButton.addTarget(self, action: #selector(deleteImage(_:)), for: .touchUpInside)
        return cell
    }

    @objc func deleteImage(_ sender: UIButton) {
        let index = sender.tag
        guard index < selectedImages.count else {
            return
        }

        // 배열에서 먼저 삭제
        selectedImages.remove(at: index)

        // 콜렉션 뷰의 데이터 소스를 업데이트하는 대신, 즉시 레이아웃을 갱신합니다.
        collectionView.performBatchUpdates({
            // 컬렉션 뷰에서 해당 인덱스의 셀을 삭제합니다.
            self.collectionView.deleteItems(at: [IndexPath(item: index, section: 0)])
        }, completion: { finished in
            // 삭제가 끝난 후, 남아있는 셀의 인덱스가 바뀌었을 수 있으므로, 태그를 재할당합니다.
            if finished {
                for case let cell as ImageCollectionViewCell in self.collectionView.visibleCells {
                    if let indexPath = self.collectionView.indexPath(for: cell) {
                        cell.deleteButton.tag = indexPath.row
                    }
                }
                // 레이아웃을 업데이트합니다.
                self.updateCollectionViewLayout()
            }
        })
    }








    func configureInputAccessoryView() {
        let accessoryView = UIView(frame: .zero)
        accessoryView.backgroundColor = .black
        accessoryView.autoresizingMask = .flexibleHeight


        // 상단 라인 뷰 설정
        let topLineView = UIView()
        topLineView.backgroundColor = UIColor(red: 0.158, green: 0.158, blue: 0.158, alpha: 1)

        accessoryView.addSubview(topLineView) // accessoryView에 라인 뷰 추가

        topLineView.snp.makeConstraints { make in
            make.top.equalTo(accessoryView.snp.top)
            make.left.equalTo(accessoryView.snp.left)
            make.right.equalTo(accessoryView.snp.right)
            make.height.equalTo(1) // 라인 뷰 높이
        }

        // 첫 번째 버튼 설정
        let button1 = UIButton(type: .custom)
        button1.setImage(UIImage(named: "Union 3"), for: .normal) // 버튼 이미지 설정
        button1.imageView?.contentMode = .scaleAspectFit // 이미지 콘텐츠 모드 설정
        button1.addTarget(self, action: #selector(button1Action), for: .touchUpInside) // 버튼 액션 추가

        // 두 번째 버튼 설정
        let button2 = UIButton(type: .custom)
        button2.setImage(UIImage(named: "Group 131"), for: .normal) // 버튼 이미지 설정
        button2.imageView?.contentMode = .scaleAspectFit // 이미지 콘텐츠 모드 설정
        button2.addTarget(self, action: #selector(button2Action), for: .touchUpInside) // 버튼 액션 추가

        // 버튼들을 Accessory View에 추가합니다.
        accessoryView.addSubview(button1)
        accessoryView.addSubview(button2)

        // 첫 번째 버튼의 레이아웃 제약 조건 설정
        button1.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(44)
            make.width.equalTo(button1.snp.height).multipliedBy(0.6) // 버튼 너비는 높이의 0.6배
        }

        // 두 번째 버튼의 레이아웃 제약 조건 설정
        button2.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(button1.snp.right).offset(20)
            make.height.equalTo(44)
            make.width.equalTo(button2.snp.height).multipliedBy(0.5) // 버튼 너비는 높이의 0.5배
        }

        // Accessory View의 높이 설정
        let accessoryHeight: CGFloat = 44
        accessoryView.frame.size.height = accessoryHeight

        // 텍스트 뷰에 Accessory View 할당
        contentTextView.inputAccessoryView = accessoryView
        contentTextView.reloadInputViews() // 액세서리 뷰 변경 적용
    }

    @objc func button1Action() {
        // 첫 번째 버튼 액션
        print("Button 1 Tapped")
        presentCamera()

    }

    func presentCamera() {
        // 카메라 사용 가능 여부 확인
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            print("Camera is not available on this device.")
            return
        }

        // 카메라 접근 권한 상태 확인 (iOS 14 이상을 위한 코드, 더 낮은 버전은 다른 방식으로 처리해야 할 수 있습니다.)
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized: // 이미 권한이 있을 때
            showCameraPicker()
        case .notDetermined: // 권한 요청이 아직 안 된 경우
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    DispatchQueue.main.async {
                        self.showCameraPicker()
                    }
                }
            }
        case .denied, .restricted: // 권한이 없거나 제한된 경우
            // 사용자에게 설정에서 권한을 변경하도록 안내
            break
        default: // 기타 상황
            break
        }
    }

    func showCameraPicker() {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self // UIImagePickerControllerDelegate와 UINavigationControllerDelegate 설정
        self.present(picker, animated: true)
    }

    @objc func button2Action() {
        // PHPickerViewController 설정과 표시
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 0  // 0은 제한 없음을 의미합니다.
        configuration.filter = .images  // 이미지만 선택 가능하도록 설정

        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        self.present(picker, animated: true)
    }

    func presentPhotoPicker() {
        // 사진 라이브러리 사용 가능 여부 확인
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            print("Photo library is not available on this device.")
            return
        }

        // 사진 라이브러리 접근 권한 상태 확인
        let status = PHPhotoLibrary.authorizationStatus()
        if status == .authorized || status == .limited { // 이미 접근 권한이 있거나, 제한적 접근이 허용된 경우
            showPhotoLibraryPicker()
        } else if status == .notDetermined { // 권한 요청이 아직 안 된 경우
            PHPhotoLibrary.requestAuthorization { newStatus in
                if newStatus == .authorized || newStatus == .limited {
                    DispatchQueue.main.async {
                        self.showPhotoLibraryPicker()
                    }
                }
            }
        } else { // 권한이 없거나 제한된 경우
            // 사용자에게 설정에서 권한을 변경하도록 안내
            print("Photo library access denied or restricted.")
        }
    }

    func showPhotoLibraryPicker() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self // UIImagePickerControllerDelegate와 UINavigationControllerDelegate 설정
        self.present(picker, animated: true, completion: nil)
    }

    // UIImagePickerControllerDelegate 메서드
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // 선택한 사진을 처리합니다.
        if let image = info[.originalImage] as? UIImage {
            selectedImages.append(image)
            collectionView.reloadData()
            updateCollectionViewLayout() // 컬렉션 뷰 레이아웃 업데이트
        }
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // 사용자가 취소했을 때의 처리
        picker.dismiss(animated: true, completion: nil)
    }

    // UITextViewDelegate 메서드를 사용하여 플레이스홀더 처리
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = .white
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "자유롭게 후기를 작성해주세요."
            textView.textColor = .lightGray
        }
    }

    // 텍스트 필드 설정을 위한 메서드
    func setupTextField(_ textField: UITextField, placeholder: String, fontSize: CGFloat) {
        view.addSubview(textField)
        textField.backgroundColor = .black
        textField.borderStyle = .none
        textField.textColor = .white
        textField.font = UIFont.systemFont(ofSize: fontSize)
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)]
        )
    }

    // UITextView 설정을 위한 메서드
    func setupTextView(_ textView: UITextView, text: String, fontSize: CGFloat) {
        view.addSubview(textView)
        textView.backgroundColor = .black

        textView.textColor = .lightGray // placeholder 처럼 보이게 하려면 색상을 조절하세요
        textView.font = UIFont.systemFont(ofSize: fontSize)
        textView.text = text
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 10)
    }

    @objc func cancelButtonTapped() {
        // 취소 버튼 액션 처리
        self.dismiss(animated: true, completion: nil)
    }

    @objc func registerButtonTapped() {
        guard let userId = Auth.auth().currentUser?.uid,
              let posterName = posterName, !posterName.isEmpty,
              let title = titleTextField.text, !title.isEmpty,
              let content = contentTextView.text, !content.isEmpty else {
            print("필요한 정보가 부족합니다.")
            return
        }

        print("업로드 시작: \(Date())")


        // 이미지 업로드 수행
        uploadImages(userId: userId, posterName: posterName) { [weak self] uploadedUrls in

            print("업로드 완료: \(Date())")

            let reviewData: [String: Any] = [
                "userId": userId,
                "title": title,
                "content": content,
                "createdAt": FieldValue.serverTimestamp(),
                "images": uploadedUrls
            ]

            let docRef = Firestore.firestore().collection("posters").document(posterName)
                           .collection("reviews").document(userId)

            docRef.setData(reviewData, merge: true) { error in
                if let error = error {
                    print("Error updating document: \(error)")
                } else {
                    self?.delegate?.didSubmitReview()

                    // 업로드 완료 후 토스트 메시지 표시 및 화면 닫기
                                self?.showToastAndDismiss()
                    }
                }

        }
    }


    // 토스트 메시지 표시 후 화면 닫기
    func showToastAndDismiss() {
        DispatchQueue.main.async {
            var style = ToastStyle()
            style.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
            style.messageColor = .white
            style.messageFont = UIFont(name: "Pretendard-SemiBold", size: 16) ?? .systemFont(ofSize: 16)

            self.view.makeToast("업로드가 완료되었습니다", duration: 3.0, position: .top, style: style)
            ToastManager.shared.isTapToDismissEnabled = true

            // 화면 닫기를 지연 실행
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }


    // 이미지를 업로드하고 URL 배열을 반환하는 함수
    func uploadImages(userId: String, posterName: String, completion: @escaping ([String]) -> Void) {
        var uploadedUrls = [String]()
        let uploadGroup = DispatchGroup()

        for (index, image) in selectedImages.enumerated() {
            uploadGroup.enter()
            guard let imageData = image.jpegData(compressionQuality: 0.75) else {
                uploadGroup.leave()
                continue
            }

            let imageName = "\(userId)_\(index).jpg"
            let storageRef = Storage.storage().reference().child("reviewImages/\(posterName)/\(imageName)")

            storageRef.putData(imageData, metadata: nil) { metadata, error in
                guard metadata != nil else {
                    print("Error uploading image: \(error?.localizedDescription ?? "")")
                    uploadGroup.leave()
                    return
                }

                storageRef.downloadURL { (url, error) in
                    if let downloadURL = url {
                        uploadedUrls.append(downloadURL.absoluteString)
                    }
                    uploadGroup.leave()
                }
            }
        }

        uploadGroup.notify(queue: .main) {
            completion(uploadedUrls)
        }
    }




    func addImageUrlToFirestore(userId: String, posterName: String, imageUrl: String) {
        let docRef = Firestore.firestore().collection("posters").document(posterName)
            .collection("reviews").document(userId)

        docRef.updateData([
            "images": FieldValue.arrayUnion([imageUrl])
        ]) { error in
            if let error = error {
                print("Error updating document: \(error)")
            } else {
                print("Image URL successfully added to document!")
            }
        }
    }



    // SnapKit을 사용한 레이아웃 설정 메서드
    func setupLayout() {
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
            make.left.equalTo(view).offset(15)
            make.right.equalTo(view).offset(-10)
        }

        // 선 추가
        separatorView.backgroundColor = UIColor(red: 0.158, green: 0.158, blue: 0.158, alpha: 1)
        view.addSubview(separatorView)

        separatorView.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(10) // 조정 가능한 간격
            make.left.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-10)
            make.height.equalTo(1) // 선의 높이
        }

        contentTextView.snp.makeConstraints { make in
            make.top.equalTo(separatorView.snp.bottom).offset(10) // 선 아래로부터의 간격
            make.left.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-10)
            make.height.equalTo(300) // 내용 입력 뷰의 높이
        }
    }

}

// PHPickerViewControllerDelegate 메서드
extension ReviewWritePage: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)

        selectedImages.removeAll() // 기존 이미지를 제거합니다.

        for result in results {
            result.itemProvider.loadObject(ofClass: UIImage.self) { object, error in
                if let image = object as? UIImage {
                    DispatchQueue.main.async {
                        self.selectedImages.append(image)
                        self.collectionView.reloadData()
                        self.updateCollectionViewLayout() // 레이아웃 업데이트 호출
                    }
                }
            }
        }
    }
}



class ImageCollectionViewCell: UICollectionViewCell {
    let imageView = UIImageView()
    let deleteButton = UIButton()


    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10 // 셀의 모서리를 둥글게 합니다.
        contentView.addSubview(imageView)


        deleteButton.setImage(UIImage(named: "xbutton"), for: .normal)
        contentView.addSubview(deleteButton)

        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        deleteButton.snp.makeConstraints { make in
            make.top.right.equalToSuperview().inset(8)
            make.width.height.equalTo(25)
        }
    }


}



