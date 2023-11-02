//
//  SearchPage.swift
//  Dots
//
//  Created by cheshire on 10/23/23.
//

import UIKit
import SnapKit


class SearchPage: UIViewController, UITextFieldDelegate {

    let searchTextField = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchTextField()
    }

    func setupSearchTextField() {
        searchTextField.delegate = self
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 14),  // 폰트 크기 설정
            .foregroundColor: UIColor.gray  // 폰트 색상 설정
        ]
        searchTextField.attributedPlaceholder = NSAttributedString(string: "전시, 작가를 검색하세요.", attributes: placeholderAttributes)
        searchTextField.borderStyle = .roundedRect
        searchTextField.returnKeyType = .search
        searchTextField.backgroundColor = UIColor.darkGray  // 배경색 설정
        view.addSubview(searchTextField)

        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.equalTo(view).offset(10)
            make.trailing.equalTo(view).offset(-10)
        }
    }



    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()  // 키보드 숨기기
        print("Search: \(textField.text ?? "")")
        // 검색 로직을 여기에 추가하세요.
        return true
    }
}


