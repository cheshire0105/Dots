//23 . 11 . 7  2:51 pm dev 풀 완료 최신화 커밋 - > 브랜치 스타팅 포인트
// 23.11.27 오후 2시 22분 계성 -> 이어 받아서 작업 중
// 최신화 머지 2023년 11월 27일
import UIKit
import SwiftUI
import RxSwift
import RxCocoa
import SnapKit
import Toast_Swift

class PopularReviewDetail : UIViewController {

    var selectedCellIndex: Int?

    var 전시정보_메인셀_인스턴스 = 전시정보_택스트(전시아티스트이름: "", 전시장소이름: "", 본문제목: "", 본문내용: "")

    lazy var heartIcon: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "heartIcon"), for: .normal) // 버튼의 기본 상태 이미지를 설정합니다.
        button.backgroundColor = .white
        button.layer.cornerRadius = 20

        button.layer.shadowOpacity = 0.9
        button.layer.shadowRadius = 2
        button.layer.shadowOffset = CGSize(width: 1, height: 1)
        button.layer.shadowColor = UIColor.black.cgColor


        button.addTarget(self, action: #selector(heartIconTapped), for: .touchUpInside) // 버튼 액션 추가
        return button
    }()

    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "loginBack"), for: .normal) // 버튼의 기본 상태 이미지를 설정합니다.
        button.backgroundColor = .white
        button.layer.cornerRadius = 20

        button.layer.shadowOpacity = 0.9
        button.layer.shadowRadius = 2
        button.layer.shadowOffset = CGSize(width: 1, height: 1)
        button.layer.shadowColor = UIColor.black.cgColor

        button.addTarget(self, action: #selector(뒤로가기_버튼_클릭), for: .touchUpInside) // 버튼 액션 추가

        return button
    }()

    // 스크롤 뷰 인스턴스를 생성합니다.
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = .black
        return scrollView
    }()


    lazy var 인기_디테일_컬렉션뷰: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .black
        collectionView.layer.cornerRadius = 30
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(인기리뷰_디테일_셀.self, forCellWithReuseIdentifier: "인기리뷰_디테일_셀")
        return collectionView
    }()


    private var 인기셀_작성자_이미지 = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "cabanel")
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private let 인기셀_작성자_이름: UILabel = {
        let label = UILabel()
        label.text = "nickName"
        label.textColor = .white
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        label.textAlignment = .left
        return label
    }()


    private let 리뷰_제목 = {
        let label = UILabel()
        label.text = "어떤 전시를 보며..."
        label.font = UIFont(name: "Pretendard-Bold", size: 20)
        label.textColor = UIColor.white
        return label
    } ()
    private let 리뷰_전시명 = {
        let label = UILabel()
        label.text = "리암 길릭 : Alterants"
        label.font = UIFont(name: "Pretendard-Regular", size: 16)
        label.textColor = UIColor.white
        return label
    } ()
    private let 리뷰_내용 = {
        let label = UILabel()
        label.text = """
이번 전시회는 참으로 놀라웠습니다. 각 작품마다 독특한 색채와 구성이 눈길을 끌었어요. 특히, 현대적 감각과 전통적 요소가 결합된 작품들이 인상적이었습니다. 전시장의 분위기도 매우 편안했고, 각 작품 설명이 친절하게 제공되어 작품에 대한 이해도가 높아졌습니다. 작가의 깊은 사유와 창의적인 표현력이 돋보였던 시간이었어요. 전시된 작품 중에는 자연의 아름다움을 담은 회화부터 현대 사회의 복잡한 이슈를 다룬 설치 작품까지 다양했습니다. 방문객들의 다양한 반응을 보는 것도 흥미로웠고, 저 또한 많은 영감을 받았습니다. 이러한 전시를 통해 예술의 다양한 면모를 경험할 수 있어 기쁩니다. 또한, 이번 전시를 준비한 모든 분들의 노력에 감사드리며, 앞으로도 이러한 풍부한 문화적 경험이 계속되길 바랍니다.
"""
        label.textColor = UIColor.white
        label.font = UIFont(name: "Pretendard-Regular", size: 16)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .justified
        return label
    } ()

    private let 리뷰_전시명_하단선: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.158, green: 0.158, blue: 0.158, alpha: 1)
        return view
    }()


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

        print("Popular Review Detail")

        view.backgroundColor = .black
        navigationController?.setNavigationBarHidden(true, animated: true)


        // 기존 UI 구성 메서드 호출
        setupScrollView()



    }





    @objc func 뒤로가기_버튼_클릭() {
        navigationController?.popViewController(animated: true)
    }


    @objc func heartIconTapped() {
        // 버튼의 현재 선택 상태를 반전시킵니다.
        heartIcon.isSelected.toggle()

        if heartIcon.isSelected {
            // 선택된 경우: 토스트 메시지 표시 및 이미지 변경
            let newImageName = "Vector 1" // 선택된 상태의 이미지
            heartIcon.setImage(UIImage(named: newImageName), for: .normal)


        } else {
            // 선택 해제된 경우: 원래의 이미지로 변경 (토스트는 표시하지 않음)
            let originalImageName = "heartIcon"
            heartIcon.setImage(UIImage(named: originalImageName), for: .normal)
        }
    }

    private func setupScrollView() {
        // 뷰에 스크롤 뷰를 추가합니다.
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }

        // 스크롤 뷰의 컨텐츠 뷰를 추가합니다.
        let contentView = UIView()
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView) // 가로는 스크롤 뷰의 가로와 동일
            // 세로 높이는 필요에 따라 설정합니다. 예를 들어, 매우 큰 값으로 설정할 수 있습니다.
        }

        // 컨텐츠 뷰에 서브뷰들을 추가합니다.
        view.addSubview(backButton)
        view.addSubview(heartIcon)

        // 하트 아이콘의 제약 조건을 설정합니다.
        heartIcon.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-16)
            make.width.height.equalTo(40)
        }

        // 백 버튼의 제약 조건을 설정합니다.
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.width.height.equalTo(40)
        }

        contentView.addSubview(인기_디테일_컬렉션뷰)
        인기_디테일_컬렉션뷰.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(80)
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(view.frame.width - 20) // 뷰의 가로 길이에서 양쪽 여백(10 * 2)을 뺀 값으로 높이 설정
        }

        contentView.addSubview(인기셀_작성자_이미지)
        인기셀_작성자_이미지.snp.makeConstraints { make in
            make.top.equalTo(인기_디테일_컬렉션뷰.snp.bottom).offset(18)
            make.leading.equalTo(contentView.snp.leading).inset(10)
            make.width.height.equalTo(40)
        }

        contentView.addSubview(인기셀_작성자_이름)
        인기셀_작성자_이름.snp.makeConstraints { make in
            make.centerY.equalTo(인기셀_작성자_이미지)
            make.leading.equalTo(인기셀_작성자_이미지.snp.trailing).offset(10)
        }

        contentView.addSubview(리뷰_제목)
        리뷰_제목.snp.makeConstraints { make in
            make.top.equalTo(인기셀_작성자_이미지.snp.bottom).offset(10)
            make.leading.equalTo(contentView.snp.leading).inset(10)
        }


        contentView.addSubview(리뷰_전시명)
        리뷰_전시명.snp.makeConstraints { make in
            make.top.equalTo(리뷰_제목.snp.bottom).offset(10)
            make.leading.equalTo(contentView.snp.leading).inset(10)
        }


        contentView.addSubview(리뷰_전시명_하단선)
        리뷰_전시명_하단선.snp.makeConstraints { make in
            make.top.equalTo(리뷰_전시명.snp.bottom).offset(18) // 리뷰 전시명 바로 아래에 위치
            make.leading.trailing.equalTo(contentView)
            make.height.equalTo(1) // 선의 높이 (두께) 설정
        }


        contentView.addSubview(리뷰_내용)
         리뷰_내용.snp.makeConstraints { make in
             make.top.equalTo(리뷰_전시명_하단선.snp.bottom).offset(18)
             make.leading.trailing.equalTo(contentView).inset(10)
             // 리뷰 내용 레이블의 하단을 contentView의 하단에 맞춥니다.
             make.bottom.equalTo(contentView.snp.bottom).offset(-10) // 하단 여백을 추가할 수 있습니다.
         }
    }

}

extension PopularReviewDetail : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "인기리뷰_디테일_셀", for: indexPath) as? 인기리뷰_디테일_셀 else {
            return UICollectionViewCell()
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width * 1
        let height = collectionView.frame.height * 1
        return CGSize(width: width, height: height)
    }

}

import RxCocoa
import RxSwift
import SnapKit
import UIKit

class 인기리뷰_디테일_셀: UICollectionViewCell {
    var 인기셀_디테일_이미지 = {
        var imageView = UIImageView()
        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderWidth = 10
        imageView.layer.borderColor = UIColor.darkGray.withAlphaComponent(0.7).cgColor

        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        contentView.addSubview(인기셀_디테일_이미지)
        인기셀_디테일_이미지.snp.makeConstraints { make in
            make.size.equalToSuperview()
        }
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
