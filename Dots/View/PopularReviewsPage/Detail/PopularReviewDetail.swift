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
        scrollView.backgroundColor = .gray
        return scrollView
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
            make.height.greaterThanOrEqualTo(1000) // 또는 실제 필요한 세로 높이에 따라 조정
        }

        // 컨텐츠 뷰에 서브뷰들을 추가합니다.
        contentView.addSubview(backButton)
        contentView.addSubview(heartIcon)

        // 하트 아이콘의 제약 조건을 설정합니다.
        heartIcon.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(10)
            make.right.equalTo(contentView).offset(-16)
            make.width.height.equalTo(40)
        }

        // 백 버튼의 제약 조건을 설정합니다.
        backButton.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(10)
            make.left.equalTo(contentView).offset(16)
            make.width.height.equalTo(40)
        }
    }

}
