//
//  ReviewDetailViewController.swift
//  Dots
//
//  Created by cheshire on 11/30/23.
//
// 최신화
// 최신화

import Foundation
import UIKit
import SDWebImage
import Firebase
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage
import Lottie
import ImageSlideshow




struct ImageData {
    let url: URL
    var image: UIImage?
}


class ReviewDetailViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIGestureRecognizerDelegate {
    
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
    private var photoCollectionView: UICollectionView!
    private let contentLabel = UILabel()
    
    private let profileImageView = UIImageView()
    private let nameLabel = UILabel()
    private let timeLabel = UILabel()
    
    var posterName: String? // 추가된 프로퍼티

    
    // 새로운 컴포넌트 선언
    let additionalImageButton1 = UIButton()
    var additionalLabel1 = UILabel()
    let additionalImageView2 = UIImageView()
    let additionalLabel2 = UILabel()
    let reviewTitle = UILabel()
    
    var review: Review? // 추가된 프로퍼티
    
    var imageDatas: [ImageData] = [] // 이미지 데이터 배열
    
    var selectedImages: [UIImage] = []
    
    var imageUrls: [String] = [] // 이미지 URL 배열 추가
    
    var userReviewUUID : String?

    // 추가된 프로퍼티
    var museumName: String?
    var exhibitionTitle: String?

    let likeAnimationView = LottieAnimationView()

    var isLikedByCurrentUser: Bool = false


    private var pageControl: UIPageControl!

    var likesNum: Int? // 추가된 프로퍼티


