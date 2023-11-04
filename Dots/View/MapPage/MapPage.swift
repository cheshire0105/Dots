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


class MapPage: UIViewController, CLLocationManagerDelegate, UICollectionViewDelegate, UICollectionViewDataSource {

    var mapView: MKMapView!  // 애플의 MKMapView
    var customSearchField: UITextField!
    var currentLocationButton: UIButton! // 현재 위치 아이콘
    var locationManager: CLLocationManager!

    var collectionView: UICollectionView!


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
        // 컬렉션 뷰 설정을 마친 후에 숨깁니다.
        setupCollectionView()
        collectionView.isHidden = true // collectionView를 숨깁니다
        collectionView.alpha = 0 // collectionView를 투명하게 만듭니다
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

    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal // 가로 스크롤 설정
        layout.itemSize = CGSize(width: 161, height: 220) // 셀 크기 설정

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "CustomCell")
        collectionView.backgroundColor = .clear

        view.addSubview(collectionView)

        collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-65)
            make.height.equalTo(220)
        }
    }


     // MARK: - UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 표시할 아이템의 수를 반환
        return 10 // 여기에 실제 아이템의 수를 입력합니다.
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 컬렉션 뷰 셀 구성
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCollectionViewCell
        // CustomCollectionViewCell의 추가 설정을 수행할 수 있습니다.
        return cell
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

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let annotation = view.annotation as? CustomAnnotation {
            // 필요한 경우 annotation 정보를 사용하여 컬렉션 뷰 데이터 업데이트
            updateCollectionViewForAnnotation(annotation)
            showCollectionView()
        }
    }

    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        hideCollectionView()
    }

    private func updateCollectionViewForAnnotation(_ annotation: CustomAnnotation) {
        // 컬렉션 뷰의 데이터 소스를 업데이트 하는 코드를 여기에 추가합니다.
        // 예: collectionView.reloadData()
    }

    private func showCollectionView() {
        // 컬렉션 뷰를 애니메이션과 함께 보여줍니다.
        UIView.animate(withDuration: 0.3) {
            self.collectionView.alpha = 1.0
            self.collectionView.isHidden = false
        }
    }

    private func hideCollectionView() {
        // 컬렉션 뷰를 애니메이션과 함께 숨깁니다.
        UIView.animate(withDuration: 0.3) {
            self.collectionView.alpha = 0.0
        } completion: { _ in
            self.collectionView.isHidden = true
        }
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


// CustomCollectionViewCell.swift 파일 생성
import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        // 셀 기본 설정
        self.backgroundColor = .gray // 셀의 배경색을 회색으로 설정
        // 추가적인 레이아웃 구성 및 사용자 정의는 여기서 수행합니다.
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        // 레이아웃 관련 변경 사항이 있을 경우 여기서 조정
    }
}
