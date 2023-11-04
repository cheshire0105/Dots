//
//  MapPage.swift
//  Dots
//
//  Created by cheshire on 10/23/23.
//
// pull from master branch
import UIKit
import MapKit
import SnapKit
import CoreLocation

// MKAnnotation 프로토콜을 준수하는 사용자 정의 클래스 정의
class CustomAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?

    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        super.init()
    }
}


class MapPage: UIViewController,CLLocationManagerDelegate {

    var mapView: MKMapView!  // 애플의 MKMapView
    var customSearchField: UITextField!
    var currentLocationButton: UIButton! // 현재 위치 아이콘
    var locationManager: CLLocationManager!

    override func viewDidLoad() {
        super.viewDidLoad()

        overrideUserInterfaceStyle = .dark


        mapView = MKMapView(frame: self.view.frame)
        mapView.showsUserLocation = true

        // Set the map type to standard, satellite, or hybrid
        mapView.mapType = .standard // or .satellite, .hybrid

        // Hide points of interest and traffic
        mapView.showsPointsOfInterest = true
        mapView.showsTraffic = true

        // Hide building information
        mapView.showsBuildings = true

        self.view.addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        setupCurrentLocationButton()
        setupLocationManager()
        addDoneButtonOnKeyboard()

        // MKMapViewDelegate 설정
            mapView.delegate = self

            // 주석 설정 함수 호출
            setupAnnotations()
    }

    func addDoneButtonOnKeyboard() {
        let doneToolbar = UIToolbar()
        doneToolbar.sizeToFit()

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "닫기", style: .done, target: self, action: #selector(doneButtonTapped))
        doneButton.tintColor = .white

        doneToolbar.items = [flexSpace, doneButton]
    }

    @objc func doneButtonTapped() {
        customSearchField.resignFirstResponder()
    }


    func setupLocationManager() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization() // 위치 권한 요청
        locationManager.startUpdatingLocation() // 위치 업데이트 시작
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, latitudinalMeters: 1000, longitudinalMeters: 1000)
            mapView.setRegion(region, animated: true)
            locationManager.stopUpdatingLocation()
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
            make.trailing.equalTo(view.snp.trailing).offset(-30) // customSearchField 옆에 위치
            make.top.equalToSuperview().offset(65)
        }
    }


    @objc func currentLocationButtonTapped() {
        locationManager.startUpdatingLocation() // 위치 업데이트 시작
    }



}

// MapPage 클래스에 주석을 추가하고 MKMapViewDelegate 설정
extension MapPage: MKMapViewDelegate {

    func setupAnnotations() {
        let annotation = CustomAnnotation(coordinate: CLLocationCoordinate2D(latitude: 37.579198, longitude: 126.975405)) // 여기에 원하는 좌표를 입력
        annotation.title = "San Francisco" // 필요에 따라 타이틀 설정
        annotation.subtitle = "California" // 필요에 따라 서브타이틀 설정
        mapView.addAnnotation(annotation)
    }

    // 3. mapView(_:viewFor:) 메서드를 구현하여 사용자 정의 이미지로 주석 뷰를 설정
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // 사용자 정의 주석이 아닐 경우 nil 반환
        guard annotation is CustomAnnotation else { return nil }

        let identifier = "CustomAnnotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            // 주석 뷰가 없으면 새로 생성
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true // 풍선 도움말 표시 설정
        } else {
            // 재사용 가능한 주석 뷰를 현재 주석 객체로 업데이트
            annotationView!.annotation = annotation
        }

        // 사용자 정의 이미지 설정
        // 이미지를 로드하고 크기를 조절
           if let resizedImage = UIImage(named: "morningStar")?.resize(to: CGSize(width: 50, height: 50)) {
               annotationView!.image = resizedImage
           }

        return annotationView
    }

}

// 사진 이미지의 크기를 지정 할 수 있는 extension입니다.
extension UIImage {
    func resize(to targetSize: CGSize) -> UIImage {
        let size = self.size

        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height

        // 더 작은 비율을 선택하여 원본 이미지의 비율을 유지합니다
        let ratio = min(widthRatio, heightRatio)
        let newSize = CGSize(width: size.width * ratio, height: size.height * ratio)
        let rect = CGRect(origin: .zero, size: newSize)

        // UIGraphicsImageRenderer를 사용하여 새 이미지를 그립니다
        let renderer = UIGraphicsImageRenderer(size: newSize)
        let newImage = renderer.image { (context) in
            self.draw(in: rect)
        }

        return newImage
    }
}
