import UIKit
import SwiftUI
import RxSwift
import RxCocoa
import SnapKit

class PopularReviewDetail : UIViewController {
    var selectedCellIndex: Int?
    var 전시정보_메인셀_인스턴스 = 전시정보_택스트(전시아티스트이름: "", 전시장소이름: "", 본문제목: "", 본문내용: "")

    private let 뒤로가기_버튼_블록 = {
        let uiView = UIView()
        uiView.backgroundColor = UIColor.gray.withAlphaComponent(0.8)
        uiView.layer.cornerRadius = 20
        return uiView
    } ()
    private let 뒤로가기_버튼 = {
        let button = UIButton()
        button.setImage(UIImage(named: "backButton"), for: .normal)
        button.isSelected = !button.isSelected
        return button
    } ()
    
    lazy var 인기_디테일_컬렉션뷰: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        collectionView.backgroundColor = .black
        collectionView.layer.cornerRadius = 10
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        collectionView.isPagingEnabled = true
        return collectionView
    }()
    
    override func viewDidLoad() {
        print("Popular Review Detail")
        
        view.backgroundColor = .black
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        인기_디테일_컬렉션뷰.dataSource = self
        인기_디테일_컬렉션뷰.delegate = self
        버튼_클릭()
        컬렉션뷰_레이아웃()
        UI레이아웃()
        인기_디테일_컬렉션뷰.register(인기리뷰_디테일_셀.self, forCellWithReuseIdentifier: "인기리뷰_디테일_셀")
        
        if let selectedIndex = selectedCellIndex {
            // 선택된 셀의 정보를 로그에 출력
            print("Selected Review Title: \(전시정보_메인셀_인스턴스.인기_전시정보[selectedIndex].본문제목)")
            print("Selected Review Content: \(전시정보_메인셀_인스턴스.인기_전시정보[selectedIndex].본문내용)")
            print("Selected Review Artist: \(전시정보_메인셀_인스턴스.인기_전시정보[selectedIndex].전시아티스트이름)")
            print("Selected Review Location: \(전시정보_메인셀_인스턴스.인기_전시정보[selectedIndex].전시장소이름)")
            // 필요한 정보들을 활용하여 원하는 작업 수행
        }
    }
    func UI레이아웃 () {
        view.addSubview(뒤로가기_버튼_블록)
        view.addSubview(뒤로가기_버튼)
        
        뒤로가기_버튼_블록.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(80)
            make.centerX.equalTo(뒤로가기_버튼.snp.centerX)
            make.centerY.equalTo(뒤로가기_버튼.snp.centerY)
            make.bottom.equalTo(인기_디테일_컬렉션뷰.snp.top).offset(-10)
        }
        뒤로가기_버튼.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(32)
            make.bottom.equalTo(인기_디테일_컬렉션뷰.snp.top).offset(-10)
        }
    }
    
    func 컬렉션뷰_레이아웃() {
        view.addSubview(인기_디테일_컬렉션뷰)
        인기_디테일_컬렉션뷰.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(130)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-365)
            
        }
    }
    private func 버튼_클릭() {
        뒤로가기_버튼.addTarget(self, action: #selector(뒤로가기_버튼_클릭), for: .touchUpInside)
    }
    @objc func 뒤로가기_버튼_클릭() {
        navigationController?.popViewController(animated: true)
    }
}

extension PopularReviewDetail : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "인기리뷰_디테일_셀", for: indexPath) as? 인기리뷰_디테일_셀 else {
            return UICollectionViewCell()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width * 1
        let height = collectionView.frame.height * 1
        return CGSize(width: width, height: height)
    }
    
}
