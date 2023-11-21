//
//  ViewController.swift
//  Dots
//
//  Created by cheshire on 10/23/23.
//  2023.11.9 - 목 10: 19일 최신화 푸쉬
//  2023.11.10일 금요일 10 : 18분 최신화 푸쉬
// 테스트 푸쉬
// 테스트 푸쉬 2

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import RxDataSources
import SDWebImage
import Firebase
import FirebaseStorage

// 1. Section Model을 정의합니다.
struct 메인페이지_전체_전시_섹션 {
    var header: String
    var items: [String]
}

extension 메인페이지_전체_전시_섹션: SectionModelType {
    typealias Item = String

    init(original: 메인페이지_전체_전시_섹션, items: [Item]) {
        self = original
        self.items = items
    }
}

class MainExhibitionPage: UIViewController, UICollectionViewDelegateFlowLayout {

    let disposeBag = DisposeBag()
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

//    override func viewDidAppear(_ animated: Bool) {
//        // 네비게이션 바의 아이템들을 숨깁니다.
//        navigationController?.setNavigationBarHidden(true, animated: animated)
//        if let glassTabBar = tabBarController as? GlassTabBar {
//            glassTabBar.customTabBarView.isHidden = false
//        }
//    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        // 네비게이션 바의 아이템들을 숨깁니다.
        navigationController?.setNavigationBarHidden(true, animated: false)

        setupCollectionView()
        bindCollectionView()
        setupNewCollectionView()
        fetchExhibitionData()

        self.view.backgroundColor = .black

    }

    private func fetchExhibitionData() {
           API.shared.fetchExhibitions() // 이 메소드는 RxSwift Observable을 반환해야 합니다.
               .subscribe(onNext: { [weak self] newExhibitions in
                   self?.exhibitions = newExhibitions
                   self?.updateSections() // 새로운 섹션 데이터로 업데이트합니다.
               }, onError: { error in
                   print("An error occurred: \(error)")
               }).disposed(by: disposeBag)
       }

    private func updateSections() {
         let firstSectionItems = exhibitions.map { $0.title } // 전시 타이틀을 배열로 변환합니다.
         // 나머지 섹션의 아이템도 각각 필요한 데이터로 업데이트합니다.
         // 예제 데이터로 두 번째, 세 번째, 네 번째 섹션을 설정합니다.
         let secondSectionItems = Array(repeating: "GraySquare", count: 10)
         let thirdSectionItems = Array(repeating: "GraySquare", count: 10)
         let fourthSectionItems = Array(repeating: "GraySquare", count: 10)

         let sections = [
             메인페이지_전체_전시_섹션(header: "MainExhibition", items: firstSectionItems),
             메인페이지_전체_전시_섹션(header: "GraySquare", items: secondSectionItems),
             메인페이지_전체_전시_섹션(header: "GraySquare", items: thirdSectionItems),
             메인페이지_전체_전시_섹션(header: "GraySquare", items: fourthSectionItems)
         ]

         // 데이터 소스 설정을 업데이트합니다. 여기에 이전에 정의된 dataSource를 사용합니다.
        let dataSource = RxCollectionViewSectionedReloadDataSource<메인페이지_전체_전시_섹션>(
            configureCell: { [weak self] (dataSource, collectionView, indexPath, item) -> UICollectionViewCell in
                if indexPath.section == 0 {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainExhibitionCollectionCell", for: indexPath) as! MainExhibitionFirstSectionCollectionCell
                    // 셀에 대한 전시회 데이터를 가져옵니다.
                    if let exhibition = self?.exhibitionData(forIndexPath: indexPath) {
                        // 셀에 타이틀을 서버에서 가져온 데이터로 설정합니다.
                        cell.label.text = exhibition.title // 가정한 'title'은 ExhibitionModel의 실제 제목 필드에 맞춰져야 합니다.

                        let storagePath = "images/\(exhibition.poster).png" // 전시회 모델에서 포스터 이름을 가져옵니다.
                        let storageRef = Storage.storage().reference(withPath: storagePath)
                        storageRef.downloadURL { (url, error) in
                            if let error = error {
                                print("Error getting download URL: \(error)")
                            } else if let url = url {
                                DispatchQueue.main.async {
                                    // SDWebImage를 사용하여 이미지 로드
                                    cell.imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
                                }
                            }
                        }
                    } else {
                        // 서버에서 가져온 데이터가 없을 경우, 기본 텍스트를 설정하거나 다른 처리를 할 수 있습니다.
                        cell.label.text = "Default Title or Empty State"
                    }
                    cell.contentView.clipsToBounds = true
                    cell.configureCellLayout(isEven: indexPath.row % 2 == 0)
                    return cell
                } else {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "선별_전시_컬렉션_셀", for: indexPath) as! 선별_전시_컬렉션_셀
                    // 필요한 설정을 추가할 수 있습니다.
                    return cell
                }
            },
            configureSupplementaryView: { (dataSource, collectionView, kind, indexPath) -> UICollectionReusableView in
                if kind == UICollectionView.elementKindSectionHeader {
                    let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "선별_전시_컬렉션_셀_헤더", for: indexPath) as! 선별_전시_컬렉션_셀_헤더
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
         MainExhibitionCollectionView.reloadData() // 컬렉션 뷰를 리로드합니다.

        MainExhibitionCollectionView.rx.itemSelected.subscribe(onNext: { indexPath in
            print("Selected new item at \(indexPath.row)")

            let exhibitionPage = BackgroundImageViewController()
            self.navigationController?.pushViewController(exhibitionPage, animated: true)
        }).disposed(by: disposeBag)
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




class API {
    static let shared = API() // 싱글턴 인스턴스

    private init() {} // private 초기화 방지

    func fetchExhibitions() -> Observable<[ExhibitionModel]> {
        return Observable.create { observer in
            let collectionRef = Firestore.firestore().collection("메인페이지_첫번째_섹션")

            collectionRef.getDocuments { (snapshot, error) in
                if let error = error {
                    observer.onError(error)
                } else if let snapshot = snapshot {
                    let exhibitions = snapshot.documents.compactMap { doc -> ExhibitionModel? in
                        var data = doc.data()
                        print("Document ID: \(doc.documentID), Data: \(data)") // 콘솔에 출력
                        data["셀_구성"] = doc.documentID
                        return ExhibitionModel(dictionary: data)
                    }
                    observer.onNext(exhibitions)
                    observer.onCompleted()
                }
            }
            return Disposables.create()
        }
    }

    func downloadImage(withPath imagePath: String, completion: @escaping (UIImage?) -> Void) {
        // Firebase Storage의 참조를 얻습니다.
        let storageRef = Storage.storage().reference(withPath: imagePath)

        // 이미지를 메모리로 직접 다운로드합니다.
        storageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print("Error downloading image: \(error)")
                completion(nil)
            } else if let data = data, let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }
    }
}
