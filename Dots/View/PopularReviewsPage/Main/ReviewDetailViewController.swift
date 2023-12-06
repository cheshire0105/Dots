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



    // 새로운 컴포넌트 선언
    let additionalImageView1 = UIImageView()
    let additionalLabel1 = UILabel()
    let additionalImageView2 = UIImageView()
    let additionalLabel2 = UILabel()
    let reviewTitle = UILabel()

    var review: Review? // 추가된 프로퍼티

    var imageDatas: [ImageData] = [] // 이미지 데이터 배열

    var selectedImages: [UIImage] = []

    var imageUrls: [String] = [] // 이미지 URL 배열 추가


    // 추가된 프로퍼티
       var museumName: String?
       var exhibitionTitle: String?


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
//        loadImages() // 이미지 로드
        loadImages(from: imageUrls)

        
        setupNavigationBackButton()
        setupNavigationTitleAndSubtitle() // 변경된 메서드 호출

        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self

        setupScrollView()
        collectionViewSetup()
        setupSquareViewAndLabel()
        setupNavigationTitleView() // 변경된 메서드 호출
        configureNavigationBar()




        
        if let reviewData = review {
             // UI 컴포넌트에 데이터 바인딩
             nameLabel.text = reviewData.nickname
             timeLabel.text = convertDateToString(reviewData.createdAt)
             reviewTitle.text = reviewData.title
             contentLabel.text = reviewData.content
             // profileImageView에 이미지 로드 (예: URL에서 이미지를 로드하는 경우)
            // 리뷰에 사진이 없는 경우
                    if reviewData.photoUrls.isEmpty {
                        photoCollectionView.isHidden = true
                        adjustLayoutForNoPhotos()
                    }
            // URL 문자열을 사용하여 이미지 로드
             if let imageUrl = URL(string: reviewData.profileImageUrl) {
                 // URL에서 이미지 데이터를 가져옵니다.
                 URLSession.shared.dataTask(with: imageUrl) { data, response, error in
                     guard let data = data, error == nil else { return }

                     // 메인 스레드에서 이미지 뷰에 이미지 설정
                     DispatchQueue.main.async {
                         self.profileImageView.image = UIImage(data: data)
                     }
                 }.resume()
             }

            // 사진 유무에 따라 컬렉션 뷰의 가시성 조정
                  photoCollectionView.isHidden = reviewData.photoUrls.isEmpty
                  if photoCollectionView.isHidden {
                      adjustLayoutForNoPhotos()
                  } else {
                      adjustLayoutForPhotos()
                  }
         }

            
    }

    // 이미지 로드 함수
    func loadImages(from urls: [String]) {
         imageDatas.removeAll() // 기존 이미지 데이터 초기화

         for urlString in urls {
             guard let url = URL(string: urlString) else { continue }
             URLSession.shared.dataTask(with: url) { data, _, _ in
                 if let data = data, let image = UIImage(data: data) {
                     DispatchQueue.main.async {
                         self.imageDatas.append(ImageData(url: url, image: image))
                         self.photoCollectionView.reloadData()
                     }
                 }
             }.resume()
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


              scrollView.addSubview(photoCollectionView)
              photoCollectionView.snp.makeConstraints { make in
                  make.top.equalTo(scrollView.snp.top).offset(20)
                  make.centerX.equalTo(view.snp.centerX)
                  make.width.equalTo(cellWidth)
                  make.height.equalTo(cellWidth)
              }
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
        최근 다녀온 인상주의 작가전에서 많은 영감을 받았습니다. 이번 전시에서는 다양한 작가들의 작품을 통해 인상주의의 다양한 표현과 미학에 대한 통찰을 얻을 수 있었습니다. 먼저, 전시에는 독특하고 선명한 색채가 돋보이는 작품들이 많았습니다. 작가들은 강렬한 색상을 통해 감정과 분위기를 전달하며 관람자에게 강한 인상을 남겼습니다. 특히, 대조적인 색감을 활용한 작품은 눈에 띄게 독창적이었습니다.
        인상주의는 자연의 아름다움을 강조하고 일상적인 풍경을 미적으로 해석하는 경향이 있습니다. 이번 전시에서는 도시의 소란스러운 풍경이나 자연의 고요함이 아름답게 표현된 작품들이 많았습니다. 이를 통해 작가들은 우리 주변의 일상에서도 예술을 발견할 수 있다는 메시지를 전달한 것 같았습니다.
        또한, 작품들은 각자의 시대적 맥락과 문화적 배경을 반영하면서도 개인적인 감성을 잘 표현했습니다. 이는 인상주의의 특징 중 하나로, 개인적인 경험과 감정을 작품에 담아내어 관람자와 소통하는 데 성공한 결과로 보입니다.
        이번 전시를 통해 인상주의의 다양한 스타일과 접근법을 경험하면서 예술의 폭넓은 가능성에 대한 새로운 시각을 얻을 수 있었습니다. 작가들의 창의적인 시도와 자유로운 표현이 예술의 다양성을 더욱 풍부하게 만들어준 것 같습니다.
        """
            contentLabel.numberOfLines = 0
            contentLabel.textColor = UIColor(red: 0.733, green: 0.733, blue: 0.733, alpha: 1)
            contentLabel.font = UIFont(name: "Pretendard-Regular", size: 14)
            contentLabel.lineBreakMode = .byWordWrapping
            var paragraphStyle = NSMutableParagraphStyle()
//            paragraphStyle.lineHeightMultiple = 1.21
            // Line height: 18 pt
            paragraphStyle.alignment = .justified
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

}

class PhotoCollectionViewCell: UICollectionViewCell {
    let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)
        imageView.frame = contentView.bounds
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