    override func viewWillAppear(_ animated: Bool) {


    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        print("리뷰 디테일 페이지의 posterName\(self.posterName)")
        print("후기 남긴 유저의 UUID \(userReviewUUID)")
        //        loadImages() // 이미지 로드
        setupPageControl()  // 이 부분을 확인
        
        // 이미지 URL 배열을 정렬하고, 정렬된 배열로 이미지를 로드합니다.
           let sortedUrls = sortImageUrls(imageUrls)
           loadImages(from: sortedUrls)

        
        setupNavigationBackButton()
        setupNavigationTitleAndSubtitle() // 변경된 메서드 호출
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        setupScrollView()
        collectionViewSetup()
        setupSquareViewAndLabel()
        setupNavigationTitleView() // 변경된 메서드 호출
        configureNavigationBar()
        setupRightNavigationButton()
        
        updateLikesCount(likesNum) // 좋아요 수 업데이트 메소드 호출

        
        
        
        if let reviewData = review {
            // UI 컴포넌트에 데이터 바인딩
            nameLabel.text = reviewData.nickname
            timeLabel.text = convertDateToString(reviewData.createdAt)
            reviewTitle.text = reviewData.title
            contentLabel.text = reviewData.content
            // profileImageView에 이미지 로드 (예: URL에서 이미지를 로드하는 경우)
            // 리뷰에 사진이 없는 경우
            print("포스터 이름: \(self.posterName ?? "nil")")

            if reviewData.photoUrls.isEmpty {
                photoCollectionView.isHidden = true
                adjustLayoutForNoPhotos()
            }
            // URL 문자열을 사용하여 이미지 로드
            if let imageUrl = URL(string: reviewData.profileImageUrl) {
                // SDWebImage를 사용하여 프로필 이미지 로드 및 캐시
                profileImageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "defaultProfileImage")) { [weak self] (image, error, cacheType, url) in
                    DispatchQueue.main.async {
                        if let strongSelf = self {
                            if let error = error {
                                print("Error loading image: \(error)")
                            } else if let image = image {
                                print("Image loaded successfully. Image: \(image)")
                                strongSelf.profileImageView.image = image
                                strongSelf.profileImageView.backgroundColor = .clear // 이미지 확인을 위해 배경색 제거
                            } else {
                                print("Image is nil")
                            }
                        }
                    }
                }
                
                
            }
            
            
            // 사진 유무에 따라 컬렉션 뷰의 가시성 조정
            photoCollectionView.isHidden = reviewData.photoUrls.isEmpty
            if photoCollectionView.isHidden {
                adjustLayoutForNoPhotos()
            } else {
                adjustLayoutForPhotos()
            }
        }
        
        checkLikeStatusAndUpdateIcon()

        setupLikeAnimation()

        if let likes = likesNum {
            additionalLabel1.text = "\(likes)"
        }
    }

    // 좋아요 수 업데이트 메소드
      func updateLikesCount(_ count: Int?) {
          guard let count = count else { return }
          additionalLabel1.text = "\(count)"
      }


    func setupLikeAnimation() {
        // 로티 애니메이션 설정
        likeAnimationView.animation = LottieAnimation.named("Animation - 1703493835464")
        likeAnimationView.contentMode = .scaleAspectFill
        likeAnimationView.isHidden = true

        // additionalImageButton1에 로티 뷰 추가
        additionalImageButton1.addSubview(likeAnimationView)

        // 로티 뷰의 위치와 크기를 additionalImageButton1보다 크게 설정 (스냅킷 사용)
        likeAnimationView.snp.makeConstraints { make in
            make.centerX.equalTo(additionalImageButton1.snp.centerX)
            make.centerY.equalTo(additionalImageButton1.snp.centerY)
            make.width.equalTo(additionalImageButton1.snp.width).multipliedBy(3) // 버튼보다 20% 더 크게 설정
            make.height.equalTo(additionalImageButton1.snp.height).multipliedBy(3) // 버튼보다 20% 더 크게 설정
        }
    }



    func sortImageUrls(_ urls: [String]) -> [String] {
        return urls.sorted { url1, url2 in
            // 순서 번호 추출 로직
            let order1 = extractOrderFromUrl(url1)
            let order2 = extractOrderFromUrl(url2)
            return order1 < order2
        }
    }

    func extractOrderFromUrl(_ url: String) -> Int {
        // URL에서 파일 이름을 추출
        let fileName = url.components(separatedBy: "/").last ?? ""
        // 파일 이름에서 순서 번호 추출
        let numberString = fileName.components(separatedBy: "_").last?.components(separatedBy: ".").first ?? "0"
        return Int(numberString) ?? 0
    }


    private func setupRightNavigationButton() {
        let rightButtonImage = UIImage(named: "streamline_interface-edit-view-eye-eyeball-open-view 2")
        let rightButton = UIBarButtonItem(image: rightButtonImage, style: .plain, target: self, action: nil)
        
        if let currentUserID = CurrentUser.shared.uid, let reviewUserID = review?.userId {
            if currentUserID == reviewUserID {
                if #available(iOS 14, *) {
                    rightButton.menu = createOwnReviewMenu()
                    rightButton.action = nil
                } else {
                    rightButton.target = self
                    rightButton.action = #selector(showOwnReviewMenuForOlderIOS)
                }
            }else {
                
                // 다른 사용자의 후기일 경우
                if #available(iOS 14, *) {
                    rightButton.menu = createOtherUserReviewMenu()
                } else {
                    rightButton.target = self
                    rightButton.action = #selector(showOtherUserReviewMenuForOlderIOS)
                }
            }
        }
        
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    
    @objc func showMenu() {
        
    }
    @available(iOS 14, *)
    private func createOwnReviewMenu() -> UIMenu {
        // 수정 액션
        let modifyAction = UIAction(title: "수정하기", image: UIImage(systemName: "pencil")) { [weak self] action in
            self?.editReviewButtonTapped()
        }
        // 삭제 액션
        let deleteAction = UIAction(title: "삭제하기", image: UIImage(systemName: "trash")) { [weak self] action in
            self?.deleteReview()
        }

        return UIMenu(title: "", children: [modifyAction, deleteAction])
    }

    
    @available(iOS 14, *)
    private func createOtherUserReviewMenu() -> UIMenu {
        // 다른 사용자의 후기에 대한 메뉴
        let reportAction = UIAction(title: "신고하기", image: UIImage(systemName: "flag")) { action in
            // 신고 로직
        }
        return UIMenu(title: "", children: [reportAction])
    }
    
    @objc private func showOwnReviewMenuForOlderIOS() {
        // iOS 14 미만에서 현재 사용자의 후기 메뉴 표시 로직
    }
    
    @objc private func showOtherUserReviewMenuForOlderIOS() {
        // iOS 14 미만에서 다른 사용자의 후기 메뉴 표시 로직
    }
    
    private func setupPageControl() {
        pageControl = UIPageControl()
        pageControl.numberOfPages = imageDatas.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .gray
        pageControl.currentPageIndicatorTintColor = .white
        view.addSubview(pageControl)
        
        //        pageControl.snp.makeConstraints { make in
        //            make.centerX.equalTo(view)
        //            make.top.equalTo(photoCollectionView.snp.bottom).offset(10)
        //        }
    }

    // 리뷰 삭제 메서드
    func deleteReview() {
        guard let userId = Auth.auth().currentUser?.uid,
              let posterName = posterName, !posterName.isEmpty else {
            print("필요한 정보가 부족합니다.")
            return
        }

        // Firestore에서 특정 리뷰 데이터만 삭제
        let reviewRef = Firestore.firestore().collection("posters").document(posterName)
            .collection("reviews").document(userId)

        let fieldsToDelete: [String: Any] = [
            "title": FieldValue.delete(),
            "content": FieldValue.delete(),
            "createdAt": FieldValue.delete(),
            "images": FieldValue.delete()
        ]

        reviewRef.updateData(fieldsToDelete) { [weak self] error in
            if let error = error {
                print("Error removing review fields: \(error)")
            } else {
                print("Review fields successfully removed")
                self?.deleteImagesFromStorage(userId: userId, posterName: posterName) // 이미지 삭제 메서드 호출
            }
        }
    }


    // Firebase Storage에서 이미지 삭제 메서드
    func deleteImagesFromStorage(userId: String, posterName: String) {
        let storage = Storage.storage()

        for (index, _) in selectedImages.enumerated() {
            let imageName = "\(userId)_\(index).jpg"
            let storageRef = Storage.storage().reference().child("reviewImages/\(posterName)/\(imageName)")

            storageRef.delete { error in
                if let error = error {
                    print("Error deleting image: \(error)")
                } else {
                    print("Image successfully deleted")
                }
            }
        }
        // 리뷰 삭제 후 UI 업데이트 또는 이전 화면으로 돌아가기
        updateUIAfterDeletion()
    }

    // 삭제 후 UI 업데이트 메서드
    func updateUIAfterDeletion() {
        // 모달 뷰 컨트롤러를 닫고 이전 화면으로 돌아가는 로직
        self.dismiss(animated: true, completion: nil)
    }




    // 이미지 로드 함수
    func loadImages(from urls: [String]) {
        let sortedUrls = sortImageUrls(imageUrls)

        imageDatas.removeAll() // 기존 이미지 데이터 초기화
        let group = DispatchGroup() // URL 별로 이미지 로드 작업을 그룹화하기 위한 DispatchGroup 생성

        for urlString in sortedUrls {
            guard let url = URL(string: urlString) else { continue }
            group.enter() // 작업 시작을 DispatchGroup에 알림

            // SDWebImage를 사용하여 이미지를 다운로드 및 캐시
            SDWebImageManager.shared.loadImage(with: url, options: [], progress: nil) { (image, data, error, cacheType, finished, imageURL) in
                if finished, let image = image {
                    DispatchQueue.main.async {
                        self.imageDatas.append(ImageData(url: url, image: image)) // 순서대로 이미지 데이터 추가
                    }
                }
                group.leave() // 작업 완료를 DispatchGroup에 알림
            }
        }

        group.notify(queue: .main) {
            self.photoCollectionView.reloadData() // 모든 이미지 로드 작업 완료 후 컬렉션 뷰 갱신
            self.pageControl.numberOfPages = self.imageDatas.count // 페이지 컨트롤 업데이트
        }
    }

    
    
    private func adjustLayoutForPhotos() {
        
        
        
        
        
        profileImageView.snp.remakeConstraints { make in
            make.top.equalTo(photoCollectionView.snp.bottom).offset(20)
            make.leading.equalTo(view.snp.leading).offset(20)
            make.width.height.equalTo(32) // 동그란 이미지 크기
        }
        
        // 기타 레이아웃 업데이트
        view.layoutIfNeeded()
        
        
    }
    
    
    
    // UICollectionViewDataSource 및 UICollectionViewDelegate 메서드 구현
    // UICollectionViewDataSource 메서드
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageDatas.count
    }
    
    
    
    
    // UICollectionViewDataSource 메서드
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotoCollectionViewCell else {
            return UICollectionViewCell()
        }

        let imageData = imageDatas[indexPath.row]
        cell.imageView.image = imageData.image // 로드된 이미지 사용

        return cell
    }




    
    
    private func configureNavigationBar() {
        // 네비게이션 바 색상 설정
        navigationController?.navigationBar.barTintColor = .black // 배경 색상을 검은색으로 설정
        navigationController?.navigationBar.isTranslucent = false // 반투명 효과 제거
        
        // 네비게이션 바 아이템과 타이틀 색상 설정
        navigationController?.navigationBar.tintColor = .white // 아이템 색상을 흰색으로 설정
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white] // 타이틀 색상을 흰색으로 설정
        
        // iOS 15 이상에서는 다음과 같은 추가 설정이 필요할 수 있습니다.
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .black
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        }
    }
    
    
    private func setupNavigationTitleView() {
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.font = UIFont(name: "Pretendard-Regular", size: 14)
        titleLabel.lineBreakMode = .byWordWrapping
        
        let subtitleLabel = UILabel()
        subtitleLabel.numberOfLines = 0
        subtitleLabel.textAlignment = .center
        subtitleLabel.textColor = .lightGray
        subtitleLabel.font = UIFont.systemFont(ofSize: 12)
        
        if let museumName = museumName, let exhibitionTitle = exhibitionTitle {
            titleLabel.text = exhibitionTitle
            subtitleLabel.text = museumName
        } else {
            titleLabel.text = "기본 타이틀"
            subtitleLabel.text = "기본 부제목"
        }
        
        let titleStackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        titleStackView.axis = .vertical
        titleStackView.alignment = .center
        titleStackView.distribution = .equalSpacing
        
        self.navigationItem.titleView = titleStackView
        
        // Title Stack View의 제약 조건 설정
        titleStackView.snp.makeConstraints { make in
            make.width.lessThanOrEqualTo(self.view.frame.width - 40)
        }
    }
    
    @objc private func editReviewButtonTapped() {
        guard let reviewData = review else { return }

        let editViewController = ReviewEditPage()

        // 기존 리뷰 데이터 전달
            editViewController.originalTitle = reviewData.title
            editViewController.originalContent = reviewData.content
            editViewController.posterName = self.posterName
            editViewController.exhibitionTitle = exhibitionTitle // 전시 제목 전달
            editViewController.museumName = museumName // 뮤지엄 이름 전달

        // 이미지 데이터 변환 및 전달
           let images = imageDatas.compactMap { $0.image }
           editViewController.originalImages = images
        print("전달되는 이미지 URL 배열: \(reviewData.photoUrls)")
        print("포스터이름\(editViewController.posterName)")

        editViewController.imageUrls = reviewData.photoUrls // 여기서 reviewData.photoUrls는 URL 문자열 배열입니다.


        print("수정으로 전달하는 이미지 베열 주소\(editViewController.originalImages)")

        navigationController?.pushViewController(editViewController, animated: true)
    }





    func convertDateToString(_ date: Date) -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.locale = Locale(identifier: "ko-KR") // 한국어로 설정
        formatter.unitsStyle = .full // 전체 스타일로 표시 ('3분 전' 등)
        return formatter.localizedString(for: date, relativeTo: Date())
    }
    
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func collectionViewSetup() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0  // 셀 사이의 간격을 0으로 설정
        
        // 컬렉션 뷰의 셀 크기를 화면 너비에 맞춤
        let cellWidth = view.bounds.width - 40 // 20 points의 여유를 좌우에 줌
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth)
        
        // photoCollectionView가 아직 초기화되지 않았다면 생성합니다.
        if photoCollectionView == nil {
            photoCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            photoCollectionView.backgroundColor = .clear
            photoCollectionView.delegate = self
            photoCollectionView.dataSource = self
            photoCollectionView.isPagingEnabled = true
            photoCollectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCell")
            photoCollectionView.isHidden = true // 기본적으로 숨겨진 상태로 설정
            // 스크롤 바 숨기기ReviewEditPage
            photoCollectionView.showsHorizontalScrollIndicator = false
            photoCollectionView.showsVerticalScrollIndicator = false
            
            
            scrollView.addSubview(photoCollectionView)
            photoCollectionView.snp.makeConstraints { make in
                make.top.equalTo(scrollView.snp.top).offset(20)
                make.centerX.equalTo(view.snp.centerX)
                make.width.equalTo(cellWidth)
                make.height.equalTo(cellWidth)
            }
        }
        
        pageControl.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(photoCollectionView.snp.bottom).offset(10)
        }
        
        
    }
    
    
    private func adjustLayoutForNoPhotos() {
        
        
        scrollView.addSubview(profileImageView)
        profileImageView.backgroundColor = .gray // 임시 색상, 실제 이미지로 교체 필요
        profileImageView.layer.cornerRadius = 16 // 동그란 이미지를 위해
        profileImageView.clipsToBounds = true
        profileImageView.snp.remakeConstraints { make in
            make.top.equalTo(scrollView.snp.top).offset(20) // 여기서 위치 조정
            make.leading.equalTo(view.snp.leading).offset(20)
            make.width.height.equalTo(32) // 동그란 이미지 크기
        }
        
        
        
        
        
        
    }
    
    private func setupSquareViewAndLabel() {
        
        
        
        
        scrollView.addSubview(profileImageView)
        profileImageView.backgroundColor = .gray // 임시 색상, 실제 이미지로 교체 필요
        profileImageView.layer.cornerRadius = 16 // 동그란 이미지를 위해
        profileImageView.clipsToBounds = true
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(photoCollectionView.snp.bottom).offset(20)
            make.leading.equalTo(view.snp.leading).offset(20)
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
            make.trailing.equalTo(view.snp.trailing).offset(-20)
        }
        
        
        scrollView.addSubview(reviewTitle)
        reviewTitle.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(20)
            make.leading.equalTo(profileImageView.snp.leading)
            make.trailing.equalTo(timeLabel.snp.trailing)
        }
        
        scrollView.addSubview(contentLabel)
        contentLabel.text = """
        최근 다녀온 인상주의 작가전에서
        """
        contentLabel.numberOfLines = 0
        contentLabel.textColor = UIColor(red: 0.733, green: 0.733, blue: 0.733, alpha: 1)
        contentLabel.font = UIFont(name: "Pretendard-Regular", size: 16)
        contentLabel.lineBreakMode = .byWordWrapping
        var paragraphStyle = NSMutableParagraphStyle()
        //            paragraphStyle.lineHeightMultiple = 1.21
        // Line height: 18 pt
        paragraphStyle.alignment = .justified
        // 원하는 행간 비율 (160%)
        let lineHeightMultiple: CGFloat = 1.34
        // 폰트 크기에 비례하여 행간 설정
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        let attrString = NSMutableAttributedString(string: contentLabel.text!)
        paragraphStyle.lineSpacing = 1
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
        contentLabel.attributedText = attrString
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(reviewTitle.snp.bottom).offset(20)
            make.leading.equalTo(view.snp.leading).inset(20)
            make.trailing.equalTo(view.snp.trailing).inset(20)
            //      make.bottom.lessThanOrEqualTo(scrollView.snp.bottom).offset(-20)
        }
        
        
        // 첫 번째 추가 이미지 뷰 및 레이블 구성
        additionalImageButton1.setImage(UIImage(named: "Vector 3"), for: .normal)
        additionalImageButton1.addTarget(self, action: #selector(additionalImageButton1Tapped), for: .touchUpInside)

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
        additionalImageView2.image = UIImage(named: "")
        additionalLabel2.textColor = .white
        additionalLabel2.font = UIFont(name: "Pretendard-Light", size: 12)
        additionalLabel2.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        
        
        //        additionalLabel2.text = "456"
        additionalLabel2.text = ""
        
        // 스타일 및 글꼴 설정 등
        
        scrollView.addSubview(additionalImageButton1)
        scrollView.addSubview(additionalLabel1)
        scrollView.addSubview(additionalImageView2)
        scrollView.addSubview(additionalLabel2)
        
        
        
        additionalImageButton1.snp.makeConstraints { make in
               make.top.equalTo(contentLabel.snp.bottom).offset(30)
               make.left.equalTo(contentLabel.snp.left)
               make.width.equalTo(17.5)
               make.height.equalTo(14.5)
               make.bottom.lessThanOrEqualTo(scrollView.snp.bottom).offset(-20)
           }


        additionalLabel1.snp.makeConstraints { make in
            make.centerY.equalTo(additionalImageButton1)
            make.left.equalTo(additionalImageButton1.snp.right).offset(10)
        }
        
        // 두 번째 추가 이미지 뷰와 레이블 레이아웃
        additionalImageView2.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(27.0)
            make.left.equalTo(additionalLabel1.snp.right).offset(10)
            make.width.height.equalTo(20)
        }
        
        additionalLabel2.snp.makeConstraints { make in
            make.centerY.equalTo(additionalImageView2)
            make.left.equalTo(additionalImageView2.snp.right).offset(8)
        }
        
        
    }

    @objc private func additionalImageButton1Tapped() {

        // 햅틱 피드백 생성
          let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
          feedbackGenerator.impactOccurred()
        
        guard let userReviewUUID = userReviewUUID, let posterName = posterName, let currentUserID = CurrentUser.shared.uid else {
            print("필요한 정보가 부족합니다.")
            return
        }

        let reviewRef = Firestore.firestore().collection("posters").document(posterName)
            .collection("reviews").document(userReviewUUID)

        reviewRef.getDocument { [weak self] documentSnapshot, error in
            guard let document = documentSnapshot, error == nil else {
                print("Error fetching document: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            var likes = document.data()?["likes"] as? [String: Bool] ?? [:]
            let currentLikeStatus = likes[currentUserID] ?? false
            // 좋아요 상태 반전
            likes[currentUserID] = !currentLikeStatus

            // 좋아요 수 업데이트
            var likesNum = document.data()?["likesNum"] as? Int ?? 0
            likesNum += (currentLikeStatus ? -1 : 1)

            DispatchQueue.main.async {
                // UI 업데이트
                self?.updateLikeButtonUI(isLiked: !currentLikeStatus, likeCount: likesNum)

                // 로티 애니메이션 실행
                       if !currentLikeStatus {
                           self?.likeAnimationView.isHidden = false
                           self?.likeAnimationView.play(completion: { finished in
                               self?.likeAnimationView.isHidden = true
                           })
                       }
            }

            // Firestore 업데이트
            reviewRef.updateData(["likes": likes, "likesNum": likesNum]) { error in
                if let error = error {
                    print("Error updating likes: \(error.localizedDescription)")
                } else {
                    print("Likes successfully updated.")
                }
            }
        }
    }

    private func updateLikeButtonUI(isLiked: Bool, likeCount: Int) {
        let iconName = isLiked ? "Vector 5" : "Vector 3"
        additionalImageButton1.setImage(UIImage(named: iconName), for: .normal)
        additionalLabel1.text = "\(likeCount)"
    }



    func checkLikeStatusAndUpdateIcon() {
        guard let userReviewUUID = userReviewUUID, let posterName = posterName, let currentUserID = CurrentUser.shared.uid else {
            print("필요한 정보가 부족합니다.")
            return
        }

        let reviewRef = Firestore.firestore().collection("posters").document(posterName)
            .collection("reviews").document(userReviewUUID)

        reviewRef.getDocument { [weak self] documentSnapshot, error in
            DispatchQueue.main.async {
                guard let document = documentSnapshot, error == nil else {
                    print("Error fetching document: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }

                let likes = document.data()?["likes"] as? [String: Bool] ?? [:]
                let likesNum = document.data()?["likesNum"] as? Int ?? 0 // 좋아요 수 가져오기
                let isLiked = likes[currentUserID] ?? false
                
                // 좋아요 아이콘과 수 업데이트
                self?.updateLikesCount(likesNum)
                // 좋아요 버튼 UI 업데이트
                self?.updateLikeButtonUI(isLiked: isLiked)
            }
        }
    }

    // 좋아요 버튼 UI 업데이트 함수
    func updateLikeButtonUI(isLiked: Bool) {
        let iconName = isLiked ? "Vector 5" : "Vector 3" // 'likedIconName'과 'unlikedIconName'을 실제 아이콘 이름으로 교체하세요.
        additionalImageButton1.setImage(UIImage(named: iconName), for: .normal)
    }

    func updateLikesCount(_ count: Int) {
        additionalLabel1.text = "\(count)"
    }


    private func setupNavigationTitleAndSubtitle() {
        let titleLabel = UILabel()
        titleLabel.text = exhibitionTitle // 여기에 전시 타이틀을 설정
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        titleLabel.numberOfLines = 0 // 여러 줄 표시를 위해 0으로 설정
        
        let subtitleLabel = UILabel()
        subtitleLabel.text = museumName // 여기에 뮤지엄 이름을 설정
        subtitleLabel.textColor = .lightGray
        subtitleLabel.font = UIFont.systemFont(ofSize: 12)
        subtitleLabel.numberOfLines = 0 // 여러 줄 표시를 위해 0으로 설정
        
        let titleStackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        titleStackView.axis = .vertical
        titleStackView.alignment = .center
        titleStackView.distribution = .equalCentering
        
        self.navigationItem.titleView = titleStackView
    }
    
    
    
    @objc func backButtonTapped() {
        // 네비게이션 컨트롤러에 푸시된 경우
        if let navController = self.navigationController, navController.viewControllers.contains(self) {
            // 네비게이션 스택에서 이전 뷰 컨트롤러로 이동
            navController.popViewController(animated: true)
            self.dismiss(animated: true, completion: nil)
            
        }
    }
    
    
    
    private func setupNavigationBackButton() {
        let backButton = createCustomBackButton()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let fullScreenSlideshowViewController = FullScreenSlideshowViewController()
        fullScreenSlideshowViewController.slideshow.currentPageChanged = { page in
            print("current page:", page)
        }

        // ImageSlideshow에 이미지 소스 설정
        // SDWebImageSource를 사용하여 각 URL로부터 이미지 소스를 생성합니다.
        let inputs = imageDatas.map { SDWebImageSource(url: $0.url) }
        fullScreenSlideshowViewController.slideshow.setImageInputs(inputs)

        // 현재 페이지 설정
        fullScreenSlideshowViewController.slideshow.setCurrentPage(indexPath.row, animated: false)

        // 전체 화면 슬라이드쇼 보기 표시
        fullScreenSlideshowViewController.modalPresentationStyle = .fullScreen
        present(fullScreenSlideshowViewController, animated: true, completion: nil)
    }


}

extension ReviewDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / view.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }

    
}


class PhotoCollectionViewCell: UICollectionViewCell {
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 14
        contentView.addSubview(imageView)
        imageView.frame = contentView.bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class CurrentUser {
    static let shared = CurrentUser()
    
    var uid: String?
    var email: String?
    
    private init() {}
}
