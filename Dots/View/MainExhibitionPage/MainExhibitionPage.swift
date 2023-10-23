//
//  ViewController.swift
//  Dots
//
//  Created by cheshire on 10/23/23.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import CollectionViewPagingLayout

class MainExhibitionPage: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    let disposeBag = DisposeBag()
    var collectionViewTopConstraint: Constraint?
    var cardCollectionView: UICollectionView!

    let items = ["전시회", "미술관", "갤러리", "박물관", "비엔날레"]

    lazy var CategoryCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        flowLayout.minimumInteritemSpacing = 8
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .black
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(CategotyCell.self, forCellWithReuseIdentifier: "customCell")
        collectionView.isScrollEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        bindCollectionView()
        setupCardCollectionView()
    }

    private func setupCollectionView() {
        view.addSubview(CategoryCollectionView)
        CategoryCollectionView.snp.makeConstraints { make in
            collectionViewTopConstraint = make.top.equalTo(view.safeAreaLayoutGuide.snp.top).constraint.update(offset: 16)
            make.left.right.equalToSuperview().offset(16)
            make.height.equalTo(40)
        }
    }

    private func bindCollectionView() {
        Observable.just(items)
            .bind(to: CategoryCollectionView.rx.items(cellIdentifier: "customCell", cellType: CategotyCell.self)) { (row, text, cell) in
                cell.label.text = text
                cell.contentView.clipsToBounds = true
            }.disposed(by: disposeBag)

        CategoryCollectionView.rx.itemSelected.subscribe(onNext: { indexPath in
            print("Selected item at \(indexPath.row)")
        }).disposed(by: disposeBag)

        CategoryCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }

    private func setupCardCollectionView() {
        let layout = CollectionViewPagingLayout()
        cardCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cardCollectionView.isPagingEnabled = true
        cardCollectionView.backgroundColor = .white
        cardCollectionView.dataSource = self
        cardCollectionView.bounces = false


        cardCollectionView.register(MainCell.self, forCellWithReuseIdentifier: "PagingCell")
        view.addSubview(cardCollectionView)

        cardCollectionView.snp.makeConstraints { make in
            make.top.equalTo(CategoryCollectionView.snp.bottom).offset(10)
            make.left.equalToSuperview()  // 왼쪽 끝으로 설정
            make.right.equalToSuperview() // 오른쪽 끝으로 설정
            make.height.equalTo(400) // 세로 450으로 설정
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 73, height: 34)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == cardCollectionView {
            return 10 // 예제를 위해 임의의 숫자 10을 반환합니다.
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == cardCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PagingCell", for: indexPath) as! MainCell
            cell.label.text = "Page \(indexPath.row + 1)"
            return cell
        }
        return UICollectionViewCell() // 일반적으로 여기에 도달해서는 안 됩니다.
    }

}

class MainCell: UICollectionViewCell {

    var label: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
    }

    private func setupCell() {
        self.backgroundColor = .orange

        label = UILabel()
        label.textAlignment = .center
        self.addSubview(label)

        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
