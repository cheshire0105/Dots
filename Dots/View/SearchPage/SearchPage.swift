//
//  SearchPage.swift
//  Dots
//
//  Created by cheshire on 10/23/23.
//

import UIKit
import SnapKit

class SearchPage: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {

    let searchBar = UISearchBar()
    let popularButton = UIButton()
    let exhibitionButton = UIButton()
    let artistButton = UIButton()

    let separatorLine = UIView()

    let highlightView = UIView()
    var selectedButton: UIButton?

    let tableView = UITableView()
    var currentData: [String] = []

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
        setupCollectionView() // 이 메소드는 여전히 레이아웃 설정 코드 없이 호출됩니다.
        setupCoverView() // 커버 뷰 설정 추가

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
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.equalTo(view).offset(5)
            make.trailing.equalTo(view).offset(-5)
        }
    }

    func setupButtons() {
        let buttons = [popularButton, exhibitionButton, artistButton]
        let titles = ["인기", "전시", "작가"]

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

        exhibitionButton.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(10)
            make.leading.equalTo(popularButton.snp.trailing).offset(20)
        }

        artistButton.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(10)
            make.leading.equalTo(exhibitionButton.snp.trailing).offset(20)
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

//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        searchBar.resignFirstResponder()  // 키보드 숨기기
//        print("Search: \(searchBar.text ?? "")")
//        // 검색 로직을 여기에 추가하세요.
//    }
//
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        searchBar.text = ""
//        searchBar.resignFirstResponder()  // 키보드 숨기기
//    }

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

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchPageTableViewCell", for: indexPath) as! searchPageTableViewCell
        cell.titleLabel.text = "올해의 작가전"
        cell.contentLabel.text = "국립현대미술관 서울"
        return cell
    }


    func updateData(for button: UIButton) {
        if button == popularButton {
            currentData = (1...10).map { "인기 \($0)" } // "인기 1"부터 "인기 10"까지의 문자열을 생성합니다.
            tableView.isHidden = false
            collectionView.isHidden = true
        } else if button == exhibitionButton {
            currentData = (1...10).map { "전시 \($0)" } // "전시 1"부터 "전시 10"까지의 문자열을 생성합니다.
            tableView.isHidden = false
            collectionView.isHidden = true
        } else if button == artistButton {
            currentData = (1...20).map { "작가 \($0)" } // "작가 1"부터 "작가 10"까지의 문자열을 생성합니다.
            tableView.isHidden = true
            collectionView.isHidden = false
        }
        tableView.reloadData()
        collectionView.reloadData()
    }



    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .black
        collectionView.register(ArtistCollectionViewCell.self, forCellWithReuseIdentifier: "ArtistCollectionViewCell")
        collectionView.isHidden = true // 처음에는 숨김 처리
        view.addSubview(collectionView)

        collectionView.snp.makeConstraints { make in
            make.top.equalTo(separatorLine.snp.bottom)
            make.leading.trailing.bottom.equalTo(view)
        }
    }




    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArtistCollectionViewCell", for: indexPath) as! ArtistCollectionViewCell
        cell.titleLabel.text = "작가 이름"
        cell.contentLabel.text = "작가 정보"
        return cell
    }


}


class ArtistCollectionViewCell: UICollectionViewCell {
    let titleLabel = UILabel()
    let contentLabel = UILabel()
    let circleView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        // Set the background color of the cell
        self.backgroundColor = .black
        

        // 원형 뷰 설정
        circleView.backgroundColor = .gray
        circleView.layer.cornerRadius = 50 // 반지름이 50인 원형 뷰
        contentView.addSubview(circleView)

        // titleLabel 설정
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.textColor = .white
        titleLabel.text = "작가 이름" // 여기에 실제 작가 이름을 나중에 설정해야 합니다.
        contentView.addSubview(titleLabel)

        // contentLabel 설정
        contentLabel.font = UIFont.systemFont(ofSize: 12)
        contentLabel.textColor = .white
        contentLabel.text = "작가 정보" // 여기에 실제 작가 정보를 나중에 설정해야 합니다.
        contentView.addSubview(contentLabel)

        // SnapKit을 사용하여 원형 뷰의 제약 조건 설정
        circleView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(10)
            make.centerX.equalTo(contentView)
            make.width.height.equalTo(100) // 원의 크기를 100x100으로 설정
        }

        // titleLabel의 제약 조건 설정
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(circleView.snp.bottom).offset(10)
            make.centerX.equalTo(contentView)
        }

        // contentLabel의 제약 조건 설정
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.centerX.equalTo(contentView)
        }
    }


}

