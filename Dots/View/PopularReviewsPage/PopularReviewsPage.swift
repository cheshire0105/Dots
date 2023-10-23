// 인기후기페이지 뷰컨트롤러
import SnapKit
import UIKit

class PopularReviewsPage: UIViewController {

    let 인기순_추천순_버튼 = {
        let button = UIButton()
        button.setTitle("인기순 | 추천순", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        return button
    }()

    let 인기_컬렉션_뷰: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 345, height: 625)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.layer.cornerRadius = 10
        layout.scrollDirection = .horizontal

        collectionView.showsHorizontalScrollIndicator = false

        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        네비게이션_바()
        ui레이아웃()
        인기_컬렉션_뷰.dataSource = self
        인기_컬렉션_뷰.delegate = self
        인기_컬렉션_뷰.register(CustomCell.self, forCellWithReuseIdentifier: "PopulaReviewCell")
    }
}

extension PopularReviewsPage {
    func 네비게이션_바() {
        let 네비게이션바 = UINavigationBar()
        네비게이션바.barTintColor = UIColor.black
        네비게이션바.isTranslucent = false
        네비게이션바.tintColor = UIColor.white

        let 네비게이션바_아이탬 = UINavigationItem(title: "")
        네비게이션바_아이탬.titleView = UILabel() // 빈 UILabel을 titleView로 설정

        // 타이틀 색상 설정
        if let titleLabel = 네비게이션바_아이탬.titleView as? UILabel {
            titleLabel.text = "Popular Review"
            titleLabel.textColor = UIColor.white
            titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        }

        네비게이션바.items = [네비게이션바_아이탬]

        // Safe Area에 맞춰 Auto Layout 설정
        view.addSubview(네비게이션바)
        네비게이션바.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(44) // 기본 네비게이션 바의 높이
        }
    }
}

extension PopularReviewsPage {
    func ui레이아웃() {
        view.addSubview(인기순_추천순_버튼)
        view.addSubview(인기_컬렉션_뷰)
        
        인기순_추천순_버튼.snp.makeConstraints { make in
            make.width.equalTo(103)
            make.height.equalTo(22)
            make.top.equalToSuperview().offset(100)
            make.bottom.equalTo(인기_컬렉션_뷰.snp.top).offset(-5)
            make.leading.equalToSuperview().offset(274)
            make.trailing.equalToSuperview().offset(-16)
        }
        인기_컬렉션_뷰.snp.makeConstraints { make in
            make.width.equalTo(345)
            make.height.equalTo(645)
            make.top.equalTo(인기순_추천순_버튼.snp.bottom).offset(-5)
            make.bottom.equalToSuperview().offset(-125)
            make.leading.equalToSuperview().offset(26)
        }
    }
}

extension PopularReviewsPage: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopulaReviewCell", for: indexPath) as? CustomCell else {
            return UICollectionViewCell()
        }
        cell.인기셀_이미지.image = UIImage(named: "morningStar")
        cell.작성자_이미지.image = UIImage(named: "cabanel")
        cell.작성자_이름.text = "리뷰 작성자"
        cell.하트_아이콘.image = UIImage(systemName: "heart")?.withTintColor(UIColor.lightGray, renderingMode: .alwaysOriginal)
        cell.인기셀_아티스트.setTitle("알렉상드르 카나벨", for: .normal)
        cell.인기셀_전시장소.setTitle("파리 루브르 박물관", for: .normal)
        cell.인기셀_리뷰내용.text = """
        '타락한 천사’는 19세기 프랑스 화가 알렉상드르 카바넬(Alexandre Cabanel)의 작품이다. 에두아르 마네를 구심점으로 새로운 미술 운동인 인상주의가 태동하고 있을 때, 카바넬은 아카데믹한 고전주의 양식으로 작업한 제도권 미술계의 총아였다. 그는 신화와 역사, 성서 이야기를 주제로 하는 역사화, 종교화를 그렸다. 이 장르의 전통적인 테마는 성인, 천사, 영웅적인 인물이었는데, 카바넬은 ‘타락한 천사’에서 악마를 묘사해 당대 많은 논란을 일으켰다.
        """
        return cell
    }
}
