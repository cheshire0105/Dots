//
//  ViewController.swift
//  Dots
//
//  Created by cheshire on 10/23/23.
//  2023.11.9 - 목 10: 19일 최신화 푸쉬
//  2023.11.10일 금요일 10 : 18분 최신화 푸쉬
// 테스트 푸쉬
// 테스트 푸쉬 2
// 테스트 푸쉬 3
// 테스트 푸쉬 4
// 메인 서버 시작 최신화

import UIKit
import SnapKit
import SDWebImage
import Firebase
import FirebaseStorage

// 1. Section Model을 정의합니다.
struct 메인페이지_전체_전시_섹션 {
    var header: String
    var items: [String]
}



class MainExhibitionPage: UIViewController {

    var collectionViewTopConstraint: Constraint?
    let items = ["전시회", "미술관", "갤러리", "박물관", "비엔날레"]
    var exhibitions = [ExhibitionModel]()

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
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)

        collectionView.register(MainExhibitionFirstSectionCollectionCell.self, forCellWithReuseIdentifier: "MainExhibitionCollectionCell")
        collectionView.register(선별_전시_컬렉션_셀.self, forCellWithReuseIdentifier: "선별_전시_컬렉션_셀")
        collectionView.register(선별_전시_컬렉션_셀_헤더.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "선별_전시_컬렉션_셀_헤더")
        collectionView.isScrollEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()



    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        // 네비게이션 바의 아이템들을 숨깁니다.
        navigationController?.setNavigationBarHidden(true, animated: false)

        setupCollectionView()
        setupNewCollectionView()
        fetchExhibitionData()

        self.view.backgroundColor = .black

    }

    private func fetchExhibitionData() {
        let collectionRef = Firestore.firestore().collection("메인페이지_첫번째_섹션")

        collectionRef.getDocuments { [weak self] (snapshot, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print("An error occurred: \(error)")
                } else if let snapshot = snapshot {
                    self?.exhibitions = snapshot.documents.compactMap { doc -> ExhibitionModel? in
                        var data = doc.data()
                        data["셀_구성"] = doc.documentID
                        return ExhibitionModel(dictionary: data)
                    }
                    self?.MainExhibitionCollectionView.reloadData()
                }
            }
        }
    }



    private func setupCollectionView() {

        view.addSubview(CategoryCollectionView)
        CategoryCollectionView.dataSource = self
        CategoryCollectionView.delegate = self
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
                                                  heightDimension: .absolute(250))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 40, trailing: 0)

            let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(130),
                                                   heightDimension: .absolute(200))
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


    private func setupNewCollectionView() {
        view.addSubview(MainExhibitionCollectionView)
        MainExhibitionCollectionView.dataSource = self
        MainExhibitionCollectionView.delegate = self
        MainExhibitionCollectionView.snp.makeConstraints { make in
            make.top.equalTo(CategoryCollectionView.snp.bottom).offset(20)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.snp.bottom)
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
                return CGSize(width: 50, height: 130) // 두 번째 섹션의 셀 크기를 수정합니다.
            }
        }
        return CGSize.zero
    }

    func exhibitionData(forIndexPath indexPath: IndexPath) -> ExhibitionModel? {
        // 첫 번째 섹션에만 전시회 데이터가 표시되므로, 첫 번째 섹션의 인덱스 경로만 처리합니다.
        if indexPath.section == 0 {
            // indexPath.item은 배열의 인덱스로 사용됩니다.
            // exhibitions 배열의 크기를 넘어서는 인덱스에 접근하는 것을 방지합니다.
            if indexPath.item < exhibitions.count {
                return exhibitions[indexPath.item]
            }
        }
        // 다른 섹션 또는 잘못된 인덱스에 대해서는 nil을 반환합니다.
        return nil
    }

}

extension MainExhibitionPage: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let section0Height: CGFloat = 360.0 // 첫 번째 섹션의 높이

        if targetContentOffset.pointee.y < section0Height { // 첫 번째 섹션 범위 내에서 스크롤 중인 경우
            if targetContentOffset.pointee.y <= section0Height / 2 {
                targetContentOffset.pointee.y = 0 // 첫 번째 페이지로 스크롤
            } else {
                targetContentOffset.pointee.y = section0Height // 두 번째 페이지로 스크롤
            }
        }
    }
}

// CategoryCollectionView에 대한 데이터 소스 및 델리게이트 메서드
extension MainExhibitionPage: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == CategoryCollectionView {
            return items.count
        } else if collectionView == MainExhibitionCollectionView {
            return exhibitions.count
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == CategoryCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionCell", for: indexPath) as! CategotyCell
            cell.label.text = items[indexPath.item]
            return cell
        } else         if collectionView == MainExhibitionCollectionView {
            if indexPath.section == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainExhibitionCollectionCell", for: indexPath) as! MainExhibitionFirstSectionCollectionCell
                let exhibition = exhibitionData(forIndexPath: indexPath)
                cell.label.text = exhibition?.title ?? "Default Title"

                if let imageName = exhibition?.poster {
                    let storageRef = Storage.storage().reference(withPath: "images/\(imageName).png")
                    storageRef.downloadURL { (url, error) in
                        if let error = error {
                            print("Error getting download URL: \(error)")
                        } else if let url = url {
                            DispatchQueue.main.async {
                                cell.imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
                            }
                        }
                    }
                }

                cell.configureCellLayout(isEven: indexPath.row % 2 == 0)
                return cell
            } else {
                // 두 번째 및 세 번째 섹션의 셀 구성
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "선별_전시_컬렉션_셀", for: indexPath) as! 선별_전시_컬렉션_셀
                // 샘플 데이터를 이용하여 셀 구성
                cell.titleLabel.text = "올해의 전시 \(indexPath.row)"
                cell.dateLabel.text = "2023.01.01 ~ 2023.12.31"
                cell.imageView.image = UIImage(named: "placeholder") // 샘플 이미지 설정
                return cell
            }
        }
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "선별_전시_컬렉션_셀_헤더", for: indexPath) as! 선별_전시_컬렉션_셀_헤더
            // 섹션에 따른 헤더 텍스트 설정
            if indexPath.section == 1 {
                header.label.text = "추천 전시회"
            } else if indexPath.section == 2 {
                header.label.text = "인기 전시회"
            }
            return header
        }
        return UICollectionReusableView()
    }


    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4 // 두 개의 섹션이 있다고 가정
    }


    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == MainExhibitionCollectionView {
            let exhibitionPage = BackgroundImageViewController() // 예시 ViewController
            // 여기서는 예시로 새 ViewController를 푸시합니다.
            self.navigationController?.pushViewController(exhibitionPage, animated: true)
        }
        // CategoryCollectionView에 대한 선택 처리 (필요한 경우)
    }

}





