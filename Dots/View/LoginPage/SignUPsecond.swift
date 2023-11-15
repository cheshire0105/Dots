import UIKit
import SnapKit

class 회원가입_두번째_뷰컨트롤러 : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return 미술관_리스트.count
     }

     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         guard let 셀 = collectionView.dequeueReusableCell(withReuseIdentifier: 미술관셀.identifier, for: indexPath) as? 미술관셀 else {
             return UICollectionViewCell()
         }
         셀.구성(미술관이름: 미술관_리스트[indexPath.row])
         return 셀
     }

    var 선택된셀인덱스: IndexPath?

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
    
    private let 미술관_컬렉션뷰: UICollectionView = {
        let 레이아웃 = CenterAlignedCollectionViewFlowLayout()
        레이아웃.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: 레이아웃)
        collectionView.backgroundColor = .black
        return collectionView
    }()


    override func viewDidLoad() {
        view.backgroundColor = .black
        UI레이아웃 ()
        버튼_클릭()
        미술관_컬렉션뷰.delegate = self
        미술관_컬렉션뷰.dataSource = self
        미술관_컬렉션뷰.register(미술관셀.self, forCellWithReuseIdentifier: 미술관셀.identifier)
        미술관_컬렉션뷰.allowsMultipleSelection = true

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
        view.addSubview(미술관_컬렉션뷰)


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

        미술관_컬렉션뷰.snp.makeConstraints { make in
            make.top.equalTo(검색_텍스트필드.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.bottom.equalTo(다음_버튼.snp.top).offset(-20)
        }

        다음_버튼.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-30)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(64)
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

extension 회원가입_두번째_뷰컨트롤러: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 글자 크기에 따라 셀의 크기를 계산
        let 미술관이름 = 미술관_리스트[indexPath.row]
        let font = UIFont.systemFont(ofSize: 16)
        let textAttributes = [NSAttributedString.Key.font: font]
        let textWidth = (미술관이름 as NSString).size(withAttributes: textAttributes).width
        return CGSize(width: textWidth + 30, height: 38) // 여백 추가
    }
}

extension 회원가입_두번째_뷰컨트롤러 {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 이미 선택된 셀을 다시 탭하면 선택을 해제합니다.
        if let previousIndex = 선택된셀인덱스, previousIndex == indexPath {
            // 선택 해제
            collectionView.deselectItem(at: indexPath, animated: true)
            collectionView.delegate?.collectionView?(collectionView, didDeselectItemAt: indexPath)
            return
        }

        // 새 셀을 선택합니다.
        선택된셀인덱스 = indexPath

        // 선택된 셀의 UI를 업데이트합니다.
        if let 셀 = collectionView.cellForItem(at: indexPath) as? 미술관셀 {
            셀.업데이트UI(선택됨: true)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        // 선택 해제된 셀의 UI를 업데이트합니다.
        if let 셀 = collectionView.cellForItem(at: indexPath) as? 미술관셀 {
            셀.업데이트UI(선택됨: false)
        }

        // 선택 해제 상태를 저장합니다.
        if 선택된셀인덱스 == indexPath {
            선택된셀인덱스 = nil
        }
    }
}



class CenterAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributesSuper = super.layoutAttributesForElements(in: rect)!
        let attributes = NSArray(array: attributesSuper, copyItems: true) as! [UICollectionViewLayoutAttributes]

        // 각 줄별로 그룹화된 셀들의 속성을 저장할 딕셔너리입니다.
        var rowsDictionary = [Int: [UICollectionViewLayoutAttributes]]()

        // 각 셀의 위치를 계산합니다.
        for attribute in attributes {
            let rowNumber = Int(floor(attribute.center.y / attribute.frame.height))
            rowsDictionary[rowNumber, default: []].append(attribute)
        }

        // 각 줄의 셀들을 중앙 정렬합니다.
        for (_, rowAttributes) in rowsDictionary {
            let sortedRowAttributes = rowAttributes.sorted { $0.frame.origin.x < $1.frame.origin.x }
            let totalRowWidth = sortedRowAttributes.reduce(0) { $0 + $1.frame.width + minimumInteritemSpacing } - minimumInteritemSpacing
            var offsetX = (collectionView!.bounds.width - totalRowWidth) / 2
            for attribute in sortedRowAttributes {
                var frame = attribute.frame
                frame.origin.x = offsetX
                attribute.frame = frame
                offsetX += frame.width + minimumInteritemSpacing
            }
        }

        return attributes
    }
}




class 미술관셀: UICollectionViewCell {
    static let identifier = "미술관셀"

    private let 라벨 = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(라벨)
        라벨.textAlignment = .center
        라벨.textColor = .white
        라벨.font = UIFont.systemFont(ofSize: 16)
        라벨.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        // 모서리를 둥글게 만들고 테두리 선을 추가합니다.
        contentView.layer.cornerRadius = 19 // 모서리의 둥근 정도를 조정합니다.
        contentView.layer.borderWidth = 1 // 테두리 선의 두께를 조정합니다.
        contentView.layer.borderColor = UIColor.white.cgColor // 테두리 선의 색상을 조정합니다.
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func 구성(미술관이름: String) {
        라벨.text = 미술관이름
    }

    func 업데이트UI(선택됨: Bool) {
        contentView.backgroundColor = 선택됨 ? UIColor(red: 0.882, green: 1, blue: 0, alpha: 1) : .clear // 라운드 효과가 있는 contentView의 배경색을 바꿉니다.
        라벨.textColor = 선택됨 ? .black : .white
    }

}





import SwiftUI
import AVFoundation
import SnapKit

// ReviewWritePage를 SwiftUI에서 미리 보기 위한 래퍼
struct 회원가입_두번째_뷰컨트롤러Preview: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        // UINavigationController를 반환합니다.
        return UINavigationController(rootViewController: 회원가입_두번째_뷰컨트롤러())
    }

    func updateUIViewController(_ uiViewController: some UIViewController, context: Context) {
        // 뷰 컨트롤러 업데이트 시 수행할 작업, 필요한 경우에만 구현합니다.
    }
}

// SwiftUI 프리뷰
struct 회원가입_두번째_뷰컨트롤러Preview_Previews: PreviewProvider {
    static var previews: some View {
        회원가입_두번째_뷰컨트롤러Preview()
    }
}

