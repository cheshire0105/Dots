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
import AlgoliaSearchClient


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

    var autocompleteResults: [ExhibitionHit] = []
       let autocompleteTableView = UITableView()

    var client: SearchClient!
       var index: Index!



    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // 네비게이션 바 숨기기
        navigationController?.setNavigationBarHidden(true, animated: animated)
        // 탭 바 표시하기
        tabBarController?.tabBar.isHidden = false

    }


    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 다른 화면으로 넘어갈 때 네비게이션 바 다시 표시
        navigationController?.setNavigationBarHidden(true, animated: animated)

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
        indexFirestoreDataToAlgolia()

//        // Algolia 클라이언트 및 인덱스 초기화
//               client = SearchClient(appID: "6XB9VU6UYB", apiKey: "a7d85c26f57385132014253ee6a132ab")
//               index = client.index(withName: "전시_상세")

        autocompleteTableView.register(AutocompleteTableViewCell.self, forCellReuseIdentifier: "AutocompleteTableViewCell")


        setupSearchBar()
        setupLabels()
        setupSeparatorLine()
        setupHighlightView()
        setupTableView()
        setupCoverView() // 커버 뷰 설정 추가

        // 테이블 뷰에 대한 초기 데이터 로딩
           loadInitialDataForTableView()
        setupAutocompleteTableView()

    }


    func indexFirestoreDataToAlgolia() {
        let firestore = Firestore.firestore()
        let algoliaClient = SearchClient(appID: "6XB9VU6UYB", apiKey: "a7d85c26f57385132014253ee6a132ab")
        let index = algoliaClient.index(withName: "전시_상세")

        firestore.collection("전시_상세").getDocuments(source: .default) { (snapshot, error) in
            guard let documents = snapshot?.documents else {
                print("Error fetching documents: \(error!)")
                return
            }

            let records = documents.compactMap { document -> ExhibitionRecord? in
                guard let title = document.data()["전시_타이틀"] as? String,
                      let museumName = document.data()["미술관_이름"] as? String else {
                    return nil
                }
                return ExhibitionRecord(objectID: document.documentID, title: title, museumName: museumName)
            }

            index.saveObjects(records) { result in
                switch result {
                case .success(let response):
                    print("Documents indexed successfully: \(response)")
                case .failure(let error):
                    print("Error indexing documents: \(error)")
                }
            }
        }
    }




    private func updateAutocompleteTable() {
        if autocompleteResults.isEmpty {
            autocompleteTableView.isHidden = true
        } else {
            autocompleteTableView.isHidden = false
            autocompleteTableView.reloadData()
        }
    }

    func setupAutocompleteTableView() {
        // 자동완성 테이블 뷰 설정
        autocompleteTableView.delegate = self
        autocompleteTableView.dataSource = self
        autocompleteTableView.register(UITableViewCell.self, forCellReuseIdentifier: "autocompleteCell")
        view.addSubview(autocompleteTableView)

        autocompleteTableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.trailing.bottom.equalTo(view)
        }

        autocompleteTableView.isHidden = true // 초기에는 숨겨둡니다.
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
        if tableView == autocompleteTableView {
              return 44 // 자동완성 셀의 높이를 44pt로 설정
          } else {
              return 200 // 기본 테이블 뷰 셀의 높이
          }
    }



    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == autocompleteTableView {
            // 자동완성 테이블 뷰에 대한 로우 수 반환
            return autocompleteResults.count
        }
        // 기본 테이블 뷰에 대한 로우 수 반환
        return currentData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == autocompleteTableView {
            guard indexPath.row < autocompleteResults.count else {
                return UITableViewCell() // 또는 적절한 기본값 반환
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: "AutocompleteTableViewCell", for: indexPath) as! AutocompleteTableViewCell
            let hit = autocompleteResults[indexPath.row]

            // 전시 타이틀과 미술관 이름을 결합하여 텍스트 설정
            let displayText = "\(hit.title) - \(hit.museumName)"
            cell.configure(with: displayText)

            return cell
        } else {
            guard indexPath.row < currentData.count else {
                return UITableViewCell() // 또는 적절한 기본값 반환
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: "searchPageTableViewCell", for: indexPath) as! searchPageTableViewCell
            let cellModel = currentData[indexPath.row]

            // 텍스트 바인딩 및 이미지 로드
            bindText(for: cell, with: cellModel.imageDocumentId)
            loadImage(for: cell, with: cellModel.imageDocumentId)

            return cell
        }
    }




    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentData.count
    }

    // UITableViewDataSource 및 UITableViewDelegate 메서드

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == autocompleteTableView {
            guard indexPath.row < autocompleteResults.count else { return }

            let selectedHit = autocompleteResults[indexPath.row]
            let detailViewController = BackgroundImageViewController()
            detailViewController.posterImageName = selectedHit.objectID
            detailViewController.titleName = selectedHit.title

            // 탭 바와 네비게이션 바를 숨깁니다.
            detailViewController.hidesBottomBarWhenPushed = true
            navigationController?.setNavigationBarHidden(true, animated: true)

            navigationController?.pushViewController(detailViewController, animated: true)
        } else {
            // 기본 테이블 뷰에서 선택된 셀 처리
            let backgroundImageVC = BackgroundImageViewController()
            backgroundImageVC.posterImageName = currentData[indexPath.row].imageDocumentId
            backgroundImageVC.titleName = currentData[indexPath.row].title

            // 탭 바와 네비게이션 바를 숨깁니다.
            backgroundImageVC.hidesBottomBarWhenPushed = true
            navigationController?.setNavigationBarHidden(true, animated: true)

            navigationController?.pushViewController(backgroundImageVC, animated: true)
        }
    }






}

