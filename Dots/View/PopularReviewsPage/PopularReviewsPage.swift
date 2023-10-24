// 인기후기페이지 뷰컨트롤러
import SnapKit
import UIKit

class PopularReviewsPage: UIViewController {
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
        button.setTitleColor(UIColor.blue, for: .normal)
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
        button.setTitleColor(UIColor.blue, for: .normal)
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
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .black
        collectionView.layer.cornerRadius = 10
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        ui레이아웃()
        인기_컬렉션_뷰.dataSource = self
        인기_컬렉션_뷰.delegate = self
        인기_컬렉션_뷰.register(PopularReviewCell.self, forCellWithReuseIdentifier: "PopulaReviewCell")
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
            make.width.equalTo(50)
            make.height.equalTo(22)
            make.bottom.equalTo(인기_컬렉션_뷰.snp.top).offset(-5)
            make.trailing.equalTo(구분선.snp.leading).offset(-2)
        }
        구분선.snp.makeConstraints { make in
            make.width.equalTo(10)
            make.height.equalTo(22)
            make.bottom.equalTo(인기_컬렉션_뷰.snp.top).offset(-5)
            make.trailing.equalTo(추천순_버튼.snp.leading).offset(2)
        }
        추천순_버튼.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.height.equalTo(22)
            make.top.equalTo(인기순_버튼)
            make.bottom.equalTo(인기_컬렉션_뷰.snp.top).offset(-5)
            make.trailing.equalTo(인기_컬렉션_뷰)
            make.centerY.equalTo(인기순_버튼)
        }
        반투명_선택_풍선.snp.makeConstraints { make in
            make.width.equalTo(60)
            make.height.equalTo(25)
        }
        인기_컬렉션_뷰.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(300)
            make.top.equalToSuperview().offset(130)
            make.bottom.equalToSuperview().offset(-130)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
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
        cell.작성자_이미지.image = UIImage(named: "cabanel")
        cell.작성자_이름.text = "리뷰 작성자"
        cell.하트_아이콘.image = UIImage(systemName: "heart")?.withTintColor(UIColor.lightGray, renderingMode: .alwaysOriginal)
        cell.인기셀_아티스트.setTitle("알렉상드르 카바넬", for: .normal)
        cell.인기셀_전시장소.setTitle("파리 루브르 박물관", for: .normal)
        cell.인기셀_리뷰내용.text = """
        '타락한 천사’는 19세기 프랑스 화가 알렉상드르 카바넬(Alexandre Cabanel)의 작품이다. 에두아르 마네를 구심점으로 새로운 미술 운동인 인상주의가 태동하고 있을 때, 카바넬은 아카데믹한 고전주의 양식으로 작업한 제도권 미술계의 총아였다. 그는 신화와 역사, 성서 이야기를 주제로 하는 역사화, 종교화를 그렸다. 이 장르의 전통적인 테마는 성인, 천사, 영웅적인 인물이었는데, 카바넬은 ‘타락한 천사’에서 악마를 묘사해 당대 많은 논란을 일으켰다.
        """
        let 최대_글자수 = 150
        if let text = cell.인기셀_리뷰내용.text, text.count > 최대_글자수 {
            let 글자수_줄이기 = String(text.prefix(최대_글자수)) + "..."
            cell.인기셀_리뷰내용.text = 글자수_줄이기
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width * 1
        let height = width * 1.55

        return CGSize(width: width, height: height)
    }
}
