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
        collectionView.register(GraySquareCell.self, forCellWithReuseIdentifier: "GraySquareCell")
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "sectionHeader") // 여기를 수정했습니다.
        
        collectionView.isScrollEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        // 네비게이션 바의 아이템들을 숨깁니다.
        navigationController?.setNavigationBarHidden(true, animated: animated)
        if let glassTabBar = tabBarController as? GlassTabBar {
            glassTabBar.customTabBarView.isHidden = false
        }
    }
    
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
        bindNewCollectionView()
        
        
        self.view.backgroundColor = .black

        // `fetchExhibitions()` 함수를 구독하고 결과를 처리합니다.
        fetchExhibitions()
            .subscribe(onNext: { [weak self] exhibitions in
                self?.exhibitions = exhibitions // 데이터를 클래스 프로퍼티에 저장합니다.
                print(exhibitions)
                self?.MainExhibitionCollectionView.reloadData() // 컬렉션뷰를 리로드합니다.
            }, onError: { error in
                print("An error occurred: \(error)")
            }, onCompleted: {
                print("Fetch completed.")
            })
            .disposed(by: disposeBag)



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
            configureCell: { [weak self] (dataSource, collectionView, indexPath, item) -> UICollectionViewCell in
                if indexPath.section == 0 {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainExhibitionCollectionCell", for: indexPath) as! MainExhibitionFirstSectionCollectionCell
                    cell.label.text = item
                    cell.contentView.clipsToBounds = true

                    // 셀에 대한 전시회 데이터를 가져옵니다
                    // 셀에 대한 전시회 데이터를 가져옵니다.
                    if let exhibition = self?.exhibitionData(forIndexPath: indexPath) {
                        // exhibition.poster가 파일명이라고 가정합니다.
                        let imagePath = "images/서울_전시_1.png" // 예: "images/my_image.jpg"
                        self?.downloadImage(withPath: imagePath) { image in
                            DispatchQueue.main.async { // UI 업데이트는 메인 스레드에서 실행합니다.
                                cell.setImage(image: image) // 셀에 이미지를 설정하는 메소드
                            }
                        }
                    }

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
            
            let exhibitionPage = ExhibitionPage()
            self.navigationController?.pushViewController(exhibitionPage, animated: true)
        }).disposed(by: disposeBag)
        
        MainExhibitionCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        // 페이징 효과 적용
        //        MainExhibitionCollectionView.isPagingEnabled = true
        
        // UICollectionViewFlowLayout의 minimumLineSpacing을 조절
        if let flowLayout = MainExhibitionCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.minimumLineSpacing = 0
        }
    }
    
    private func adjustCellLayoutForEvenItems(cell: MainExhibitionFirstSectionCollectionCell, indexPath: IndexPath) {
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
                return CGSize(width: 50, height: 130) // 두 번째 섹션의 셀 크기를 수정합니다.
            }
        }
        return CGSize.zero
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
        // 첫 번째 섹션 외의 다른 섹션은 페이징 효과 없이 정상적으로 스크롤됩니다.
    }
}


class GraySquareCell: UICollectionViewCell {

    var imageView: UIImageView!
    var titleLabel: UILabel!
    var dateLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)

        imageView = UIImageView()
        titleLabel = UILabel()
        dateLabel = UILabel()

        // SnapKit을 사용해 이미지 뷰를 추가합니다.
        imageView.backgroundColor = .gray
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(imageView.snp.width) // 가로 세로 비율 1:1로 설정
        }

        // 타이틀 레이블 설정
        titleLabel.font = .boldSystemFont(ofSize: 16)
        titleLabel.text = "올해의 전시"
        titleLabel.textColor = .white
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(10)
        }

        // 날짜 레이블 설정
        dateLabel.font = .systemFont(ofSize: 14)
        dateLabel.text = "2023. 12. 34 ~ 2024. 12. 34"
        dateLabel.textColor = .lightGray
        contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.lessThanOrEqualToSuperview().offset(-10)
        }
    }

    required init?(coder aDecoder: NSCoder) {
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

import Foundation

// 전시회 정보를 나타내는 모델
struct ExhibitionModel {
    var documentID: String    // Firestore에서 자동 생성된 문서 ID
    var museumName: String    // 미술관 이름
    var price: String         // 전시 가격
    var summary: String       // 전시 개요
    var duration: String      // 전시 기간
    var location: String      // 전시 장소
    var title: String         // 전시 제목
    var poster: String        // 전시 포스터의 URL

    // 딕셔너리에서 모델 인스턴스를 생성하기 위한 이니셜라이저.
    // Firestore에서 가져온 데이터를 이용해 초기화한다.
    init?(dictionary: [String: Any]) {
        guard let documentID = dictionary["서울_전시_1"] as? String, // 문서 ID 확인
              let museumName = dictionary["미술관_이름"] as? String, // 미술관 이름 확인
              let price = dictionary["전시_가격"] as? String, // 전시 가격 확인
              let summary = dictionary["전시_개요"] as? String, // 전시 개요 확인
              let duration = dictionary["전시_기간"] as? String, // 전시 기간 확인
              let location = dictionary["전시_장소"] as? String, // 전시 장소 확인
              let title = dictionary["전시_제목"] as? String, // 전시 제목 확인
              let poster = dictionary["전시_포스터"] as? String else { // 전시 포스터 URL 확인
            return nil // 하나라도 누락되면 nil을 반환하여 초기화 실패 처리
        }

        // 모든 값이 제대로 있으면 초기화를 진행한다.
        self.documentID = documentID
        self.museumName = museumName
        self.price = price
        self.summary = summary
        self.duration = duration
        self.location = location
        self.title = title
        self.poster = poster
    }
}

import FirebaseFirestore
import RxSwift
import FirebaseStorage

// Firestore에서 전시회 데이터를 가져와서 ExhibitionModel 배열로 변환하는 함수
func fetchExhibitions() -> Observable<[ExhibitionModel]> {
    // RxSwift의 Observable을 생성하여 비동기 작업을 관리한다.
    return Observable.create { observer in
        
        // Firestore의 'exhibitions' 컬렉션에 대한 참조를 생성한다.
        let collectionRef = Firestore.firestore().collection("전시")

        // 컬렉션에서 문서 스냅샷을 비동기적으로 가져온다.
        collectionRef.getDocuments { (snapshot, error) in
            if let error = error {
                // 에러가 발생하면 Observable에 에러를 방출한다.
                observer.onError(error)
            } else if let snapshot = snapshot {
                // 스냅샷에서 문서들을 가져와 ExhibitionModel로 매핑한다.
                let exhibitions = snapshot.documents.compactMap { doc -> ExhibitionModel? in
                    var data = doc.data() // 문서의 데이터를 가져온다.
                    data["서울_전시_1"] = doc.documentID // 문서의 ID를 데이터에 추가한다.
                    return ExhibitionModel(dictionary: data) // 데이터를 이용해 모델을 생성한다.
                }
                observer.onNext(exhibitions) // 생성된 모델 배열을 Observable에 방출한다.
                observer.onCompleted() // 작업이 완료되었음을 알린다.
            }
        }

        // Observable이 해제될 때 실행될 정리(clean-up) 작업을 설정한다.
        return Disposables.create()
    }
}