extension SearchPage {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
         if searchText.isEmpty {
             autocompleteResults = []
             updateAutocompleteTable()
         } else if searchText.count >= 3 {
             performSearch(with: searchText)
         }
     }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let searchText = searchBar.text, searchText.count >= 3 {
            performSearch(with: searchText)
        }
    }

    private func performSearch(with searchText: String) {
        // Algolia 클라이언트 및 인덱스 초기화
        client = SearchClient(appID: "6XB9VU6UYB", apiKey: "a7d85c26f57385132014253ee6a132ab")
        index = client.index(withName: "전시_상세")

        var query = Query(searchText)
        query.attributesToRetrieve = ["title", "museumName"]

        // 이제 index는 nil이 아님을 보장
        index.search(query: query) { result in
            switch result {
            case .success(let response):
                do {
                    let hits: [ExhibitionHit] = try response.extractHits()
                    self.autocompleteResults = try response.extractHits()
                    print("검색 결과: \(self.autocompleteResults)") // 검색 결과 확인
                    DispatchQueue.main.async {
                                      self.updateAutocompleteTable()
                                  }
                } catch {
                    print("Error extracting hits: \(error)")
                }
            case .failure(let error):
                print("Error during Algolia search: \(error)")
            }
        }
    }
}

struct PopularCellModel {
    let imageDocumentId: String
    let title: String
    let subTitle: String
    let likes: Int
}

struct ExhibitionHit: Codable {
    let objectID: String
    let title: String
    let museumName: String

    enum CodingKeys: String, CodingKey {
        case objectID
        case title = "title"
        case museumName = "museumName"
    }
}




struct ExhibitionRecord: Encodable {
    let objectID: String
    let title: String
    let museumName: String
    // 기타 필드를 여기에 추가할 수 있습니다.
}

class AutocompleteTableViewCell: UITableViewCell {
    // 여기에 UI 요소를 추가하세요. 예: 레이블, 이미지뷰 등
    let titleLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // UI 요소 설정
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        // titleLabel 설정
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont(name: "Pretendard-Regular", size: 20)
        contentView.addSubview(titleLabel)

        // titleLabel 오토레이아웃 설정
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }

    func configure(with text: String) {
        // 셀 구성
        titleLabel.text = text
    }
}
