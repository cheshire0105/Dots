//
//  MapPage.swift
//  Dots
//
//  Created by cheshire on 10/23/23.
//
// pull from master branch
// 2023 11월 17일 오전 8시 : 05분 function/mapFunction 생성 테스트 커밋, 푸쉬
// 2023년 11월 17일 오후 3시 10분 dev 최신ㅇ

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

    // 전시 데이터 목록을 추가합니다.
        var exhibitions: [Exhibition] = [
            Exhibition(name: "현대차 시리즈 2023 : 정연두 - 백년여행기", museum: "MMCA 서울", imageName: "art1"),
            Exhibition(name: "올해의 작가상 2023", museum: "MMCA 서울", imageName: "art2"),
            Exhibition(name: "어느 수집가의 초대", museum: "서울시립미술관", imageName: "art2")
        ]


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

        // 새로운 테스트 애너테이션 추가
           let testCoordinate = CLLocationCoordinate2D(latitude: 37.334722, longitude: -122.000000)
           let newAnnotation = NewCustomAnnotation(coordinate: testCoordinate)
           newAnnotation.title = "새 위치"
           newAnnotation.subtitle = "서울"
           mapView.addAnnotation(newAnnotation)
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
        layout.itemSize = CGSize(width: 161, height: 260) // 셀 크기 설정

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "CustomCell")
        collectionView.backgroundColor = .clear

        view.addSubview(collectionView)

        collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view).offset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-65)
            make.height.equalTo(270)
        }
    }


     // MARK: - UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return exhibitions.count // 실제 전시 목록의 수에 따라 반환합니다.
       }

       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           // 컬렉션 뷰 셀 구성
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCollectionViewCell
           // 셀에 전시 데이터를 설정합니다.
           let exhibition = exhibitions[indexPath.item]
           cell.configure(with: exhibition)
           return cell
       }



}

// MapPage 클래스에 주석을 추가하고 MKMapViewDelegate 설정
extension MapPage: MKMapViewDelegate {

    func setupAnnotations() {
        let annotation = CustomAnnotation(coordinate: CLLocationCoordinate2D(latitude: 37.334722, longitude: -122.008889)) // 여기에 원하는 좌표를 입력
        annotation.title = "3" // 필요에 따라 타이틀 설정
        annotation.subtitle = "한국의 미술관" // 필요에 따라 서브타이틀 설정
        mapView.addAnnotation(annotation)
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? CustomAnnotation {
            let identifier = "BalloonAnnotation"
            var view: BalloonAnnotationView

            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? BalloonAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                view = BalloonAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            }

            // 여기서 커스텀 텍스트 설정
            view.configure(with: annotation.title ?? "")
            return view
        } else if let annotation = annotation as? NewCustomAnnotation {
            let newIdentifier = "NewCustomAnnotation"
            var newView: NewCustomAnnotationView

            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: newIdentifier) as? NewCustomAnnotationView {
                dequeuedView.annotation = annotation
                newView = dequeuedView
            } else {
                newView = NewCustomAnnotationView(annotation: annotation, reuseIdentifier: newIdentifier)
                // 새로운 뷰 설정 (예: 색상 변경 등)
            }

            return newView
        }

        return nil
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

import SwiftUI
import UIKit

// MapPage를 SwiftUI에서 사용하기 위한 래퍼 뷰
struct MapPageWrapper: UIViewControllerRepresentable {
    typealias UIViewControllerType = MapPage

    func makeUIViewController(context: Context) -> MapPage {
        // MapPage 인스턴스 생성
        return MapPage()
    }

    func updateUIViewController(_ uiViewController: MapPage, context: Context) {
        // 필요한 업데이트 로직
    }
}

// SwiftUI 프리뷰
struct MapPageWrapper_Previews: PreviewProvider {
    static var previews: some View {
        MapPageWrapper()
    }
}



