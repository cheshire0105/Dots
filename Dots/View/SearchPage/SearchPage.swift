//
//  SearchPage.swift
//  Dots
//
//  Created by cheshire on 10/23/23.
//

import UIKit
import SnapKit

class SearchPage: UIViewController, UISearchBarDelegate {

    let searchBar = UISearchBar()
    let popularButton = UIButton()
    let exhibitionButton = UIButton()
    let artistButton = UIButton()

    let separatorLine = UIView()

    let highlightView = UIView()
    var selectedButton: UIButton?


    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupButtons()
        setupSeparatorLine()
        setupHighlightView()
        selectButton(popularButton)  // 초기 선택

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
}
