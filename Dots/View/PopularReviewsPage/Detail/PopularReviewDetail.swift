//23 . 11 . 7  2:51 pm dev 풀 완료 최신화 커밋 - > 브랜치 스타팅 포인트
// 23.11.27 오후 2시 22분 계성 -> 이어 받아서 작업 중
// 최신화 머지 2023년 11월 27일 
import UIKit
import SwiftUI
import RxSwift
import RxCocoa
import SnapKit
import PanModal
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


        return button
    }()

    private var 유저_블록 = {
        let uiView = UIView()
        uiView.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        uiView.layer.cornerRadius = 20
        return uiView
    } ()

//    private var 좋아요_블록 = {
//        let uiView = UIView()
//        uiView.backgroundColor = UIColor.systemPink.withAlphaComponent(0.8)
//        uiView.layer.cornerRadius = 20
//        return uiView
//    } ()
//
//    private var 조회수_블록 = {
//        let uiView = UIView()
//        uiView.backgroundColor = UIColor.white.withAlphaComponent(0.8)
//        uiView.layer.cornerRadius = 20
//        return uiView
//    } ()

    private var 인기셀_작성자_이미지 = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "cabanel")
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private let 인기셀_작성자_이름: UILabel = {
        let label = UILabel()
        label.text = "박철우"
        label.textColor = UIColor.black
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        label.textAlignment = .left
        return label
    }()

    private let 좋아요_버튼 = {
        let button = UIButton()
        button.setImage(UIImage(named: "좋아요"), for: .normal)
        button.isSelected = !button.isSelected

        return button
    } ()


    private let 리뷰_제목 = {
        let label = UILabel()
        label.text = "전시 리뷰 제목 택스트"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor.white
        return label
    } ()
    private let 리뷰_전시명 = {
        let label = UILabel()
        label.text = "리암 길릭 : Alterants"
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        label.textColor = UIColor.white
        return label
    } ()
    private let 리뷰_내용 = {
        let label = UILabel()
        label.text = """
        글내용글내용글내용글내용글내용글내용글내용글내용글내용글내용글내용글내용글내용글내용글내용글내용글내용글내용글내용글내용글내용글내용글내용글내용글내용글내용글내용글내용글내용글내용글내용글내용글내용글내용글내용글내용글내용글내용글내용글내용글내용글내용글내용글내용글내용글내용글내용글내용
        """
        label.textColor = UIColor.white
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .justified
        return label
    } ()

    private let 댓글_버튼 = {
        let 댓글갯수 : Int = 0
        let button = UIButton()
        button.setTitle(" 댓글\(댓글갯수)개", for: .normal)
        button.setTitleColor(UIColor.black, for: .selected)
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 12)
        button.setImage(UIImage(named: "댓글"), for: .normal)
        button.backgroundColor = UIColor.white
        button.isSelected = !button.isSelected
        button.layer.cornerRadius = 10
        return button
    } ()

    lazy var 인기_디테일_컬렉션뷰: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

        collectionView.backgroundColor = .black
        collectionView.layer.cornerRadius = 30
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        collectionView.isPagingEnabled = true
        return collectionView
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
        //        navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        인기_디테일_컬렉션뷰.dataSource = self
        인기_디테일_컬렉션뷰.delegate = self
        버튼_클릭()
        컬렉션뷰_레이아웃()
        UI레이아웃()
        인기_디테일_컬렉션뷰.register(인기리뷰_디테일_셀.self, forCellWithReuseIdentifier: "인기리뷰_디테일_셀")

        if let selectedIndex = selectedCellIndex {
            print("Selected Review Title: \(전시정보_메인셀_인스턴스.인기_전시정보[selectedIndex].본문제목)")
            print("Selected Review Content: \(전시정보_메인셀_인스턴스.인기_전시정보[selectedIndex].본문내용)")
            print("Selected Review Artist: \(전시정보_메인셀_인스턴스.인기_전시정보[selectedIndex].전시아티스트이름)")
            print("Selected Review Location: \(전시정보_메인셀_인스턴스.인기_전시정보[selectedIndex].전시장소이름)")
        }
    }



    private func 버튼_클릭() {
        backButton.addTarget(self, action: #selector(뒤로가기_버튼_클릭), for: .touchUpInside)
        댓글_버튼.addTarget(self, action: #selector(댓글_버튼_클릭), for: .touchUpInside)

    }
    @objc func 뒤로가기_버튼_클릭() {
        navigationController?.popViewController(animated: true)
    }
    @objc func 댓글_버튼_클릭() {
        let 댓글_판모달 = PopularReviewDetailPanModal()
        presentPanModal(댓글_판모달)
    }


    @objc func heartIconTapped() {
        // 버튼의 현재 선택 상태를 반전시킵니다.
        heartIcon.isSelected.toggle()

        if heartIcon.isSelected {
            // 선택된 경우: 토스트 메시지 표시 및 이미지 변경
            let newImageName = "Vector 1" // 선택된 상태의 이미지
            heartIcon.setImage(UIImage(named: newImageName), for: .normal)

            //            var toastStyle = ToastStyle()
            //            toastStyle.messageColor = .white
            //            toastStyle.messageFont = UIFont(name: "Pretendard-Bold", size: 16) ?? .boldSystemFont(ofSize: 20)
            //
            //            self.view.makeToast("가 맘에 드셨군요!", duration: 1.5, position: .center, style: toastStyle)
        } else {
            // 선택 해제된 경우: 원래의 이미지로 변경 (토스트는 표시하지 않음)
            let originalImageName = "heartIcon"
            heartIcon.setImage(UIImage(named: originalImageName), for: .normal)
        }
    }
}

extension PopularReviewDetail {
    func UI레이아웃 () {

        view.addSubview(backButton)
        view.addSubview(유저_블록)
        view.addSubview(인기셀_작성자_이미지)
        view.addSubview(인기셀_작성자_이름)
        view.addSubview(좋아요_버튼)
        view.addSubview(리뷰_제목)
        view.addSubview(리뷰_전시명)
        view.addSubview(리뷰_내용)
        view.addSubview(댓글_버튼)
        view.addSubview(heartIcon)

        backButton.snp.makeConstraints { make in // SnapKit을 사용하여 제약 조건 설정
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10) // 상단 safe area로부터 10포인트 아래에 위치
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16) // leading edge로부터 10포인트 떨어진 곳에 위치
            make.width.height.equalTo(40) // 너비와 높이는 40포인트로 설정
        }

        heartIcon.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(10)
            make.trailing.equalTo(view.snp.trailing).inset(16)
            make.width.height.equalTo(40)
        }

        유저_블록.snp.makeConstraints { make in
            make.top.equalTo(인기_디테일_컬렉션뷰.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-250)
            make.bottom.equalToSuperview().offset(-312)
        }

        인기셀_작성자_이미지.snp.makeConstraints { make in
            make.top.equalTo(유저_블록.snp.top).offset(5)
            make.leading.equalTo(유저_블록.snp.leading).offset(5)
            make.bottom.equalTo(유저_블록.snp.bottom).offset(-5)
            make.trailing.equalTo(인기셀_작성자_이름.snp.leading).offset(-5)
        }

        인기셀_작성자_이름.snp.makeConstraints { make in
            make.top.equalTo(유저_블록.snp.top).offset(5)
            make.bottom.equalTo(유저_블록.snp.bottom).offset(-5)
            make.leading.equalTo(유저_블록.snp.leading).offset(38)
        }

        리뷰_제목.snp.makeConstraints { make in
            make.top.equalTo(유저_블록.snp.bottom).offset(36)
            make.leading.equalTo(유저_블록)

        }
        리뷰_전시명.snp.makeConstraints { make in
            make.top.equalTo(리뷰_제목.snp.bottom).offset(10)
            make.leading.equalTo(유저_블록)
        }
        리뷰_내용.snp.makeConstraints { make in
            make.top.equalTo(리뷰_전시명.snp.bottom).offset(20)
            make.leading.equalTo(유저_블록)
            make.trailing.equalTo(view.snp.trailing)

        }
        댓글_버튼.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.width.equalTo(100)
            make.bottom.equalToSuperview().offset(-42)
            make.centerX.equalToSuperview()
        }
    }

    func 컬렉션뷰_레이아웃() {
        view.addSubview(인기_디테일_컬렉션뷰)
        인기_디테일_컬렉션뷰.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(80)
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().offset(-365)
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

extension PopularReviewDetail : PanModalPresentable {
    var panScrollable: UIScrollView? {
        return 인기_디테일_컬렉션뷰
    }
}
