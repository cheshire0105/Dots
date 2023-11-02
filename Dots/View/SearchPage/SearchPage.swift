//
//  SearchPage.swift
//  Dots
//
//  Created by cheshire on 10/23/23.
//

import UIKit
import SnapKit

class SearchPage: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {

    let searchBar = UISearchBar()
    let popularButton = UIButton()
    let exhibitionButton = UIButton()
    let artistButton = UIButton()

    let separatorLine = UIView()

    let highlightView = UIView()
    var selectedButton: UIButton?

    let tableView = UITableView()
    var currentData: [String] = []


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        selectButton(popularButton)
    }



    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupButtons()
        setupSeparatorLine()
        setupHighlightView()
        setupTableView()
        // selectButton(popularButton)  // 이 줄을 제거
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
            make.bottom.equalTo(separatorLine.snp.top )
            make.height.equalTo(2)
            make.width.equalTo(button)
            make.centerX.equalTo(button)
        }

        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
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

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()  // 키보드 숨기기
        print("Search: \(searchBar.text ?? "")")
        // 검색 로직을 여기에 추가하세요.
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()  // 키보드 숨기기
    }

    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .black  // 배경색을 검정색으로 설정
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "customCell")  // 새로운 셀 클래스를 등록
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomTableViewCell
        cell.titleLabel.text = "올해의 작가전"
        cell.contentLabel.text = "국립현대미술관 서울"
        return cell
    }


    func updateData(for button: UIButton) {
        if button == popularButton {
            currentData = ["인기 1", "인기 2", "인기 3"]
        } else if button == exhibitionButton {
            currentData = ["전시 1", "전시 2", "전시 3"]
        } else {
            currentData = []
        }
        tableView.reloadData()
    }
}

class CustomTableViewCell: UITableViewCell {

    let grayBox = UIView()
    let titleLabel = UILabel()
    let contentLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        self.backgroundColor = .black  // 셀의 배경색을 검정색으로 설정

        grayBox.backgroundColor = .gray
        contentView.addSubview(grayBox)

        titleLabel.textColor = .white
        contentView.addSubview(titleLabel)

        contentLabel.textColor = .white
        contentView.addSubview(contentLabel)

        // SnapKit을 사용하여 레이아웃 설정
        grayBox.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(contentView).offset(15)
            make.width.equalTo(130)
            make.height.equalTo(180)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(grayBox.snp.top).offset(50)
            make.leading.equalTo(grayBox.snp.trailing).offset(10)
        }

        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.equalTo(titleLabel)
        }
    }
}