class BalloonAnnotationView: MKAnnotationView {
    var label: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24)
        label.numberOfLines = 0
        return label
    }()

    override var annotation: MKAnnotation? {
        willSet {
            configure(with: newValue?.title ?? "")
        }
    }

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.setupView()
        configure(with: annotation?.title ?? "")
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }

    private func setupBalloonPath() -> UIBezierPath {
        // 사각형의 경로를 생성하고 모서리를 더 크게 둥글게 만듭니다.
        let rect = CGRect(x: 0, y: 0, width: 48, height: 48)
        let cornerRadii = CGSize(width: 28, height: 28) // 둥근 모서리의 크기를 더 크게 설정합니다.

        // 원하는 모서리만 둥글게 설정합니다.
        let roundedRectanglePath = UIBezierPath(roundedRect: rect,
                                                byRoundingCorners: [.topLeft, .topRight, .bottomRight],
                                                cornerRadii: cornerRadii)
        return roundedRectanglePath
    }

    private func setupView() {
        let balloonPath = setupBalloonPath()

        let shapeLayer = CAShapeLayer()
        shapeLayer.path = balloonPath.cgPath
        shapeLayer.fillColor = UIColor.gray.cgColor // 배경색 설정

        // 기존 레이어를 제거하고 새로운 레이어를 추가합니다.
        self.layer.sublayers?.forEach { if $0 is CAShapeLayer { $0.removeFromSuperlayer() } }
        self.layer.insertSublayer(shapeLayer, at: 0)

        self.addSubview(label)
        // 레이블의 위치와 크기를 조정하세요.
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.topAnchor, constant: 10), // 말풍선 안쪽 여백 조정
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20), // 말풍선 꼬리 부분을 위한 여백 조정
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
        self.backgroundColor = .clear // 배경색을 투명하게 설정
    }


    func configure(with text: String?) {
        label.text = text
        // 텍스트에 따라 레이블 크기 조정
        let size = label.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: self.frame.height))
        let width = size.width + 20 // 좌우 패딩을 고려한 너비
        let height = size.height + 30 // 상하 패딩과 꼬리 부분을 고려한 높이
        self.frame.size = CGSize(width: max(width, 50), height: max(height, 50)) // 최소 크기를 보장
        self.setNeedsLayout()
    }
}


// 새로운 애너테이션 클래스
class NewCustomAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?

    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        super.init()
    }
}

// 새로운 애너테이션 뷰 클래스
class NewCustomAnnotationView: MKAnnotationView {
    var label: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24)
        label.numberOfLines = 0
        return label
    }()

    override var annotation: MKAnnotation? {
        willSet {
            configure(with: newValue?.title ?? "")
        }
    }

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.setupView()
        configure(with: annotation?.title ?? "")
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }

    private func setupBalloonPath() -> UIBezierPath {
        // 사각형의 경로를 생성하고 모서리를 더 크게 둥글게 만듭니다.
        let rect = CGRect(x: 0, y: 0, width: 48, height: 48)
        let cornerRadii = CGSize(width: 28, height: 28) // 둥근 모서리의 크기를 더 크게 설정합니다.

        // 원하는 모서리만 둥글게 설정합니다.
        let roundedRectanglePath = UIBezierPath(roundedRect: rect,
                                                byRoundingCorners: [.topLeft, .topRight, .bottomLeft],
                                                cornerRadii: cornerRadii)
        return roundedRectanglePath
    }

    private func setupView() {
        let balloonPath = setupBalloonPath()

        let shapeLayer = CAShapeLayer()
        shapeLayer.path = balloonPath.cgPath
        shapeLayer.fillColor = UIColor.gray.cgColor // 배경색 설정

        // 기존 레이어를 제거하고 새로운 레이어를 추가합니다.
        self.layer.sublayers?.forEach { if $0 is CAShapeLayer { $0.removeFromSuperlayer() } }
        self.layer.insertSublayer(shapeLayer, at: 0)

        self.addSubview(label)
        // 레이블의 위치와 크기를 조정하세요.
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.topAnchor, constant: 10), // 말풍선 안쪽 여백 조정
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20), // 말풍선 꼬리 부분을 위한 여백 조정
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
        self.backgroundColor = .clear // 배경색을 투명하게 설정
    }


    func configure(with text: String?) {
         label.text = text

         // 레이블 크기 계산
         let size = label.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
         let maxLabelWidth = self.superview?.bounds.width ?? 200 // 상한선 설정
         let labelWidth = min(size.width, maxLabelWidth)
         let labelHeight = size.height

         // 레이블 크기에 맞추어 핀의 모양과 크기를 조정
         updateBalloonPath(width: labelWidth, height: labelHeight)
         self.frame.size = CGSize(width: labelWidth + 20, height: labelHeight + 40)

         // 레이블의 위치 조정
         label.frame = CGRect(x: 10, y: 10, width: labelWidth, height: labelHeight)
     }

     private func updateBalloonPath(width: CGFloat, height: CGFloat) {
         let newWidth = width + 20 // 좌우 여백 추가
         let newHeight = height + 27 // 상하 여백 및 추가 공간 추가

         // 새로운 사각형 크기에 맞는 경로 생성
         let rect = CGRect(x: 0, y: 0, width: newWidth, height: newHeight)
         let roundedRectanglePath = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft, .topRight, .bottomLeft], cornerRadii: CGSize(width: 28, height: 28))

         if let shapeLayer = self.layer.sublayers?.first(where: { $0 is CAShapeLayer }) as? CAShapeLayer {
             shapeLayer.path = roundedRectanglePath.cgPath
         }
     }

     override func layoutSubviews() {
         super.layoutSubviews()
         // 레이아웃 업데이트 필요 시 여기서 수행
     }
}


