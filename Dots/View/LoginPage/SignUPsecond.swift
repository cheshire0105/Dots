import UIKit
import SnapKit

class 회원가입_두번째_뷰컨트롤러 : UIViewController {
    
    let 미술관_리스트 : [String] = ["국립 현대 미술관 서울", "백남준 아트센터", "리움 미술관", "호암 미술관", "뮤지엄 산", "서울 시립 미술관", "아르떼 뮤지엄 제주", "국립 현대 미술관 과천", "국립 중앙 박물관", "대림 미술관","예술의 전당","서울미술관","청주시립미술관","포항 시립 미술관","북서울미술관","수원 시립 아트 스페이스 광교", "부산 현대 미술관","석파정 서울 미술관","디뮤지엄", "경기도 미술관","일민 미술관"]
    
    let 뒤로가기_버튼 = {
        let button = UIButton()
        button.setImage(UIImage(named: "loginBack"), for: .selected)
        button.setImage(UIImage(named: ""), for: .normal)
        button.isSelected = !button.isSelected
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        return button
    } ()
    private let 건너뛰기_버튼 = {
        let button = UIButton()
        button.isSelected = !button.isSelected
        button.setTitle("건너뛰기", for: .normal)
        button.setTitle("건너뛰기", for: .selected)
        button.setTitleColor(UIColor(named: "neon"), for: .selected)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.titleLabel?.textAlignment = .center
        return button
    }()
    private let 제목_라벨 = {
        let label = UILabel()
        label.text = "자주 가는 미술관을 선택해주세요"
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 24)
        
        return label
    } ()
    private let 검색_백 = {
        let uiView = UIView()
        uiView.backgroundColor = .darkGray
        uiView.layer.cornerRadius = 25
        return uiView
    }()
    private let 검색_텍스트필드 = { ()
        let textField = UITextField()
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.lightGray,
            .font: UIFont.boldSystemFont(ofSize: 14)
        ]
        textField.attributedPlaceholder = NSAttributedString(string: "직접입력...", attributes: attributes)
        textField.textColor = UIColor.white
        textField.tintColor = UIColor.lightGray
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 25
        textField.backgroundColor = .darkGray
        textField.textAlignment = .left
        textField.font = UIFont.boldSystemFont(ofSize: 14)
        return textField
    } ()
    private let 다음_버튼 = {
        let button = UIButton()
        button.layer.cornerRadius = 30
        button.backgroundColor = UIColor.white
        button.isSelected = !button.isSelected
        button.setTitle("다음", for: .normal)
        button.setTitle("다음", for: .selected)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor.black, for: .selected)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.titleLabel?.textAlignment = .center
        return button
    }()
    lazy var 미술관_리스트_컬렉션뷰: UICollectionView = {
           let layout = UICollectionViewFlowLayout()
           layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 10, right: 15)
           let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
           collectionView.backgroundColor = .black
           return collectionView
       }()
    
    override func viewDidLoad() {
        view.backgroundColor = .black
        UI레이아웃 ()
        버튼_클릭()
        미술관_리스트_컬렉션뷰.dataSource = self
        미술관_리스트_컬렉션뷰.delegate = self
        미술관_리스트_컬렉션뷰.register(미술관_리스트_셀.self, forCellWithReuseIdentifier: "미술관_리스트_셀")
    }
}

extension 회원가입_두번째_뷰컨트롤러 {
    
    func UI레이아웃 () {
        view.addSubview(뒤로가기_버튼)
        view.addSubview(건너뛰기_버튼)
        view.addSubview(제목_라벨)
        view.addSubview(검색_백)
        view.addSubview(검색_텍스트필드)
        view.addSubview(다음_버튼)
        view.addSubview(미술관_리스트_컬렉션뷰)

        뒤로가기_버튼.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(75)
            make.leading.equalToSuperview().offset(24)
            make.size.equalTo(40)
        }
        건너뛰기_버튼.snp.makeConstraints { make in
            make.centerY.equalTo(뒤로가기_버튼.snp.centerY)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(30)
        }
        제목_라벨.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(149)
            make.leading.equalToSuperview().offset(24)
        }
        검색_백.snp.makeConstraints { make in
            make.top.equalTo(제목_라벨.snp.bottom).offset(47)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(56)
            
            
        }
        검색_텍스트필드.snp.makeConstraints { make in
            make.top.equalTo(검색_백)
            make.leading.equalTo(검색_백.snp.leading).offset(30)
            make.trailing.equalTo(검색_백.snp.trailing).offset(-80)
            make.height.equalTo(56)
        
        }
        다음_버튼.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-30)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(64)
        }
        미술관_리스트_컬렉션뷰.snp.makeConstraints { make in
            make.top.equalTo(검색_백.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.bottom.equalTo(다음_버튼.snp.top).offset(-5)
        }
    }
}


extension 회원가입_두번째_뷰컨트롤러 {
    
    private func 버튼_클릭() {
        뒤로가기_버튼.addTarget(self, action: #selector(뒤로가기_버튼_클릭), for: .touchUpInside)
        건너뛰기_버튼.addTarget(self, action: #selector(건너뛰기_버튼_클릭), for: .touchUpInside)
        다음_버튼.addTarget(self, action: #selector(다음_버튼_클릭), for: .touchUpInside)
    }
    
    
    @objc func 뒤로가기_버튼_클릭() {
        print("뒤로가기")
        navigationController?.popViewController(animated: true)
    }
    @objc func 건너뛰기_버튼_클릭() {
        print("건 너 뛰 기")
        let 다음화면_이동 = 회원가입_세번째_뷰컨트롤러()
        self.navigationController?.pushViewController(다음화면_이동, animated: true)
        navigationItem.hidesBackButton = true
    }
    
    @objc func 다음_버튼_클릭() {
        print("다음 페이지로 이동")
        let 다음화면_이동 = 회원가입_세번째_뷰컨트롤러()
        self.navigationController?.pushViewController(다음화면_이동, animated: true)
        navigationItem.hidesBackButton = true
    }
}

extension 회원가입_두번째_뷰컨트롤러 : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 미술관_리스트.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "미술관_리스트_셀", for: indexPath) as! 미술관_리스트_셀
        cell.미술관_버튼.setTitle(미술관_리스트[indexPath.item], for: .selected)
        cell.미술관_버튼.setTitle(미술관_리스트[indexPath.item], for: .normal)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("Selected Taste: \(미술관_리스트[indexPath.item])")
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = 미술관_리스트[indexPath.item]
        let font = UIFont.systemFont(ofSize: 15)
        let size = text.size(withAttributes: [NSAttributedString.Key.font: font])
        
        let padding: CGFloat = 16 + (size.width / 5)
        return CGSize(width: size.width + padding, height: 30)
    }
}
