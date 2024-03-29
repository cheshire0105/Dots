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



class MainExhibitionPage: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    var collectionViewTopConstraint: Constraint?
    var exhibitions = [ExhibitionModel]()
    var secondSectionExhibitions = [ExhibitionModel]()
    var thirdSectionExhibitions = [ExhibitionModel]()
    let regions = ["인사동", "북촌", "광화문 종로", "평창동", "홍대 연남", "청담", "신사", "용산", "성북", "대학로", "서초 도곡", "삼성 역삼", "성동", "북서울", "헤이리", "경기 인천", "부산" , "대구" , "강원", "대전 충정", "광주 전라", "경상 울산", "제주"]


    private lazy var customAlertView: UIView = {
        let view = UIView()
        // 여기에 얼럿 뷰 디자인 설정
        view.layer.backgroundColor = UIColor(red: 0.153, green: 0.157, blue: 0.165, alpha: 1).cgColor
        view.layer.cornerRadius = 15
        view.isHidden = true
        return view
    }()

    // 얼럿 뷰 내에 배치할 요소들 (예: 레이블, 버튼 등)
    private lazy var alertTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "다른 지역의 전시도 찾아볼까요?"
        label.textColor = UIColor(red: 0.875, green: 0.871, blue: 0.886, alpha: 1)
        label.font = UIFont(name: "Pretendard-SemiBold", size: 18)
        label.textAlignment = .center
        return label
    }()

    private lazy var alertConfirmButton: UIButton = {
        let button = UIButton()
        button.setTitle("찾기", for: .normal)
        button.backgroundColor = UIColor(red: 0.882, green: 1, blue: 0, alpha: 1)
        button.setTitleColor(.black, for: .normal) // 하얀색 텍스트
        button.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 16)
        button.layer.cornerRadius = 20 // 모서리를 둥글게
        button.addTarget(self, action: #selector(alertConfirmButtonTapped), for: .touchUpInside)

        return button
    }()



    private lazy var blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.isHidden = true
        return blurEffectView
    }()

    private lazy var regionPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.overrideUserInterfaceStyle = .dark
        pickerView.dataSource = self
        pickerView.delegate = self
        return pickerView
    }()

    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor(red: 0.882, green: 1, blue: 0, alpha: 1)
        refreshControl.addTarget(self, action: #selector(refreshExhibitionData(_:)), for: .valueChanged)
        return refreshControl
    }()

    var selectedRegion: String = "서울"

    // 새로운 컬렉션뷰를 정의합니다.
    // MainExhibitionCollectionView 초기화 부분에서 레이아웃 설정 변경
    lazy var MainExhibitionCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .black
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        collectionView.refreshControl = refreshControl

        collectionView.register(MainExhibitionFirstSectionCollectionCell.self, forCellWithReuseIdentifier: "MainExhibitionCollectionCell")
        collectionView.register(선별_전시_컬렉션_셀.self, forCellWithReuseIdentifier: "선별_전시_컬렉션_셀")
        collectionView.register(선별_전시_컬렉션_셀_헤더.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "선별_전시_컬렉션_셀_헤더")
        collectionView.isScrollEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()

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
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 50, trailing: 0) // 첫 번째 섹션의 아래 간격을 10으로 설정

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
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 20, trailing: 0)

            section.interGroupSpacing = 0
            section.orthogonalScrollingBehavior = .continuous

            return section
        }
    }



    @objc private func refreshExhibitionData(_ sender: UIRefreshControl) {
         // 여기서 데이터 로딩 함수 호출
         fetchExhibitionData()
         loadPopularExhibitions()

         // 데이터 로딩 완료 후 새로고침 인디케이터 종료
         sender.endRefreshing()
     }

    // 얼럿 뷰 설정
    private func setupCustomAlertView() {
        blurEffectView.contentView.addSubview(customAlertView)
        customAlertView.addSubview(alertTitleLabel)
        customAlertView.addSubview(regionPickerView)
        customAlertView.addSubview(alertConfirmButton)


        customAlertView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(400)
        }


        alertTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.height.equalTo(30)
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalTo(regionPickerView.snp.top)
        }


        regionPickerView.snp.makeConstraints { make in
            make.top.equalTo(alertTitleLabel.snp.bottom)
            make.left.right.equalToSuperview().inset(20)
//            make.height.equalTo(300) // 적당한 높이 설정
            make.bottom.equalTo(alertConfirmButton.snp.top)
        }

        alertConfirmButton.snp.makeConstraints { make in
            make.top.equalTo(regionPickerView.snp.bottom)
            make.bottom.equalToSuperview().inset(20)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
    }



    // '찾기' 버튼을 눌렀을 때의 액션
    @objc private func alertConfirmButtonTapped() {
        customAlertView.isHidden = true
        blurEffectView.isHidden = true

        // 선택된 지역에 따라 데이터를 로드합니다.
        loadExhibitions(forRegion: selectedRegion)

        MainExhibitionCollectionView.reloadData() // 컬렉션 뷰 데이터를 다시 로드하여 섹션 헤더를 업데이트합니다.
    }


    // 지역에 따라 전시 데이터를 로드하는 함수
    func loadExhibitions(forRegion region: String) {
        guard let regionCode = regionCodeForKoreanName(region) else { return }

        let collectionRef = Firestore.firestore().collection("전시_상세")
        let startAt = "\(regionCode)_E_"
        let endAt = "\(regionCode)_E_\u{f8ff}"

        collectionRef.whereField("__name__", isGreaterThanOrEqualTo: startAt)
                     .whereField("__name__", isLessThanOrEqualTo: endAt)
                     .getDocuments { [weak self] (snapshot, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error fetching documents: \(error)")
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
    }




    func regionCodeForKoreanName(_ koreanName: String) -> String? {
        switch koreanName {
        case "인사동": return "INS"
        case "북촌": return "BUK"
        case "광화문 종로": return "GWA"
        case "평창동": return "PYE"
        case "홍대 연남": return "HON"
        case "청담": return "CHE"
        case "신사": return "SIN"
        case "용산": return "YON"
        case "성북": return "SEB"
        case "대학로": return "DAE"
        case "서초 도곡": return "SDO"
        case "삼성 역삼": return "SYE"
        case "성동": return "SED"
        case "북서울": return "BSO"
        case "헤이리": return "HEY"
        case "경기 인천": return "GYE"
        case "부산": return "BUS"
        case "대구": return "DAE"
        case "강원": return "GAN"
        case "대전 충정": return "DCJ"
        case "광주 전라": return "GJJ"
        case "경상 울산": return "GSU"
        case "제주": return "JEJ"
        default: return nil
        }
    }


    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
//        tabBarController?.tabBar.isHidden = false

    }




    override func viewDidAppear(_ animated: Bool) {

    }

  

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupCollectionView()
        setupNewCollectionView()
        fetchExhibitionData()  // 첫 번째 섹션 데이터 로드
        loadPopularExhibitions()

        view.addSubview(blurEffectView)  // 블러 뷰 추가
        if let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first {
            window.addSubview(blurEffectView)
            blurEffectView.snp.makeConstraints { make in
                make.edges.equalTo(window)
            }
        }

        setupCustomAlertView()  // 얼럿 뷰 설정

        self.view.backgroundColor = .black

        // 탭 제스처 인식기 추가
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissAlertView))
        blurEffectView.addGestureRecognizer(tapGesture)

        // 초기 선택된 지역 설정
        selectedRegion = "인사동"
        loadExhibitions(forRegion: selectedRegion)  // 두 번째 섹션 데이터 로드

       
        if let currentUser = Auth.auth().currentUser {
            print("로그인한 사용자 정보:")
            print("UID: \(currentUser.uid)")
            print("이메일: \(currentUser.email ?? "없음")")
            print("계정이 로그인되었습니다.")

            // 싱글톤 인스턴스에 사용자 정보 저장
            CurrentUser.shared.uid = currentUser.uid
            CurrentUser.shared.email = currentUser.email
        }
    }


    func setupNavigationBar() {
        // 네비게이션 타이틀 설정
        self.navigationItem.title = ""

        // 네비게이션 바 배경색 설정
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .black // 배경색을 검은색으로 설정

        // iOS 15 이상에서는 아래 설정도 필요할 수 있습니다.
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.standardAppearance = appearance

        // 오른쪽 네비게이션 바 버튼 설정
        let rightButton = UIBarButtonItem(title: "다른 지역", style: .plain, target: self, action: #selector(rightButtonTapped))
        rightButton.setTitleTextAttributes([.foregroundColor: UIColor.white, .font: UIFont(name: "Pretendard-Bold", size: 14)], for: .normal)
        rightButton.setTitleTextAttributes([.foregroundColor: UIColor.gray, .font: UIFont(name: "Pretendard-Bold", size: 14)], for: .highlighted)
        self.navigationItem.rightBarButtonItem = rightButton
    }


    @objc private func rightButtonTapped() {
        // 버튼이 눌렸을 때의 액션
        print("네비게이션 바 오른쪽 버튼이 눌렸습니다.")
        customAlertView.isHidden = false
        blurEffectView.isHidden = false
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
                        data["셀_구성"] = doc.documentID // 문서 ID를 '셀_구성' 필드에 저장
                        return ExhibitionModel(dictionary: data)
                    }
                    self?.MainExhibitionCollectionView.reloadData()
                }
            }
        }
    }

    func loadPopularExhibitions() {
        Firestore.firestore().collection("posters")
            .order(by: "visits", descending: true) // 'visits'에 따라 내림차순 정렬
            .limit(to: 1000)
            .getDocuments { [weak self] (snapshot, error) in
                guard let self = self else { return }

                if let error = error {
                    print("Error fetching documents: \(error)")
                    return
                }

                guard let snapshot = snapshot else { return }

                let dispatchGroup = DispatchGroup() // 모든 세부 정보 로드가 완료될 때까지 기다리기 위한 그룹

                var loadedExhibitions: [(exhibition: ExhibitionModel, visits: Int)] = []
                for document in snapshot.documents {
                    dispatchGroup.enter() // 그룹에 작업 추가
                    let posterDocumentId = document.documentID
                    let visits = document.data()["visits"] as? Int ?? 0 // 'visits' 값 추출

                    Firestore.firestore().collection("전시_상세").document(posterDocumentId).getDocument { (detailDocument, error) in
                        defer { dispatchGroup.leave() } // 작업이 끝날 때 그룹에서 제거

                        if let detailDocument = detailDocument, let data = detailDocument.data() {
                            let exhibition = ExhibitionModel(dictionary: data)
                            loadedExhibitions.append((exhibition: exhibition, visits: visits))
                        } else {
                            print("Detail document does not exist: \(error?.localizedDescription ?? "Unknown error")")
                        }
                    }
                }

                dispatchGroup.notify(queue: .main) {
                    // 모든 세부 정보가 로드되면, 'visits' 값에 따라 내림차순으로 정렬
                    self.thirdSectionExhibitions = loadedExhibitions.sorted { $0.visits > $1.visits }.map { $0.exhibition }
                    self.MainExhibitionCollectionView.reloadData()
                }
            }
    }


    
    
    
    
    private func setupCollectionView() {

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
            switch indexPath.section {
            case 0:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainExhibitionCollectionCell", for: indexPath) as! MainExhibitionFirstSectionCollectionCell
                configureFirstSectionCell(cell, at: indexPath)
                return cell

            case 1:
                      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "선별_전시_컬렉션_셀", for: indexPath) as! 선별_전시_컬렉션_셀
                      if indexPath.item < secondSectionExhibitions.count {
                          let exhibition = secondSectionExhibitions[indexPath.item]
                          cell.configure(with: exhibition)
                      }
                      return cell

            case 2:
                      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "선별_전시_컬렉션_셀", for: indexPath) as! 선별_전시_컬렉션_셀
                      if indexPath.item < thirdSectionExhibitions.count {
                          let exhibition = thirdSectionExhibitions[indexPath.item]
                          cell.configure(with: exhibition)
                      }
                      return cell

            default:
                return UICollectionViewCell()
            }
        }
        return UICollectionViewCell()
    }

    private func configureFirstSectionCell(_ cell: MainExhibitionFirstSectionCollectionCell, at indexPath: IndexPath) {
        guard indexPath.item < exhibitions.count else { return }
        let exhibition = exhibitions[indexPath.item]
        cell.label.text = exhibition.title
        loadImage(for: cell.imageView, with: exhibition.poster)
    }

    private func configureSecondSectionCell(_ cell: 선별_전시_컬렉션_셀, at indexPath: IndexPath) {
        guard indexPath.item < secondSectionExhibitions.count else { return }
        let exhibition = secondSectionExhibitions[indexPath.item]
        cell.titleLabel.text = exhibition.title
        loadImage(for: cell.imageView, with: exhibition.poster)
    }

    private func configureThirdSectionCell(_ cell: 선별_전시_컬렉션_셀, at indexPath: IndexPath) {
        guard indexPath.item < thirdSectionExhibitions.count else { return }
        let exhibition = thirdSectionExhibitions[indexPath.item]
        cell.titleLabel.text = exhibition.title
        loadImage(for: cell.imageView, with: exhibition.poster)
    }

    private func loadImage(for imageView: UIImageView, with imageName: String) {
        let storageRef = Storage.storage().reference(withPath: "images/\(imageName).png")
        storageRef.downloadURL { (url, error) in
            guard let url = url, error == nil else {
                print("이미지 다운로드 URL 가져오기 실패: \(error?.localizedDescription ?? "알 수 없는 오류")")
                return
            }
            DispatchQueue.main.async {
                imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"), completed: { (image, error, cacheType, url) in
                    if let error = error {
                        print("이미지 다운로드 오류: \(error.localizedDescription)")
                    } else {
                        switch cacheType {
                        case .none:
                            print("이미지가 인터넷에서 다운로드되어 캐시에 저장됨: \(url?.absoluteString ?? "알 수 없는 URL")")
                        case .disk:
                            print("이미지가 디스크 캐시에서 로드됨")
                        case .memory:
                            print("이미지가 메모리 캐시에서 로드됨")
                        @unknown default:
                            print("알 수 없는 캐시 타입")
                        }
                    }
                })
            }
        }
    }


    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "선별_전시_컬렉션_셀_헤더", for: indexPath) as! 선별_전시_컬렉션_셀_헤더
            if indexPath.section == 1 {
                header.label.text = "\(selectedRegion)의 전시"
//                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(headerTapped))
//                header.addGestureRecognizer(tapGesture)
            } else if indexPath.section == 2 {
                header.label.text = "가장 많이 다녀온 전시"
            }
            return header
        }
        return UICollectionReusableView()
    }


//    @objc func headerTapped() {
//        customAlertView.isHidden = false
//        blurEffectView.isHidden = false
//    }

    @objc private func dismissAlertView() {
        customAlertView.isHidden = true
        blurEffectView.isHidden = true
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
                print("Selected Poster Name: \(selectedExhibition.poster)")

                exhibitionPage.posterImageName = selectedExhibition.poster
                exhibitionPage.titleName = selectedExhibition.title 

            }
            
            self.navigationController?.pushViewController(exhibitionPage, animated: true)
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
         return 1
     }

     func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
         return regions.count
     }

     func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
         return regions[row]
     }

    // 피커 뷰의 didSelectRow 메서드
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // 선택된 지역을 저장하지만, 여기에서 데이터 로딩을 하지 않습니다.
        selectedRegion = regions[row]
    }




}


