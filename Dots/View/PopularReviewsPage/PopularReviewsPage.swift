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

    let 인기순_추천순_버튼 = {
        let button = UIButton()
        button.setTitle("인기순 | 추천순", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        return button
    }()

    let 인기_컬렉션_뷰: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 345, height: 645)
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
        ui레이아웃()
        인기_컬렉션_뷰.register(CustomCell.self, forCellWithReuseIdentifier: "PopulaReviewCell")
        view.backgroundColor = UIColor.black
        인기_컬렉션_뷰.dataSource = self
        인기_컬렉션_뷰.delegate = self
    }
}

extension PopularReviewsPage {
    func ui레이아웃() {
        view.addSubview(페이지_제목)
        view.addSubview(인기순_추천순_버튼)
        view.addSubview(인기_컬렉션_뷰)
        페이지_제목.snp.makeConstraints { make in
            make.width.equalTo(42)
            make.height.equalTo(22)
            make.top.equalToSuperview().offset(68)
            make.bottom.equalToSuperview().offset(-762)
            make.leading.equalToSuperview().offset(175)
            make.trailing.equalToSuperview().offset(-176)
        }

        인기순_추천순_버튼.snp.makeConstraints { make in
            make.width.equalTo(103)
            make.height.equalTo(22)
            make.top.equalToSuperview().offset(104)
            make.bottom.equalToSuperview().offset(-726)
            make.leading.equalToSuperview().offset(274)
            make.trailing.equalToSuperview().offset(-16)
        }
        인기_컬렉션_뷰.snp.makeConstraints { make in
            make.width.equalTo(345)
            make.height.equalTo(645)
            make.top.equalTo(페이지_제목.snp.bottom).offset(75)
            make.bottom.equalToSuperview().offset(-42)
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
        cell.하트_아이콘.image = UIImage(systemName: "heart")
        return cell
    }
}
