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

    var naverMapView: NMFNaverMapView!  // NaverMapView 사용
    var customSearchField: UITextField!
    var currentLocationButton: UIButton! // 현재 위치 아이콘



    override func viewDidLoad() {
        super.viewDidLoad()

        // NMFNaverMapView를 생성하고, 내부의 NMFMapView 설정
        naverMapView = NMFNaverMapView(frame: self.view.frame)
        naverMapView.mapView.mapType = .navi
        naverMapView.mapView.isNightModeEnabled = true

        // 확대/축소 버튼 표시
        naverMapView.showZoomControls = false

        self.view.addSubview(naverMapView)
        naverMapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        setupCustomSearchField()
        setupCurrentLocationButton()
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

    func setupCurrentLocationButton() {
        currentLocationButton = UIButton()
        currentLocationButton.backgroundColor = .white
        currentLocationButton.layer.cornerRadius = 22 // 버튼의 높이와 너비가 44이므로 반으로 나눈 값
        currentLocationButton.addTarget(self, action: #selector(currentLocationButtonTapped), for: .touchUpInside) // 버튼 탭 시 동작 추가

        // 이미지 설정
        if let iconImage = UIImage(named: "Geo") {
            currentLocationButton.setImage(iconImage, for: .normal)
            currentLocationButton.imageView?.contentMode = .scaleAspectFit // 이미지가 버튼 내에서 적절하게 맞게 표시되도록 합니다
            currentLocationButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) // 이미지의 여백 설정 (원하는대로 조절 가능)
        }

        self.view.addSubview(currentLocationButton)
        currentLocationButton.snp.makeConstraints { make in
            make.width.height.equalTo(44)
            make.leading.equalTo(customSearchField.snp.trailing).offset(30) // customSearchField 옆에 위치
            make.top.equalToSuperview().offset(65)
        }
    }


    @objc func currentLocationButtonTapped() {
        // 버튼이 탭될 때 실행될 코드를 여기에 작성합니다.
        print("Current location button tapped!")
    }


}
