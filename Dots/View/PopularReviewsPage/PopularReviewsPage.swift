// 인기 리뷰 뷰 컨트롤러
import RxCocoa
import RxSwift
import SnapKit
import UIKit

class PopularReviewsPage: UIViewController {
    private let 현재페이지 = BehaviorRelay<Int>(value: 0)
    let 페이지_제목 = {
        let label = UILabel()
        label.text = "HOT"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()

    let 인기순_버튼 = {
        let button = UIButton()
        button.setTitle("인기순", for: .normal)
        button.setTitle("인기순", for: .selected)
        button.setTitleColor(UIColor.white, for: .selected)
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        button.layer.cornerRadius = 10
        button.isSelected = !button.isSelected
        return button
    }()

    let 구분선 = {
        let label = UILabel()
        label.text = "|"
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()

    let 추천순_버튼 = {
        let button = UIButton()
        button.setTitle("추천순", for: .normal)
        button.setTitle("추천순", for: .selected)
        button.setTitleColor(UIColor.white, for: .selected)
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        button.layer.cornerRadius = 10
        button.isSelected = !button.isSelected
        return button
    }()

    let 반투명_선택_풍선 = {
        let ui = UIView()
        ui.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        ui.layer.cornerRadius = 10
        return ui
    }()

    let 인기_컬렉션_뷰: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.layer.cornerRadius = 10
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.decelerationRate = UIScrollView.DecelerationRate.fast

        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clear
        ui레이아웃()
        인기_컬렉션_뷰.dataSource = self
        인기_컬렉션_뷰.delegate = self
        인기_컬렉션_뷰.register(PopularReviewCell.self, forCellWithReuseIdentifier: "PopulaReviewCell")
        인기_컬렉션_뷰.isPagingEnabled = true
        //
    }
}

extension PopularReviewsPage {
    func ui레이아웃() {
        view.addSubview(페이지_제목)
        view.addSubview(인기순_버튼)
        view.addSubview(구분선)
        view.addSubview(추천순_버튼)
        view.addSubview(인기_컬렉션_뷰)
        페이지_제목.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(22)
            make.top.equalToSuperview().offset(60)
            make.centerX.equalToSuperview()
        }
        인기순_버튼.snp.makeConstraints { make in
            make.top.equalTo(페이지_제목.snp.bottom).offset(20)
            make.trailing.equalTo(구분선.snp.leading).offset(-5)
            make.bottom.equalTo(구분선)
        }
        구분선.snp.makeConstraints { make in
            make.trailing.equalTo(추천순_버튼.snp.leading).offset(-5)
            make.centerY.equalTo(인기순_버튼)
        }
        추천순_버튼.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-12)
            make.bottom.equalTo(인기순_버튼)
        }
        인기_컬렉션_뷰.snp.makeConstraints { make in
            make.top.equalTo(인기순_버튼.snp.bottom).offset(10)
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview().offset(-100)
            make.centerX.equalToSuperview()
        }
    }
}

extension PopularReviewsPage: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopulaReviewCell", for: indexPath) as? PopularReviewCell else {
            return UICollectionViewCell()
        }

        cell.인기셀_이미지.image = UIImage(named: "morningStar")
        cell.인기셀_작성자_이미지.image = UIImage(named: "cabanel")
        cell.인기셀_작성자_이름.text = "리뷰 작성자"
        cell.인기셀_하트_아이콘.image = UIImage(systemName: "heart")?.withTintColor(UIColor.lightGray, renderingMode: .alwaysOriginal)
        cell.인기셀_아티스트.setTitle("알렉상드르 카바넬", for: .normal)
        cell.인기셀_전시장소.setTitle("파리 루브르 박물관", for: .normal)
        cell.인기셀_리뷰제목.text = "Morning Star"
        cell.인기셀_리뷰내용.text = """
        '타락한 천사’는 19세기 프랑스 화가 알렉상드르 카바넬(Alexandre Cabanel)의 작품이다. 에두아르 마네를 구심점으로 새로운 미술 운동인 인상주의가 태동하고 있을 때, 카바넬은 아카데믹한 고전주의 양식으로 작업한 제도권 미술계의 총아였다. 그는 신화와 역사, 성서 이야기를 주제로 하는 역사화, 종교화를 그렸다.이 장르의 전통적인 테마는 성인, 천사, 영웅적인 인물이었는데, 카바넬은 ‘타락한 천사’에서 악마를 묘사해 당대 많은 논란을 일으켰다.
        """
        let 최대_글자수 = 200
        if let text = cell.인기셀_리뷰내용.text, text.count > 최대_글자수 {
            let 글자수_줄이기 = String(text.prefix(최대_글자수)) + " . . ." + " 더보기"
            cell.인기셀_리뷰내용.text = 글자수_줄이기
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width * 1
        let height = collectionView.frame.height * 1
        return CGSize(width: width, height: height)
    }
}
