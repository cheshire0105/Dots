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

    // 새로운 컬렉션뷰를 정의합니다.
     lazy var newCollectionView: UICollectionView = {
         let flowLayout = UICollectionViewFlowLayout()
         flowLayout.scrollDirection = .horizontal
         flowLayout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
         flowLayout.minimumInteritemSpacing = 8
         let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
         collectionView.backgroundColor = .black
         collectionView.showsHorizontalScrollIndicator = false
         collectionView.register(NewCell.self, forCellWithReuseIdentifier: "newCell")
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
            .bind(to: CategoryCollectionView.rx.items(cellIdentifier: "customCell", cellType: CategotyCell.self)) { (row, text, cell) in
                cell.label.text = text
                cell.contentView.clipsToBounds = true
            }.disposed(by: disposeBag)

        CategoryCollectionView.rx.itemSelected.subscribe(onNext: { indexPath in
            print("Selected item at \(indexPath.row)")
        }).disposed(by: disposeBag)

        CategoryCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }

    private func setupNewCollectionView() {
          view.addSubview(newCollectionView)
          newCollectionView.snp.makeConstraints { make in
              make.top.equalTo(CategoryCollectionView.snp.bottom).offset(20)
              make.left.right.equalToSuperview().offset(6)
              make.height.equalTo(380)
          }
      }

    private func bindNewCollectionView() {
        // 예제 데이터
        let newItems = Array(repeating: "리암 길릭: \n The Alterants", count: 10)

        Observable.just(newItems)
            .bind(to: newCollectionView.rx.items(cellIdentifier: "newCell", cellType: NewCell.self)) { (row, text, cell) in
                cell.label.text = text
                cell.contentView.clipsToBounds = true
                cell.setImage(image: UIImage(named: "Rectangle")) // 각 셀에 이미지 설정
            }.disposed(by: disposeBag)

        newCollectionView.rx.itemSelected.subscribe(onNext: { indexPath in
            print("Selected new item at \(indexPath.row)")
        }).disposed(by: disposeBag)

        newCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }


    // 기존의 sizeForItemAt 메소드를 수정하여, 새로운 컬렉션뷰의 사이즈도 설정해줍니다.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == CategoryCollectionView {
            return CGSize(width: 73, height: 34)
        } else if collectionView == newCollectionView {
            return CGSize(width: UIScreen.main.bounds.width, height: 360) // 화면의 가로길이에서 40포인트를 뺀 값을 셀의 가로길이로 설정
        }
        return CGSize.zero
    }

}

// 새로운 셀 클래스를 정의합니다.
class NewCell: UICollectionViewCell {
    var label: UILabel!
    var imageView: UIImageView! // 이미지 뷰를 추가

    override init(frame: CGRect) {
        super.init(frame: frame)

//        contentView.backgroundColor = .gray // 셀의 배경색을 회색으로 설정

        // 이미지 뷰를 설정
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)

        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview() // 이미지를 셀의 왼쪽에 붙입니다.
            make.width.equalTo(200)
            make.height.equalTo(370)
        }

        label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30)
        label.numberOfLines = 0  // 여러 줄의 텍스트를 표시하도록 설정
        label.textColor = .white
        label.textAlignment = .left
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.centerY).offset(10)
            make.right.equalToSuperview().inset(10)
            make.width.equalTo(270)
            make.height.equalTo(100)
        }



    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // 이미지를 설정하는 메소드를 추가
    func setImage(image: UIImage?) {
        imageView.image = image
    }
}


