//
//  SearchPage.swift
//  Dots
//
//  Created by cheshire on 10/23/23.
//

import UIKit
import SnapKit
import Firebase
import FirebaseStorage

class SearchPage: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {

    let searchBar = UISearchBar()
    let popularButton = UIButton()
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



    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        selectButton(popularButton)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        if !isCollectionViewSetupDone {
            setupCollectionViewLayout()
            isCollectionViewSetupDone = true
        }
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
        setupButtons()
        setupSeparatorLine()
        setupHighlightView()
        setupTableView()
//        setupCollectionView() // 이 메소드는 여전히 레이아웃 설정 코드 없이 호출됩니다.
        setupCoverView() // 커버 뷰 설정 추가

    }

    // Firestore에서 인기 전시 정보를 가져오는 함수
    func loadPopularExhibitions() {
        Firestore.firestore().collection("posters")
            .order(by: "likes", descending: true)
            .limit(to: 10)
            .getDocuments { [weak self] (querySnapshot, error) in
                guard let self = self, let documents = querySnapshot?.documents else {
                    print("Error loading posters: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                self.currentData = documents.compactMap { docSnapshot -> PopularCellModel? in
                    let data = docSnapshot.data()
                    let imageDocumentId = docSnapshot.documentID // 문서 ID
                    let title = data["전시_타이틀"] as? String ?? "Unknown Title"
                    let subTitle = data["미술관_이름"] as? String ?? "Unknown SubTitle"
                    return PopularCellModel(imageDocumentId: imageDocumentId, title: title, subTitle: subTitle)
                }
                self.tableView.reloadData()
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
            make.top.equalTo(separatorLine.snp.top)
            make.height.equalTo(1)
            make.width.equalTo(popularButton)
            make.centerX.equalTo(popularButton)
        }
    }

    func selectButton(_ button: UIButton) {
        selectedButton?.setTitleColor(.lightGray, for: .normal)
        button.setTitleColor(.white, for: .normal)
        selectedButton = button

        highlightView.snp.remakeConstraints { make in
            make.bottom.equalTo(separatorLine.snp.top)
            make.height.equalTo(2)
            make.width.equalTo(button)
            make.centerX.equalTo(button)
        }

        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }

        updateData(for: button)  // 여기에 추가
    }


    @objc func buttonClicked(_ sender: UIButton) {
        selectButton(sender)
        updateData(for: sender)
    }


    func setupSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "전시, 작가를 검색하세요."
        searchBar.searchBarStyle = .minimal
        searchBar.backgroundColor = UIColor.black
        view.addSubview(searchBar)

        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            textField.font = UIFont.systemFont(ofSize: 15)  // 폰트 크기 설정
            textField.textColor = .white
            textField.backgroundColor = .black
            textField.attributedPlaceholder = NSAttributedString(string: "전시, 작가를 검색하세요.", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        }

        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view).offset(5)
            make.trailing.equalTo(view).offset(-5)
        }
    }

    func setupButtons() {
        let buttons = [popularButton]
        let titles = ["인기"]

        for (button, title) in zip(buttons, titles) {
            button.setTitle(title, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 18)  // 폰트 크기 설정
            button.backgroundColor = .black
            button.setTitleColor(.lightGray, for: .normal)
            button.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
            view.addSubview(button)
        }

        popularButton.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(10)
            make.leading.equalTo(view).offset(20)
        }

    }


    func setupSeparatorLine() {
        separatorLine.backgroundColor = .lightGray
        view.addSubview(separatorLine)

        separatorLine.snp.makeConstraints { make in
            make.top.equalTo(popularButton.snp.bottom).offset(10)  // 버튼들 아래에 위치
            make.leading.trailing.equalTo(view)  // 뷰의 양쪽 가장자리에 맞춤
            make.height.equalTo(1)  // 선의 높이를 1로 설정하여 얇은 선이 되도록 함
        }
    }

    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .black  // 배경색을 검정색으로 설정
        tableView.register(searchPageTableViewCell.self, forCellReuseIdentifier: "searchPageTableViewCell")  // 새로운 셀 클래스를 등록
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
        cell.titleLabel.text = cellModel.title
        cell.contentLabel.text = cellModel.subTitle
        cell.loadImage(documentId: cellModel.imageDocumentId) // 이미지 로드
        return cell
    }



    // '인기' 버튼 클릭 시 호출되는 함수
    func updateData(for button: UIButton) {
        if button == popularButton {
            loadPopularExhibitions() // 인기 전시 정보를 로드합니다.
            tableView.isHidden = false
            collectionView.isHidden = true
        } else {
            // 다른 버튼에 대한 처리
        }
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentData.count
    }

}

struct PopularCellModel {
    let imageDocumentId: String
    let title: String
    let subTitle: String
}
