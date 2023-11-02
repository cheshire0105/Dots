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
            .font: UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor.gray
        ]
        searchTextField.attributedPlaceholder = NSAttributedString(string: "전시, 작가를 검색하세요.", attributes: placeholderAttributes)
        searchTextField.borderStyle = .roundedRect
        searchTextField.returnKeyType = .search
        searchTextField.backgroundColor = UIColor.darkGray
        view.addSubview(searchTextField)

        let iconImageView = UIImageView(image: UIImage(named: "Search Glyph"))
        iconImageView.contentMode = .scaleAspectFit
        let iconContainerView = UIView()
        iconContainerView.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)  // 왼쪽 패딩 추가
            make.centerY.equalToSuperview().offset(16)
            make.width.equalTo(25)
            make.height.equalTo(15)
        }
        searchTextField.leftView = iconContainerView
        searchTextField.leftViewMode = .always
        iconContainerView.snp.makeConstraints { make in
            make.width.equalTo(35)  // 컨테이너 뷰의 너비 조절
        }

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


