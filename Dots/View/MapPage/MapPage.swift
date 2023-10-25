//
//  MapPage.swift
//  Dots
//
//  Created by cheshire on 10/23/23.
//

import UIKit
import NMapsMap

class MapPage: UIViewController {

    var mapView: NMFMapView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // 지도 뷰를 생성합니다.
        mapView = NMFMapView(frame: self.view.frame)
        mapView.mapType = .navi
        mapView.isNightModeEnabled = true

        // 지도 뷰를 메인 뷰에 추가합니다.
        self.view.addSubview(mapView)
    }
}
