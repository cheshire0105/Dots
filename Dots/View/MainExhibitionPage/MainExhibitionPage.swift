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

class MainExhibitionPage: UIViewController, UICollectionViewDelegateFlowLayout {

    let disposeBag = DisposeBag()
    var collectionViewTopConstraint: Constraint?

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

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 73, height: 34)
    }
}

// 새로운 시작!