class CustomCollectionViewCell: UICollectionViewCell {

    let imageView = UIView() // 파란색 네모를 위한 뷰
    let exhibitionNameLabel = UILabel() // 전시 이름 레이블
    let museumNameLabel = UILabel() // 미술관 이름 레이블
    let imageButton = UIButton() // 새로운 이미지 버튼



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
          self.backgroundColor = .white // 셀의 배경색을 하얀색으로 설정
          self.layer.cornerRadius = 10 // 셀의 모서리를 둥글게 설정
          self.clipsToBounds = true  // 셀 경계를 넘어가는 내용을 잘라냄

          setupViews()
      }

    private func setupViews() {
        // 이미지 뷰 설정
        imageView.backgroundColor = .blue // 파란색 배경
        // 이미지 뷰를 셀의 contentView에 추가하고 제약 조건을 설정합니다.
        imageView.layer.cornerRadius = 10
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(10) // 상단 여백
            make.left.equalTo(contentView.snp.left).offset(10) // 좌측 여백
            make.right.equalTo(contentView.snp.right).offset(-10) // 우측 여백
            make.height.equalTo(contentView.snp.width) // 이미지 뷰의 높이를 셀의 너비와 동일하게 설정 (정사각형)
        }

        // 전시 이름 레이블 설정
        exhibitionNameLabel.font = .systemFont(ofSize: 16, weight: .bold)
        exhibitionNameLabel.textAlignment = .left
        exhibitionNameLabel.textColor = .black
        exhibitionNameLabel.numberOfLines = 2
        contentView.addSubview(exhibitionNameLabel)
        exhibitionNameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10) // 이미지 뷰 아래에 위치
            make.leading.equalToSuperview().inset(10)
            make.trailing.equalToSuperview().inset(50)
        }

        // 미술관 이름 레이블 설정
        museumNameLabel.font = .systemFont(ofSize: 14)
        museumNameLabel.textAlignment = .left
        museumNameLabel.textColor = .black
//        museumNameLabel.numberOfLines = 0
        contentView.addSubview(museumNameLabel)
        museumNameLabel.snp.makeConstraints { make in
            make.top.equalTo(exhibitionNameLabel.snp.bottom).offset(5) // 전시 이름 레이블 아래에 위치
            make.left.right.equalTo(exhibitionNameLabel) // 전시 이름 레이블의 좌우 여백과 동일하게 설정
            make.bottom.lessThanOrEqualTo(contentView.snp.bottom).offset(-10) // 하단 여백 (최소 여백으로 설정하여 내용에 따라 늘어날 수 있도록 함)
        }

        // 이미지 버튼 설정
              if let buttonImage = UIImage(named: "heartIcon") { // 'yourImageName'을 실제 이미지 이름으로 교체
                  imageButton.setImage(buttonImage, for: .normal)
                  imageButton.imageView?.contentMode = .scaleAspectFit
              }
              contentView.addSubview(imageButton)
              imageButton.snp.makeConstraints { make in
                  make.centerY.equalTo(exhibitionNameLabel.snp.centerY) // 버튼의 가운데를 레이블의 가운데와 맞춤
                  make.leading.equalTo(exhibitionNameLabel.snp.trailing).offset(10) // 레이블 뒤에 위치
                  make.width.height.equalTo(30) // 버튼 크기 설정
              }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        // 여기서 레이아웃 관련 변경 사항을 조정할 수 있습니다.
    }

    // 셀에 데이터를 설정하는 메서드
    func configure(with exhibition: Exhibition) {
        exhibitionNameLabel.text = exhibition.name
        museumNameLabel.text = exhibition.museum
        // 여기서 imageView에 이미지를 설정할 수 있습니다. 예: imageView.image = UIImage(named: exhibition.imageName)
    }
}

// Exhibition 모델을 정의합니다 (이 예시에는 없으므로 가정으로 만듭니다)
struct Exhibition {
    let name: String
    let museum: String
    let imageName: String // 이미지 파일 이름
}
