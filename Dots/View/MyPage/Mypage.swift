//
//  Mypage.swift
//  Dots
//
//  Created by cheshire on 10/23/23.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class Mypage: UIViewController {
    
    
    var 마이페이지_프로필_이미지_버튼 = {
        var imageButton = UIButton()
        imageButton.layer.cornerRadius = 30
        imageButton.clipsToBounds = true
        imageButton.setImage(UIImage(named: "cabanel"), for: .selected)
        imageButton.setImage(UIImage(named: "cabanel"), for: .normal)
        imageButton.isSelected = !imageButton.isSelected
        return imageButton
    }()
    
    let 마이페이지_설정_버튼 = {
        var button = UIButton()
        button.setImage(UIImage(named: "setting" ), for: .normal)
        button.isSelected = !button.isSelected
        return button
    } ()
    
    let 마이페이지_프로필_닉네임: UILabel = {
        let label = UILabel()
        label.text = "유저 닉네임"
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let 마이페이지_프로필_아이디: UILabel = {
        let label = UILabel()
        label.text = "유저 아이디"
        label.textColor = UIColor.white
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        return label
    }()
    
    let 마이페이지_티켓_버튼 = {
        var button = UIButton()
        button.setImage(UIImage(named:"ticket"), for: .selected)
        button.setImage(UIImage(named: "ticket"), for: .normal)
        button.isSelected = !button.isSelected
        return button
    } ()
    
    let 마이페이지_티켓_택스트: UILabel = {
        let label = UILabel()
        label.text = "티켓"
        label.textColor = UIColor.white
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        label.textAlignment = .center
        return label
    }()
    
    let 마이페이지_체크인_버튼 = {
        var button = UIButton()
        button.setImage(UIImage(named:"home"), for: .selected)
        button.setImage(UIImage(named: "home"), for: .normal)
        button.isSelected = !button.isSelected
        button.isSelected = !button.isSelected
        return button
    } ()
    
    let 마이페이지_체크인_택스트: UILabel = {
        let label = UILabel()
        label.text = "체크인"
        label.textColor = UIColor.white
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        label.textAlignment = .center
        return label
    }()
    
    let 마이페이지_좋아요_버튼 = {
        var button = UIButton()
        button.setImage(UIImage(named:"heart"), for: .selected)
        button.setImage(UIImage(named: "heart"), for: .normal)
        button.isSelected = !button.isSelected
        button.isSelected = !button.isSelected
        return button
    } ()
    
    let 마이페이지_좋아요_택스트: UILabel = {
        
        let label = UILabel()
        label.text = "좋아요"
        label.textColor = UIColor.white
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        label.textAlignment = .center
        return label
        
    }()
    
    lazy var 마이페이지_컬렉션뷰 = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top:5 , left: 0, bottom: 5, right: 0)
        
        collectionView.backgroundColor = .black
        collectionView.layer.cornerRadius = 10
        collectionView.showsVerticalScrollIndicator = false
        collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        collectionView.isPagingEnabled = true
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("My Page")
        view.backgroundColor = UIColor.black
        
        UI레이아웃()
        컬렉션뷰_레이아웃()
        
        마이페이지_컬렉션뷰.dataSource = self
        마이페이지_컬렉션뷰.delegate = self
        마이페이지_컬렉션뷰.register(MyPageCell.self, forCellWithReuseIdentifier: "MyPageCell")
    }
    private func UI레이아웃 () {
        
        for UI뷰 in [마이페이지_프로필_이미지_버튼,마이페이지_설정_버튼,마이페이지_프로필_닉네임,마이페이지_프로필_아이디,마이페이지_티켓_버튼,마이페이지_티켓_택스트,마이페이지_체크인_버튼,마이페이지_체크인_택스트,마이페이지_좋아요_버튼,마이페이지_좋아요_택스트]{
            view.addSubview(UI뷰)
        }
        마이페이지_프로필_이미지_버튼.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(77)
            make.bottom.equalToSuperview().offset(-711)
            make.leading.equalToSuperview().offset(164)
            make.trailing.equalToSuperview().offset(-165)
        }
        마이페이지_설정_버튼.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(97)
            make.leading.equalToSuperview().offset(353)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-731)
        }
        마이페이지_프로필_닉네임.snp.makeConstraints { make in
            make.top.equalTo(마이페이지_프로필_이미지_버튼.snp.bottom).offset(16)
            make.centerX.equalTo(마이페이지_프로필_이미지_버튼)
        }
        마이페이지_프로필_아이디.snp.makeConstraints { make in
            make.top.equalTo(마이페이지_프로필_닉네임.snp.bottom).offset(10)
            make.centerX.equalTo(마이페이지_프로필_닉네임)
        }
        
        마이페이지_티켓_버튼.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(242)
            make.leading.equalToSuperview().offset(70.4)
            make.trailing.equalToSuperview().offset(-300)
            make.bottom.equalToSuperview().offset(-595)
        }
        마이페이지_티켓_택스트.snp.makeConstraints { make in
            make.top.equalTo(마이페이지_티켓_버튼.snp.bottom).offset(5)
            make.centerX.equalTo(마이페이지_티켓_버튼)
        }
        마이페이지_체크인_버튼.snp.makeConstraints { make in
            make.top.bottom.equalTo(마이페이지_티켓_버튼)
            make.centerX.equalToSuperview()
            
        }
        마이페이지_체크인_택스트.snp.makeConstraints { make in
            make.top.equalTo(마이페이지_체크인_버튼.snp.bottom).offset(5)
            make.centerX.equalTo(마이페이지_체크인_버튼)
        }
        마이페이지_좋아요_버튼.snp.makeConstraints { make in
            make.top.bottom.equalTo(마이페이지_티켓_버튼)
            make.trailing.equalToSuperview().offset(-70.4)
        }
        마이페이지_좋아요_택스트.snp.makeConstraints { make in
            make.top.equalTo(마이페이지_좋아요_버튼.snp.bottom).offset(5)
            make.centerX.equalTo(마이페이지_좋아요_버튼)
        }
    }
    func 컬렉션뷰_레이아웃 () {
        view.addSubview(마이페이지_컬렉션뷰)
        마이페이지_컬렉션뷰.snp.makeConstraints { make in
            make.top.equalTo(마이페이지_좋아요_택스트.snp.bottom).offset(20)
            make.leading.trailing.bottom.equalToSuperview()
            
        }
    }
}

extension Mypage : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyPageCell", for: indexPath) as? MyPageCell else {
            return UICollectionViewCell()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width * 0.5
        let height = collectionView.frame.height * 0.5
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       let 마이페이지_티켓_화면 = MyPageTicket()
        self.navigationController?.pushViewController(마이페이지_티켓_화면, animated: true)
    }
}
