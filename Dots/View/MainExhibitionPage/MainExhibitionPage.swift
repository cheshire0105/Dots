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
import RxDataSources

// 1. Section Model을 정의합니다.
struct SectionItem {
    var header: String
    var items: [String]
}

extension SectionItem: SectionModelType {
    typealias Item = String

    init(original: SectionItem, items: [Item]) {
        self = original
        self.items = items
    }
}


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
    // MainExhibitionCollectionView 초기화 부분에서 레이아웃 설정 변경
    lazy var MainExhibitionCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .black
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(MainExhibitionCollectionCell.self, forCellWithReuseIdentifier: "MainExhibitionCollectionCell")
        collectionView.register(GraySquareCell.self, forCellWithReuseIdentifier: "GraySquareCell")
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "sectionHeader") // 여기를 수정했습니다.

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

        MainExhibitionCollectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)


    }

    private func setupCollectionView() {
        view.addSubview(CategoryCollectionView)
        CategoryCollectionView.snp.makeConstraints { make in
            collectionViewTopConstraint = make.top.equalTo(view.safeAreaLayoutGuide.snp.top).constraint.update(offset: 16)
            make.left.right.equalToSuperview().offset(6)
            make.height.equalTo(40)
        }
    }

    // 컴포지셔널 레이아웃을 생성하는 메소드
    let layout = UICollectionViewCompositionalLayout { (sectionIndex, environment) -> NSCollectionLayoutSection? in
        if sectionIndex == 0 {
            // Main Exhibition Item
            let mainExhibitionItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                heightDimension: .absolute(360)) // MainExhibitionCollectionCell의 높이
            let mainExhibitionItem = NSCollectionLayoutItem(layoutSize: mainExhibitionItemSize)

            // Main Exhibition Group
            let mainExhibitionGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                 heightDimension: .absolute(360))
            let mainExhibitionGroup = NSCollectionLayoutGroup.horizontal(layoutSize: mainExhibitionGroupSize, subitems: [mainExhibitionItem])

            // Main Exhibition Section
            let section = NSCollectionLayoutSection(group: mainExhibitionGroup)
            section.orthogonalScrollingBehavior = .groupPaging // 여기에서 가로 스크롤을 설정합니다.
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0) // 첫 번째 섹션의 아래 간격을 10으로 설정

            return section // 이 부분이 누락되어 있었습니다.

        }else {
            // Second section (Gray Square Cells)

            let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(130),
                                                  heightDimension: .absolute(155))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0)

            let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(130),
                                                   heightDimension: .absolute(155))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

            let section = NSCollectionLayoutSection(group: group)

            // 섹션을 생성한 후에 헤더를 설정합니다.
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            section.boundarySupplementaryItems = [header]
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0)

            section.interGroupSpacing = 16
            section.orthogonalScrollingBehavior = .continuous

            return section
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
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.snp.bottom)
        }
    }


    private func bindNewCollectionView() {
        // 예제 데이터
        let firstSectionItems = Array(repeating: "리암 길릭: \n The Alterants", count: 10)
        let secondSectionItems = Array(repeating: "GraySquare", count: 10)
        let thirdSectionItems = Array(repeating: "GraySquare", count: 10) // 세 번째 섹션 데이터
        let tirthSectionItems = Array(repeating: "GraySquare", count: 10) // 네 번째 섹션 데이터

        let sections = [
            SectionItem(header: "MainExhibition", items: firstSectionItems),
            SectionItem(header: "GraySquare", items: secondSectionItems),
            SectionItem(header: "GraySquare", items: thirdSectionItems), // 세 번째 섹션 추가
            SectionItem(header: "GraySquare", items: tirthSectionItems) // 세 번째 섹션 추가

        ]


        // 2. 데이터 소스를 설정합니다.
        let dataSource = RxCollectionViewSectionedReloadDataSource<SectionItem>(
            configureCell: { (dataSource, collectionView, indexPath, item) -> UICollectionViewCell in
                if indexPath.section == 0 {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainExhibitionCollectionCell", for: indexPath) as! MainExhibitionCollectionCell
                    cell.label.text = item
                    cell.contentView.clipsToBounds = true
                    cell.setImage(image: UIImage(named: "Rectangle"))
                    self.adjustCellLayoutForEvenItems(cell: cell, indexPath: indexPath)
                    return cell
                } else {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GraySquareCell", for: indexPath) as! GraySquareCell
                    // 필요한 설정을 추가할 수 있습니다.
                    return cell
                }
            },
            configureSupplementaryView: { (dataSource, collectionView, kind, indexPath) -> UICollectionReusableView in
                if kind == UICollectionView.elementKindSectionHeader {
                    let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "sectionHeader", for: indexPath) as! SectionHeader
                    if indexPath.section == 1 {
                        header.label.text = "용인 근처의 전시"
                    } else if indexPath.section == 2 {
                        header.label.text = "도트 님의 취향 저격 콘텐츠"
                    } else if indexPath.section == 3 {
                        header.label.text = "도트 님의 가까운 전시"
                    }
                    return header
                }
                return UICollectionReusableView()


            }


        )

        Observable.just(sections)
            .bind(to: MainExhibitionCollectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

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
                make.top.equalTo(cell.imageView.snp.centerY).offset(-80)
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
            if indexPath.section == 0 {
                return CGSize(width: UIScreen.main.bounds.width, height: 360) // 첫 번째 섹션의 셀 크기
            } else if indexPath.section == 1 {
                return CGSize(width: 50, height: 100) // 두 번째 섹션의 셀 크기
            }
        }
        return CGSize.zero
    }

}

class GraySquareCell: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .gray // 회색 배경 설정

        // 추가적인 UI 구성이나 데이터 바인딩이 필요하다면 여기에 작성하시면 됩니다.
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SectionHeader: UICollectionReusableView {
    let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)

        // 폰트 사이즈와 스타일 설정
        label.font = UIFont.boldSystemFont(ofSize: 20) // 여기에서 폰트 사이즈와 스타일을 조정합니다.

        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .left
        label.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true // 왼쪽 정렬
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

