// 인기 리뷰 뷰 컨트롤러
import RxCocoa
import RxSwift
import SnapKit
import UIKit

class PopularReviewsPage: UIViewController {
    var 유저정보_인스턴스 = 유저정보(사용자프로필이미지: "", 사용자프로필이름: "")
    var 전시정보_서브셀_인스턴스 = 전시정보_이미지()
    var 전시정보_메인셀_인스턴스 = 전시정보_택스트(전시아티스트이름: "", 전시장소이름: "", 본문제목: "", 본문내용: "")
    
    let 페이지_제목 = {
        let label = UILabel()
        label.text = "Popular Review"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    let 인기순_버튼 = {
        let button = UIButton()
        button.setTitle("인기순", for: .normal)
        button.setTitle("인기순", for: .selected)
        button.setTitleColor(UIColor.white, for: .selected)
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        button.layer.cornerRadius = 10
        button.isSelected = !button.isSelected
        return button
    }()
    
    let 구분선 = {
        let label = UILabel()
        label.text = "|"
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let 추천순_버튼 = {
        let button = UIButton()
        button.setTitle("추천순", for: .normal)
        button.setTitle("추천순", for: .selected)
        button.setTitleColor(UIColor.white, for: .selected)
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        button.layer.cornerRadius = 10
        button.isSelected = !button.isSelected
        return button
    }()
    
    lazy var 인기_컬렉션_뷰: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        collectionView.backgroundColor = .clear
        collectionView.layer.cornerRadius = 10
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Popular Review Page")
        view.backgroundColor = UIColor.black
        ui레이아웃()
        
        인기_컬렉션_뷰.dataSource = self
        인기_컬렉션_뷰.delegate = self
        인기_컬렉션_뷰.register(PopularReviewCell.self, forCellWithReuseIdentifier: "PopulaReviewCell")
        
        인기_컬렉션_뷰.isPagingEnabled = true
        //
        
    }
}

extension PopularReviewsPage {
    func ui레이아웃() {
        view.addSubview(페이지_제목)
        view.addSubview(인기순_버튼)
        view.addSubview(구분선)
        view.addSubview(추천순_버튼)
        view.addSubview(인기_컬렉션_뷰)
        페이지_제목.snp.makeConstraints { make in
            
            make.top.equalToSuperview().offset(60)
            make.centerX.equalToSuperview()
        }
        인기순_버튼.snp.makeConstraints { make in
            make.top.equalTo(페이지_제목.snp.bottom).offset(28)
            make.trailing.equalTo(구분선.snp.leading).offset(-5)
            make.bottom.equalTo(구분선)
        }
        구분선.snp.makeConstraints { make in
            make.trailing.equalTo(추천순_버튼.snp.leading).offset(-5)
            make.centerY.equalTo(인기순_버튼)
        }
        추천순_버튼.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalTo(인기순_버튼)
        }
        인기_컬렉션_뷰.snp.makeConstraints { make in
            //            make.top.equalTo(인기순_버튼.snp.bottom).offset(10)
            make.top.equalToSuperview().offset(150)
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
}

extension PopularReviewsPage: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 전시정보_메인셀_인스턴스.인기_전시정보.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopulaReviewCell", for: indexPath) as? PopularReviewCell else {
            return UICollectionViewCell()
        }
        let 메인셀_유저정보 = 유저정보_인스턴스.마이페이지_유저정보[indexPath.row]
        let 메인셀_전시정보 = 전시정보_메인셀_인스턴스.인기_전시정보[indexPath.row]
        
        cell.인기셀_작성자_이미지.image = UIImage(named: 메인셀_유저정보.사용자프로필이미지)
        cell.인기셀_작성자_이름.text = 메인셀_유저정보.사용자프로필이름
        cell.인기셀_리뷰제목.text = 메인셀_전시정보.본문제목
        cell.인기셀_리뷰내용.text = 메인셀_전시정보.본문내용
        cell.인기셀_이미지_묶음_컬렉션뷰.tag = indexPath.row
        
        let 최대_글자수 = 90
        if let text = cell.인기셀_리뷰내용.text, text.count > 최대_글자수 {
            let 글자수_줄이기 = String(text.prefix(최대_글자수)) + " . . ." + " 더보기"
            cell.인기셀_리뷰내용.text = 글자수_줄이기
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width * 1
        let height = collectionView.frame.height * 0.6
        return CGSize(width: width, height: height)
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        
//        let 인기리뷰_디테일_화면 = PopularReviewDetail()
//        
//        
//        self.navigationController?.pushViewController(인기리뷰_디테일_화면, animated: true)
//    }
//    
}
