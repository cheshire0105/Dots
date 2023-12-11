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
// 최신화
// 최신화
// 최신화

import UIKit
import SnapKit
import SDWebImage
import Firebase
import FirebaseStorage
import SkeletonView

// 1. Section Model을 정의합니다.
struct 메인페이지_전체_전시_섹션 {
    var header: String
    var items: [String]
}



class MainExhibitionPage: UIViewController {
    
    var collectionViewTopConstraint: Constraint?
    var exhibitions = [ExhibitionModel]()
    var secondSectionExhibitions = [ExhibitionModel]()
    var thirdSectionExhibitions = [ExhibitionModel]()

    
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
        navigationController?.setNavigationBarHidden(false, animated: animated)

    }

    override func viewDidAppear(_ animated: Bool) {

    }

  

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupCollectionView()
        setupNewCollectionView()
        fetchExhibitionData()
        fetchAdditionalExhibitionData()
        self.view.backgroundColor = .black
        
        if let 현제접속중인_유저 = Auth.auth().currentUser {
            print("로그인한 사용자 정보:")
            print("UID: \(현제접속중인_유저.uid)")
            print("이메일: \(현제접속중인_유저.email ?? "없음")")
            print("계정이 로그인되었습니다.")
        }
        
    }

    func setupNavigationBar() {
        // 네비게이션 타이틀 설정
        self.navigationItem.title = "Dots"
        // 네비게이션 바 배경색과 타이틀 색상 설정
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .black // 배경색을 검은색으로 설정
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white] // 타이틀을 하얀색으로 설정
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white] // 대형 타이틀도 하얀색으로 설정


        // iOS 15 이상에서는 아래 설정도 필요할 수 있습니다.
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.standardAppearance = appearance

        // 네비게이션 바 대형 타이틀 설정
        navigationController?.navigationBar.prefersLargeTitles = true // 대형 타이틀 활성화
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
    
    private func fetchAdditionalExhibitionData() {
        Firestore.firestore().collection("메인페이지_두번째_섹션").getDocuments { [weak self] (snapshot, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print("An error occurred: \(error)")
                } else if let snapshot = snapshot {
                    self?.secondSectionExhibitions = snapshot.documents.compactMap { doc -> ExhibitionModel? in
                        var data = doc.data()
                        data["셀_구성"] = doc.documentID
                        return ExhibitionModel(dictionary: data)
                    }
                    self?.MainExhibitionCollectionView.reloadData()
                }
            }
        }
        
        // 세 번째 섹션 데이터 로드 로직
        Firestore.firestore().collection("메인페이지_세번째_섹션").getDocuments { [weak self] (snapshot, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error loading third section data: \(error)")
                } else if let snapshot = snapshot {
                    self?.thirdSectionExhibitions = snapshot.documents.compactMap { doc -> ExhibitionModel? in
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
                                                  heightDimension: .absolute(300))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 40, trailing: 0)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(130),
                                                   heightDimension: .absolute(250))
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
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.snp.bottom)
        }
    }
    
    // 기존의 sizeForItemAt 메소드를 수정하여, 새로운 컬렉션뷰의 사이즈도 설정해줍니다.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == MainExhibitionCollectionView {
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

        if collectionView == MainExhibitionCollectionView {
            if section == 0 {
                return exhibitions.count
            } else if section == 1 {
                return secondSectionExhibitions.count
            } else if section == 2 {
                return thirdSectionExhibitions.count
            }
            // 세 번째 섹션에 대한 아이템 수를 반환해야 합니다 (예: thirdSectionExhibitions.count)
        }
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if collectionView == MainExhibitionCollectionView {
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
                                        cell.imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"), completed: { (image, error, cacheType, url) in
                                            if cacheType == .none {
                                                print("Image was downloaded and cached: \(url?.absoluteString ?? "Unknown URL")")
                                            } else {
                                                print("Image was retrieved from cache")
                                            }
                                        })
                                    }
                                }
                            }
                        }

                cell.configureCellLayout(isEven: indexPath.row % 2 == 0)
                return cell
            }
            
            else if indexPath.section == 1 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "선별_전시_컬렉션_셀", for: indexPath) as! 선별_전시_컬렉션_셀
                let exhibition = secondSectionExhibitions[indexPath.item]
                cell.titleLabel.text = exhibition.title
                cell.dateLabel.text = exhibition.period

                let imageName = exhibition.poster
                let storageRef = Storage.storage().reference(withPath: "images/\(imageName).png")
                storageRef.downloadURL { (url, error) in
                    if let error = error {
                        print("Error getting download URL: \(error)")
                    } else if let url = url {
                        DispatchQueue.main.async {
                            cell.imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"), completed: { (image, error, cacheType, url) in
                                if cacheType == .none {
                                    print("Section 1 Image was downloaded and cached: \(url?.absoluteString ?? "Unknown URL")")
                                } else {
                                    print("Section 1 Image was retrieved from cache")
                                }
                            })
                        }
                    }
                }

                return cell
            }

            
            else if indexPath.section == 2 {
                if indexPath.item < thirdSectionExhibitions.count {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "선별_전시_컬렉션_셀", for: indexPath) as! 선별_전시_컬렉션_셀
                    let exhibition = thirdSectionExhibitions[indexPath.item]
                    cell.titleLabel.text = exhibition.title
                    cell.dateLabel.text = exhibition.period

                    let imageName = exhibition.poster
                    let storageRef = Storage.storage().reference(withPath: "images/\(imageName).png")
                    storageRef.downloadURL { (url, error) in
                        if let error = error {
                            print("Error getting download URL: \(error)")
                        } else if let url = url {
                            DispatchQueue.main.async {
                                cell.imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"), completed: { (image, error, cacheType, url) in
                                    if cacheType == .none {
                                        print("Section 2 Image was downloaded and cached: \(url?.absoluteString ?? "Unknown URL")")
                                    } else {
                                        print("Section 2 Image was retrieved from cache")
                                    }
                                })
                            }
                        }
                    }
                    return cell
                }
            }

            
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "선별_전시_컬렉션_셀_헤더", for: indexPath) as! 선별_전시_컬렉션_셀_헤더
            // 섹션에 따른 헤더 텍스트 설정
            if indexPath.section == 1 {
                header.label.text = "서울의 전시"
            } else if indexPath.section == 2 {
                header.label.text = "가장 많이 찾는 전시"
            }
            return header
        }
        return UICollectionReusableView()
    }
    
    
    // 이 메서드는 각 컬렉션 뷰에 대한 섹션의 수를 정의합니다.
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == MainExhibitionCollectionView {
            // MainExhibitionCollectionView의 경우 3개의 섹션
            return 3
        }
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == MainExhibitionCollectionView {
            let exhibitionPage = BackgroundImageViewController()
            exhibitionPage.hidesBottomBarWhenPushed = true // 탭 바 숨기기

            var selectedExhibition: ExhibitionModel?
            if indexPath.section == 0 {
                selectedExhibition = exhibitions.count > indexPath.item ? exhibitions[indexPath.item] : nil
            } else if indexPath.section == 1 {
                selectedExhibition = secondSectionExhibitions.count > indexPath.item ? secondSectionExhibitions[indexPath.item] : nil
            } else if indexPath.section == 2 {
                selectedExhibition = thirdSectionExhibitions.count > indexPath.item ? thirdSectionExhibitions[indexPath.item] : nil
            }
            
            if let selectedExhibition = selectedExhibition {
                exhibitionPage.posterImageName = selectedExhibition.poster
                exhibitionPage.titleName = selectedExhibition.title 

            }
            
            self.navigationController?.pushViewController(exhibitionPage, animated: true)
        }
    }
    
    
    
    
    
}


