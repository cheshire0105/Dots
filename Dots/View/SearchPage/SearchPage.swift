//
//  SearchPage.swift
//  Dots
//
//  Created by cheshire on 10/23/23.
// 최신화 

import UIKit
import SnapKit
import Firebase
import FirebaseStorage

class SearchPage: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {

    let searchBar = UISearchBar()
    let popularLabel = UILabel()
    let exhibitionButton = UIButton()
    let artistButton = UIButton()

    let separatorLine = UIView()

    let highlightView = UIView()
    var selectedButton: UIButton?

    let tableView = UITableView()
    var currentData: [PopularCellModel] = []

    let coverView = UIView() // 검색을 위한 커버 뷰


    var isCollectionViewSetupDone = false


    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    var refreshControl = UIRefreshControl()
    var cachedData: [PopularCellModel]?


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 네비게이션 바 숨기기
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 다른 화면으로 넘어갈 때 네비게이션 바 다시 표시
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }


    func setupCollectionViewLayout() {
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        layout.scrollDirection = .vertical

        // Adjust these values as necessary
        let padding: CGFloat = 10
        let minimumItemSpacing: CGFloat = 10
        let minimumLineSpacing: CGFloat = 20

        // Set the section insets with different top and bottom padding
        let sectionInsetTop: CGFloat = 20
        let sectionInsetBottom: CGFloat = 100
        layout.sectionInset = UIEdgeInsets(top: sectionInsetTop, left: padding, bottom: sectionInsetBottom, right: padding)

        // Calculate the available width by subtracting the insets for the left and right
        let availableWidth = view.frame.size.width - padding * 2 - minimumItemSpacing * 2

        // Calculate the item width and height
        let itemWidth = (availableWidth / 3).rounded(.down)
        let itemHeight: CGFloat = 150 // 원하는 높이 값으로 설정

        // Set the item size
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.minimumInteritemSpacing = minimumItemSpacing
        layout.minimumLineSpacing = minimumLineSpacing

        // Apply the new layout
        collectionView.setCollectionViewLayout(layout, animated: true)
    }







    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupLabels()
        setupSeparatorLine()
        setupHighlightView()
        setupTableView()
        setupCoverView() // 커버 뷰 설정 추가

        // 테이블 뷰에 대한 초기 데이터 로딩
           loadInitialDataForTableView()
    }

    func setupLabels() {
        popularLabel.text = "인기 전시"
        popularLabel.font = UIFont(name: "Pretendard-Regular", size: 16)
        popularLabel.textColor = .white
        popularLabel.backgroundColor = .black
        view.addSubview(popularLabel)

        popularLabel.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(5)
            make.leading.equalTo(view).offset(20)
        }
    }


    func loadInitialDataForTableView() {
        loadPopularExhibitions(isRefresh: false)
    }

    func loadImage(for cell: searchPageTableViewCell, with documentId: String) {
        let imagePath = "images/\(documentId).png"
        let storageRef = Storage.storage().reference(withPath: imagePath)

        storageRef.downloadURL { url, error in
            if let error = error {
                print("Error getting download URL: \(error)")
                return
            }
            guard let downloadURL = url else {
                print("Download URL not found for document ID: \(documentId)")
                return
            }

            cell.popularCellImageView.sd_setImage(with: downloadURL, placeholderImage: nil, options: [], completed: { image, error, cacheType, url in
                if let error = error {
                    print("Error downloading image: \(error.localizedDescription)")
                } else {
                    // 캐시에서 로드되었는지 확인
                    switch cacheType {
                    case .none:
                        print("Image downloaded from the internet for document ID: \(documentId)")
                    case .disk:
                        print("Image loaded from disk cache for document ID: \(documentId)")
                    case .memory:
                        print("Image loaded from memory cache for document ID: \(documentId)")
                    @unknown default:
                        print("Unknown cache type for document ID: \(documentId)")
                    }
                }
            })
        }
    }

    func setupRefreshControl() {
        refreshControl.attributedTitle = NSAttributedString(string: "데이터 새로고침 중...")
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }


    @objc func refreshData() {
        loadPopularExhibitions(isRefresh: true)
    }

    // Firestore에서 인기 전시 정보를 가져오는 함수
    func loadPopularExhibitions(isRefresh: Bool) {
        if isRefresh || cachedData == nil {
            Firestore.firestore().collection("posters")
                .order(by: "likes", descending: false)
                .limit(to: 10)
                .getDocuments { [weak self] (querySnapshot, error) in
                    guard let self = self else {
                        print("Error loading posters: \(error?.localizedDescription ?? "Unknown error")")
                        return
                    }

                    var popularExhibitions: [PopularCellModel] = []

                    let group = DispatchGroup()
                    for document in querySnapshot?.documents ?? [] {
                        group.enter()
                        let imageDocumentId = document.documentID // 문서 ID

                        // "전시_상세" 컬렉션에서 추가 데이터를 조회
                        Firestore.firestore().collection("전시_상세").document(imageDocumentId).getDocument { (detailDocument, error) in
                            defer { group.leave() }

                            if let detailDocument = detailDocument, detailDocument.exists {
                                let data = detailDocument.data()
                                let title = data?["전시_타이틀"] as? String ?? "Unknown Title"
                                let subTitle = data?["미술관_이름"] as? String ?? "Unknown SubTitle"
                                let likes = data?["likes"] as? Int ?? 0
                                popularExhibitions.append(PopularCellModel(imageDocumentId: imageDocumentId, title: title, subTitle: subTitle, likes: likes))

                            } else {
                                print("Detail document does not exist: \(error?.localizedDescription ?? "Unknown error")")
                            }
                        }
                    }

                    group.notify(queue: .main) {
                        self.currentData = popularExhibitions.sorted(by: { $0.likes > $1.likes })
                        self.tableView.reloadData()
                        self.refreshControl.endRefreshing()
                    }


                }
        } else {
              // 캐시된 데이터를 사용하여 테이블 뷰 갱신
              self.currentData = cachedData ?? []
              self.tableView.reloadData()
          }
    }

    func bindText(for cell: searchPageTableViewCell, with documentId: String) {
         if let cachedTitle = cell.textCache.object(forKey: "\(documentId)-title" as NSString),
            let cachedMuseum = cell.textCache.object(forKey: "\(documentId)-museum" as NSString) {
             cell.ExhibitionTitleLabel.text = cachedTitle as String
             cell.museumLabel.text = cachedMuseum as String
             return
         }

         let exhibitionDetailsRef = Firestore.firestore().collection("전시_상세").document(documentId)
         exhibitionDetailsRef.getDocument { (document, error) in
             guard let document = document, document.exists else {
                 print("Document does not exist: \(error?.localizedDescription ?? "Unknown error")")
                 return
             }
             let data = document.data()
             let exhibitionTitle = data?["전시_타이틀"] as? String ?? "Unknown Title"
             let museumName = data?["미술관_이름"] as? String ?? "Unknown Museum"

             cell.textCache.setObject(exhibitionTitle as NSString, forKey: "\(documentId)-title" as NSString)
             cell.textCache.setObject(museumName as NSString, forKey: "\(documentId)-museum" as NSString)

             cell.ExhibitionTitleLabel.text = exhibitionTitle
             cell.museumLabel.text = museumName
         }
     }


    func setupCoverView() {
        coverView.backgroundColor = .black
        coverView.isHidden = true // 기본적으로 숨겨짐
        view.addSubview(coverView)

        // 커버 뷰를 전체 화면에 맞춰 제약 조건 설정
        coverView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }

        // 탭 제스처 인식기를 추가하여 키보드를 숨기는 기능을 구현합니다.
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        coverView.addGestureRecognizer(tapGestureRecognizer)
    }

    @objc func dismissKeyboard() {
        searchBar.resignFirstResponder() // 키보드 숨기기
        coverView.isHidden = true // 커버 뷰 숨기기
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        coverView.isHidden = false // 검색 시작 시 커버 뷰를 보여줌
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder() // 키보드 숨기기
        coverView.isHidden = true // 검색 취소 시 커버 뷰를 숨김
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder() // 키보드 숨기기
        coverView.isHidden = true // 검색 완료 시 커버 뷰를 숨김
        // 검색 로직을 여기에 추가하세요.
    }



    func setupHighlightView() {
        highlightView.backgroundColor = .white
        view.addSubview(highlightView)

        highlightView.snp.makeConstraints { make in
            make.bottom.equalTo(separatorLine.snp.bottom)
            make.height.equalTo(2)
            make.width.equalTo(popularLabel)
            make.centerX.equalTo(popularLabel)
        }


    }


    func setupSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "전시, 작가를 검색하세요."
        searchBar.searchBarStyle = .minimal
        searchBar.backgroundColor = UIColor.black

        // 커서 색상 변경
        searchBar.tintColor = UIColor(red: 0.882, green: 1, blue: 0, alpha: 1)

        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            textField.font = UIFont.systemFont(ofSize: 15)  // 폰트 크기 설정
            textField.textColor = .white
            textField.backgroundColor = .black
            textField.attributedPlaceholder = NSAttributedString(string: "전시, 작가를 검색하세요.", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        }

        view.addSubview(searchBar)

        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.leading.equalTo(view).offset(5)
            make.trailing.equalTo(view).offset(-5)
        }
    }





    func setupSeparatorLine() {
        separatorLine.backgroundColor = .lightGray
        view.addSubview(separatorLine)

        separatorLine.snp.makeConstraints { make in
            make.top.equalTo(popularLabel.snp.bottom).offset(10)  // 버튼들 아래에 위치
            make.leading.trailing.equalTo(view)  // 뷰의 양쪽 가장자리에 맞춤
            make.height.equalTo(1)  // 선의 높이를 1로 설정하여 얇은 선이 되도록 함
        }
    }

    

    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .black

        // 새로고침 인디케이터 설정
        refreshControl.tintColor = UIColor(red: 0.882, green: 1, blue: 0, alpha: 1)
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.refreshControl = refreshControl // iOS 10 이상에서는 이렇게 설정

        tableView.register(searchPageTableViewCell.self, forCellReuseIdentifier: "searchPageTableViewCell")
        view.addSubview(tableView)

        tableView.snp.makeConstraints { make in
            make.top.equalTo(separatorLine.snp.bottom)
            make.leading.trailing.bottom.equalTo(view)
        }
    }


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200  // 원하는 높이로 설정
    }



    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentData.count
    }

    // UITableViewDataSource 메서드
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchPageTableViewCell", for: indexPath) as! searchPageTableViewCell
        let cellModel = currentData[indexPath.row]

        // 텍스트 바인딩
        bindText(for: cell, with: cellModel.imageDocumentId)

        // 이미지 로드
        loadImage(for: cell, with: cellModel.imageDocumentId)

        return cell
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentData.count
    }

    // UITableViewDataSource 및 UITableViewDelegate 메서드

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let backgroundImageVC = BackgroundImageViewController()
        backgroundImageVC.hidesBottomBarWhenPushed = true

        let selectedCellModel = currentData[indexPath.row]
        backgroundImageVC.posterImageName = selectedCellModel.imageDocumentId
        backgroundImageVC.titleName = selectedCellModel.title

        // Add print statement to check the title value
        print("Selected title: \(selectedCellModel.title)")

        self.navigationController?.pushViewController(backgroundImageVC, animated: true)
    }




}

struct PopularCellModel {
    let imageDocumentId: String
    let title: String
    let subTitle: String
    let likes: Int
}
