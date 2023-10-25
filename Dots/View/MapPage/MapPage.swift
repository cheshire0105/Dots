//
//  MapPage.swift
//  Dots
//
//  Created by cheshire on 10/23/23.
//

import UIKit
import NMapsMap
import SnapKit

class MapPage: UIViewController {

    var mapView: NMFMapView!
    var customSearchField: UITextField!
    var currentLocationIcon: UIView! // 현재 위치 아이콘



    override func viewDidLoad() {
        super.viewDidLoad()

        // 지도 뷰를 생성합니다.
        mapView = NMFMapView(frame: self.view.frame)
        mapView.mapType = .navi
        mapView.isNightModeEnabled = true
        self.view.addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        setupCustomSearchField()
        setupCurrentLocationIcon()

    }

    func setupCustomSearchField() {
        // 배경 뷰 생성
        let backgroundView = UIView()
        backgroundView.layer.backgroundColor = UIColor(red: 0.458, green: 0.455, blue: 0.455, alpha: 1).cgColor
        backgroundView.layer.cornerRadius = 22
        self.view.addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(44)
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(65)
        }

        // 텍스트 필드 생성
        customSearchField = UITextField()
        let placeholderText = "전시를 검색하세요"
        customSearchField.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        customSearchField.borderStyle = .none
        customSearchField.backgroundColor = .clear
        customSearchField.textColor = .white
        customSearchField.font = UIFont(name: "HelveticaNeue", size: 13) // 폰트와 크기 설정
        backgroundView.addSubview(customSearchField)
        customSearchField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
        }
    }
    func setupCurrentLocationIcon() {
        currentLocationIcon = UIView()
        currentLocationIcon.backgroundColor = .white
        currentLocationIcon.layer.cornerRadius = 22 // 뷰의 높이와 너비가 44이므로 반으로 나눈 값
        self.view.addSubview(currentLocationIcon)
        currentLocationIcon.snp.makeConstraints { make in
            make.width.height.equalTo(44)
            make.leading.equalTo(customSearchField.snp.trailing).offset(30) // customSearchField 옆에 위치
            make.top.equalToSuperview().offset(65)
        }
    }


}
