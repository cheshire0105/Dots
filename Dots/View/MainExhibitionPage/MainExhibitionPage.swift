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
        collectionView.register(CategotyCell.self, forCellWithReuseIdentifier: "CategoryCollectionCell")
        collectionView.isScrollEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()

    // 새로운 컬렉션뷰를 정의합니다.
     lazy var MainExhibitionCollectionView: UICollectionView = {
         let flowLayout = UICollectionViewFlowLayout()
         flowLayout.scrollDirection = .horizontal
         flowLayout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
         flowLayout.minimumInteritemSpacing = 8
         let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
         collectionView.backgroundColor = .black
         collectionView.showsHorizontalScrollIndicator = false
         collectionView.register(MainExhibitionCollectionCell.self, forCellWithReuseIdentifier: "MainExhibitionCollectionCell")
         collectionView.isScrollEnabled = true
         collectionView.showsVerticalScrollIndicator = false
         return collectionView
     }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        bindCollectionView()

        setupNewCollectionView()
        bindNewCollectionView()

        
    }

    private func setupCollectionView() {
        view.addSubview(CategoryCollectionView)
        CategoryCollectionView.snp.makeConstraints { make in
            collectionViewTopConstraint = make.top.equalTo(view.safeAreaLayoutGuide.snp.top).constraint.update(offset: 16)
            make.left.right.equalToSuperview().offset(6)
            make.height.equalTo(40)
        }
    }

    private func bindCollectionView() {
        Observable.just(items)
            .bind(to: CategoryCollectionView.rx.items(cellIdentifier: "CategoryCollectionCell", cellType: CategotyCell.self)) { (row, text, cell) in
                cell.label.text = text
                cell.contentView.clipsToBounds = true
            }.disposed(by: disposeBag)

        CategoryCollectionView.rx.itemSelected.subscribe(onNext: { indexPath in
            print("Selected item at \(indexPath.row)")
        }).disposed(by: disposeBag)

        CategoryCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }

    private func setupNewCollectionView() {
          view.addSubview(MainExhibitionCollectionView)
          MainExhibitionCollectionView.snp.makeConstraints { make in
              make.top.equalTo(CategoryCollectionView.snp.bottom).offset(20)
              make.left.right.equalToSuperview().offset(6)
              make.height.equalTo(380)
          }
      }

    private func bindNewCollectionView() {
        // 예제 데이터
        let newItems = Array(repeating: "리암 길릭: \n The Alterants", count: 10)

        Observable.just(newItems)
            .bind(to: MainExhibitionCollectionView.rx.items(cellIdentifier: "MainExhibitionCollectionCell", cellType: MainExhibitionCollectionCell.self)) { (row, text, cell) in
                cell.label.text = text
                cell.contentView.clipsToBounds = true
                cell.setImage(image: UIImage(named: "Rectangle")) // 각 셀에 이미지 설정
                self.adjustCellLayoutForEvenItems(cell: cell, indexPath: IndexPath(row: row, section: 0))
            }.disposed(by: disposeBag)


        MainExhibitionCollectionView.rx.itemSelected.subscribe(onNext: { indexPath in
            print("Selected new item at \(indexPath.row)")
        }).disposed(by: disposeBag)

        MainExhibitionCollectionView.rx.setDelegate(self).disposed(by: disposeBag)

        // 페이징 효과 적용
        MainExhibitionCollectionView.isPagingEnabled = true

        // UICollectionViewFlowLayout의 minimumLineSpacing을 조절
        if let flowLayout = MainExhibitionCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.minimumLineSpacing = 0
        }
    }

    private func adjustCellLayoutForEvenItems(cell: MainExhibitionCollectionCell, indexPath: IndexPath) {
        if indexPath.row % 2 == 0 { // 짝수 번째 셀인 경우
            // 이미지를 오른쪽으로 이동
            cell.imageView.snp.remakeConstraints { make in
                make.top.equalToSuperview()
                make.right.equalToSuperview()
                make.width.equalTo(200)
                make.height.equalTo(370)
            }

            cell.label.snp.remakeConstraints { make in
                make.top.equalTo(cell.imageView.snp.centerY).offset(10)
                make.left.equalToSuperview()
                make.height.equalTo(100)
            }
            cell.label.textAlignment = .left  

        } else {
            // 홀수 번째 셀의 기본 레이아웃
            cell.imageView.snp.remakeConstraints { make in
                make.top.equalToSuperview()
                make.left.equalToSuperview()
                make.width.equalTo(200)
                make.height.equalTo(370)
            }

            cell.label.snp.remakeConstraints { make in
                make.top.equalTo(cell.imageView.snp.centerY).offset(-30)
                make.right.equalToSuperview()
                make.height.equalTo(100)
            }
            cell.label.textAlignment = .right
        }
    }






    // 기존의 sizeForItemAt 메소드를 수정하여, 새로운 컬렉션뷰의 사이즈도 설정해줍니다.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == CategoryCollectionView {
            return CGSize(width: 73, height: 34)
        } else if collectionView == MainExhibitionCollectionView {
            return CGSize(width: UIScreen.main.bounds.width, height: 360) // 화면의 가로길이를 셀의 가로길이로 설정
        }
        return CGSize.zero
    }


}

