import UIKit
import SwiftUI
import SnapKit
import RxSwift
import RxCocoa

class MyPageTicket: UIViewController {
    
    private let 티켓_페이지_제목 = {
        let label = UILabel()
        label.text = "My Ticket"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    private let 뒤로가기_버튼 = {
        let button = UIButton()
        button.setImage(UIImage(named: "backButton"), for: .normal)
        button.isSelected = !button.isSelected
        return button
    } ()
    
    private var 티켓_전시명 = {
        let label = UILabel()
        label.text = "올해의 작가상 2030"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        return label
    }()
    
    private var 티켓_전시장소 = {
        let label = UILabel()
        label.text = "국립현대미술관 서울"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()
    
    var 티켓_작성_버튼 = {
        var button = UIButton()
        button.backgroundColor = UIColor.darkGray
        button.layer.cornerRadius = 25
        button.setImage(UIImage(named: "edit" ), for: .normal)
        button.isSelected = !button.isSelected
        return button
    }()
    
    
    
    lazy var 티켓_컬렉션뷰: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 18
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 35, left: 9, bottom: 60, right: 9)
        
        collectionView.backgroundColor = .black
        collectionView.layer.cornerRadius = 10
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        collectionView.isPagingEnabled = true
        return collectionView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        print("My ticket")
        view.backgroundColor = UIColor.black
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        UI레이아웃()
        티켓_컬렉션뷰_레이아웃()
        티켓_컬렉션뷰.dataSource = self
        티켓_컬렉션뷰.delegate = self
        티켓_컬렉션뷰.register(MyPageTicketCell.self, forCellWithReuseIdentifier: "MyPageTicketCell")
        작성버튼_레이아웃()
        버튼_클릭()
    }
 
    
    private func UI레이아웃() {
        for UI뷰 in [티켓_페이지_제목 , 뒤로가기_버튼 , 티켓_전시명 , 티켓_전시장소] {
            view.addSubview(UI뷰)
        }
        티켓_페이지_제목.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.centerX.equalToSuperview()
        }
        뒤로가기_버튼.snp.makeConstraints { make in
            make.centerY.equalTo(티켓_페이지_제목)
            make.leading.equalToSuperview().offset(39)
        }
        티켓_전시명.snp.makeConstraints { make in
            make.top.equalTo(티켓_페이지_제목.snp.bottom).offset(49)
            make.centerX.equalTo(티켓_페이지_제목)
        }
        티켓_전시장소.snp.makeConstraints { make in
            make.top.equalTo(티켓_전시명.snp.bottom).offset(5)
            make.centerX.equalTo(티켓_페이지_제목)
        }
    }
    
    func 작성버튼_레이아웃() {
        view.addSubview(티켓_작성_버튼)
        티켓_작성_버튼.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.bottom.equalToSuperview().offset(-110)
            make.centerX.equalToSuperview()
        }
    }
    func 티켓_컬렉션뷰_레이아웃 () {
        view.addSubview(티켓_컬렉션뷰)
        티켓_컬렉션뷰.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(200)
            make.bottom.equalToSuperview().offset(-110.85)
            make.leading.trailing.equalToSuperview()
        }
    }
    private func 버튼_클릭() {
        뒤로가기_버튼.addTarget(self, action: #selector(뒤로가기_버튼_클릭), for: .touchUpInside)

    }
    @objc func 뒤로가기_버튼_클릭() {
        navigationController?.popViewController(animated: true)
    }
}
        extension MyPageTicket: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
            
            func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
                10
            }
            
            func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyPageTicketCell", for: indexPath) as? MyPageTicketCell else {
                    return UICollectionViewCell()
                }
                return cell
            }
            
            
            
            func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                let width = collectionView.frame.width * 1 - 18
                let height = collectionView.frame.height * 0.95
                return CGSize(width: width, height: height)
            }
            
            
        }
