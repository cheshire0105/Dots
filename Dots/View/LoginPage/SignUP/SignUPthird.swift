import UIKit
import SnapKit



class 회원가입_세번째_뷰컨트롤러 : UIViewController {
    var 활성화된텍스트필드: UITextField?
    let 아티스트_리스트 : [String] = ["살바도르 달리", "파블로 피카소", "뱅크시" , "클로드 모네","빈센트 반 고흐", "램브란트", "레오나르도 다 빈치","미켈란젤로", "뒤샹", "앤디 워홀" , "폴 세잔", "박철우", "김나라", "빈지노", "미야자키 하야오", "홍길동"]

    private let 아티스트_버튼_뷰 = UIView()
    let 원형_버튼1 = UIButton()
    let 원형_버튼2 = UIButton()
    let 원형_버튼3 = UIButton()
    let 원형_버튼4 = UIButton()
    let 원형_버튼5 = UIButton()
    let 원형_버튼6 = UIButton()
    let 원형_버튼7 = UIButton()
    let 원형_버튼8 = UIButton()
    let 원형_버튼9 = UIButton()
    let 원형_버튼10 = UIButton()
    let 원형_버튼11 = UIButton()
    let 원형_버튼12 = UIButton()
    let 원형_버튼13 = UIButton()
    let 원형_버튼14 = UIButton()
    let 원형_버튼15 = UIButton()


    let 뒤로가기_버튼 = {
        let button = UIButton()
        button.setImage(UIImage(named: "loginBack"), for: .selected)
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
        label.text = "좋아하는 작가를 선택해주세요"
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

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        // 아티스트 버튼 뷰의 경계를 가져옴
        let bounds = 아티스트_버튼_뷰.bounds

        // 각 버튼에 대해 경계를 넘는지 확인하고, 넘으면 숨김
        [원형_버튼1, 원형_버튼2, 원형_버튼3, 원형_버튼4, 원형_버튼5, 원형_버튼6, 원형_버튼7, 원형_버튼8, 원형_버튼9, 원형_버튼10, 원형_버튼11, 원형_버튼12, 원형_버튼13, 원형_버튼14, 원형_버튼15].forEach { 버튼 in
            let isOutside = 버튼.frame.maxX > bounds.maxX || 버튼.frame.maxY > bounds.maxY ||
                            버튼.frame.minX < bounds.minX || 버튼.frame.minY < bounds.minY
            버튼.isHidden = isOutside
        }

        
    }


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        UI레이아웃()
        버튼_클릭()
        아티스트_버튼들_생성()
        [원형_버튼1, 원형_버튼2, 원형_버튼3, 원형_버튼4, 원형_버튼4, 원형_버튼5, 원형_버튼6, 원형_버튼7, 원형_버튼8, 원형_버튼9, 원형_버튼10 , 원형_버튼11, 원형_버튼12, 원형_버튼13,원형_버튼14 ,원형_버튼15].forEach { 버튼 in
              버튼.addTarget(self, action: #selector(버튼이눌림(_:)), for: .touchUpInside)
          }
        NotificationCenter.default.addObserver(self, selector: #selector(키보드가올라올때), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        화면_제스쳐_실행()

    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func 아티스트_버튼들_생성() {


        let 버튼들 = [원형_버튼1, 원형_버튼2, 원형_버튼3, 원형_버튼4, 원형_버튼5, 원형_버튼6, 원형_버튼7, 원형_버튼8, 원형_버튼9, 원형_버튼10, 원형_버튼11, 원형_버튼12, 원형_버튼13, 원형_버튼14, 원형_버튼15]

           // 버튼 타이틀 설정
        for (index, 버튼) in 버튼들.enumerated() {
               if index < 아티스트_리스트.count {
                   버튼.setTitle(아티스트_리스트[index], for: .normal)
                   버튼.tag = index + 1

                   // 여러 줄 텍스트 설정
                   버튼.titleLabel?.numberOfLines = 0 // 여러 줄 표시를 위해 0으로 설정
                   버튼.titleLabel?.lineBreakMode = .byWordWrapping // 단어 단위로 줄 바꿈
                   버튼.titleLabel?.textAlignment = .center // 텍스트 정렬 방식
               }
           }

        view.addSubview(아티스트_버튼_뷰)
        아티스트_버튼_뷰.backgroundColor = .black
        아티스트_버튼_뷰.snp.makeConstraints { make in
            make.top.equalTo(검색_백.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(다음_버튼.snp.top)
        }
        // 원형_버튼1 설정
        원형_버튼1.tag = 1

        // 원형 버튼 스타일 설정
        원형_버튼1.layer.cornerRadius = 35 // 반지름이 35인 원형 버튼
        원형_버튼1.layer.borderWidth = 1 // 테두리 두께 설정
        원형_버튼1.layer.borderColor = UIColor.white.cgColor // 테두리 색상 설정 (빨간색)

        // 배경색 및 텍스트 설정
        원형_버튼1.backgroundColor = .black // 배경색 설정
        원형_버튼1.setTitleColor(.white, for: .normal) // 텍스트 색상 설정 (흰색)

        // 버튼 뷰에 추가 및 제약 설정
        아티스트_버튼_뷰.addSubview(원형_버튼1)
        원형_버튼1.snp.makeConstraints { make in
            make.top.equalTo(아티스트_버튼_뷰.snp.top).inset(6.5)
            make.width.height.equalTo(70)
            make.leading.equalTo(아티스트_버튼_뷰.snp.leading).inset(55)
        }


        원형_버튼2.tag = 2

        원형_버튼2.layer.cornerRadius = 60 // 반지름이 35.5인 원형 버튼
        원형_버튼2.layer.borderWidth = 1 // 테두리 두께 설정
        원형_버튼2.layer.borderColor = UIColor.white.cgColor
        원형_버튼2.backgroundColor = .black

        원형_버튼2.setTitleColor(.white, for: .normal)

        아티스트_버튼_뷰.addSubview(원형_버튼2)
        원형_버튼2.snp.makeConstraints { make in
            make.top.equalTo(아티스트_버튼_뷰.snp.top).inset(28)
            make.width.height.equalTo(120)
            make.leading.equalTo(아티스트_버튼_뷰.snp.leading).inset(114)
        }

        원형_버튼3.tag = 3

        원형_버튼3.layer.cornerRadius = 60 // 반지름이 35.5인 원형 버튼
        원형_버튼3.layer.borderWidth = 1 // 테두리 두께 설정

        원형_버튼3.layer.borderColor = UIColor.white.cgColor
        원형_버튼3.backgroundColor = .black

        원형_버튼3.setTitleColor(.white, for: .normal)

        아티스트_버튼_뷰.addSubview(원형_버튼3)
        원형_버튼3.snp.makeConstraints { make in
            make.top.equalTo(아티스트_버튼_뷰.snp.top).inset(80)
            make.width.height.equalTo(120)
            make.leading.equalTo(아티스트_버튼_뷰.snp.leading).inset(3)
        }

        원형_버튼4.tag = 4

        원형_버튼4.layer.cornerRadius = 50 // 반지름이 35.5인 원형 버튼

        원형_버튼4.layer.borderWidth = 1 // 테두리 두께 설정

        원형_버튼4.layer.borderColor = UIColor.white.cgColor
        원형_버튼4.backgroundColor = .black


        원형_버튼4.setTitleColor(.white, for: .normal)

        아티스트_버튼_뷰.addSubview(원형_버튼4)
        원형_버튼4.snp.makeConstraints { make in
            make.top.equalTo(아티스트_버튼_뷰.snp.top).inset(5)
            make.width.height.equalTo(100)
            make.leading.equalTo(아티스트_버튼_뷰.snp.leading).inset(230)
        }


        원형_버튼5.tag = 5

        원형_버튼5.layer.cornerRadius = 50 // 반지름이 35.5인 원형 버튼


        원형_버튼5.layer.borderWidth = 1 // 테두리 두께 설정

        원형_버튼5.layer.borderColor = UIColor.white.cgColor
        원형_버튼5.backgroundColor = .black

        원형_버튼5.setTitleColor(.white, for: .normal)

        아티스트_버튼_뷰.addSubview(원형_버튼5)
        원형_버튼5.snp.makeConstraints { make in
            make.top.equalTo(아티스트_버튼_뷰.snp.top).inset(110)
            make.width.height.equalTo(100)
            make.leading.equalTo(아티스트_버튼_뷰.snp.leading).inset(210)
        }
        

        원형_버튼6.tag = 6

        원형_버튼6.layer.cornerRadius = 50 // 반지름이 35.5인 원형 버튼
        원형_버튼6.layer.borderWidth = 1 // 테두리 두께 설정

        원형_버튼6.layer.borderColor = UIColor.white.cgColor
        원형_버튼6.backgroundColor = .black


        원형_버튼6.setTitleColor(.white, for: .normal)

        아티스트_버튼_뷰.addSubview(원형_버튼6)
        원형_버튼6.snp.makeConstraints { make in
            make.top.equalTo(아티스트_버튼_뷰.snp.top).inset(150)
            make.width.height.equalTo(100)
            make.leading.equalTo(아티스트_버튼_뷰.snp.leading).inset(110)
        }

        원형_버튼7.tag = 7

        원형_버튼7.layer.cornerRadius = 50 // 반지름이 35.5인 원형 버튼


        원형_버튼7.layer.borderWidth = 1 // 테두리 두께 설정

        원형_버튼7.layer.borderColor = UIColor.white.cgColor
        원형_버튼7.backgroundColor = .black


        원형_버튼7.setTitleColor(.white, for: .normal)

        아티스트_버튼_뷰.addSubview(원형_버튼7)
        원형_버튼7.snp.makeConstraints { make in
            make.top.equalTo(아티스트_버튼_뷰.snp.top).inset(205)
            make.width.height.equalTo(100)
            make.leading.equalTo(아티스트_버튼_뷰.snp.leading).inset(22)
        }

        원형_버튼8.tag = 8

        원형_버튼8.layer.cornerRadius = 35 // 반지름이 35.5인 원형 버튼


        원형_버튼8.layer.borderWidth = 1 // 테두리 두께 설정

        원형_버튼8.layer.borderColor = UIColor.white.cgColor
        원형_버튼8.backgroundColor = .black

        원형_버튼8.setTitleColor(.white, for: .normal)

        아티스트_버튼_뷰.addSubview(원형_버튼8)
        원형_버튼8.snp.makeConstraints { make in
            make.top.equalTo(아티스트_버튼_뷰.snp.top).inset(210)
            make.width.height.equalTo(70)
            make.leading.equalTo(아티스트_버튼_뷰.snp.leading).inset(200)
        }


        원형_버튼9.tag = 9

        원형_버튼9.layer.cornerRadius = 60 // 반지름이 35.5인 원형 버튼


        원형_버튼9.layer.borderWidth = 1 // 테두리 두께 설정

        원형_버튼9.layer.borderColor = UIColor.white.cgColor
        원형_버튼9.backgroundColor = .black

        원형_버튼9.setTitleColor(.white, for: .normal)

        아티스트_버튼_뷰.addSubview(원형_버튼9)
        원형_버튼9.snp.makeConstraints { make in
            make.top.equalTo(아티스트_버튼_뷰.snp.top).inset(260)
            make.width.height.equalTo(120)
            make.leading.equalTo(아티스트_버튼_뷰.snp.leading).inset(110)
        }


        원형_버튼10.tag = 10

        원형_버튼10.layer.cornerRadius = 50 // 반지름이 35.5인 원형 버튼


        원형_버튼10.layer.borderWidth = 1 // 테두리 두께 설정

        원형_버튼10.layer.borderColor = UIColor.white.cgColor
        원형_버튼10.backgroundColor = .black

        원형_버튼10.setTitleColor(.white, for: .normal)

        아티스트_버튼_뷰.addSubview(원형_버튼10)
        원형_버튼10.snp.makeConstraints { make in
            make.top.equalTo(아티스트_버튼_뷰.snp.top).inset(270)
            make.width.height.equalTo(100)
            make.leading.equalTo(아티스트_버튼_뷰.snp.leading).inset(235)

        }

        원형_버튼11.tag = 11

        원형_버튼11.layer.cornerRadius = 50 // 반지름이 35.5인 원형 버튼

        원형_버튼11.layer.borderWidth = 1 // 테두리 두께 설정

        원형_버튼11.layer.borderColor = UIColor.white.cgColor
        원형_버튼11.backgroundColor = .black

        원형_버튼11.setTitleColor(.white, for: .normal)

        아티스트_버튼_뷰.addSubview(원형_버튼11)
        원형_버튼11.snp.makeConstraints { make in
            make.top.equalTo(아티스트_버튼_뷰.snp.top).inset(180)
            make.width.height.equalTo(100)
            make.leading.equalTo(아티스트_버튼_뷰.snp.leading).inset(290)

        }


        원형_버튼12.tag = 12

        원형_버튼12.layer.cornerRadius = 60 // 반지름이 35.5인 원형 버튼

        원형_버튼12.layer.borderWidth = 1 // 테두리 두께 설정

        원형_버튼12.layer.borderColor = UIColor.white.cgColor
        원형_버튼12.backgroundColor = .black

        원형_버튼12.setTitleColor(.white, for: .normal)

        아티스트_버튼_뷰.addSubview(원형_버튼12)
        원형_버튼12.snp.makeConstraints { make in
            make.top.equalTo(아티스트_버튼_뷰.snp.top).inset(62)
            make.width.height.equalTo(120)
            make.leading.equalTo(아티스트_버튼_뷰.snp.leading).inset(310)

        }

        원형_버튼13.tag = 13

        원형_버튼13.layer.cornerRadius = 60 // 반지름이 35.5인 원형 버튼


        원형_버튼13.layer.borderWidth = 1 // 테두리 두께 설정

        원형_버튼13.layer.borderColor = UIColor.white.cgColor
        원형_버튼13.backgroundColor = .black

        원형_버튼13.setTitleColor(.white, for: .normal)

        아티스트_버튼_뷰.addSubview(원형_버튼13)
        원형_버튼13.snp.makeConstraints { make in
            make.top.equalTo(아티스트_버튼_뷰.snp.top).inset(340)
            make.width.height.equalTo(120)
            make.leading.equalTo(아티스트_버튼_뷰.snp.leading).inset(310)

        }


        원형_버튼14.tag = 14

        원형_버튼14.layer.cornerRadius = 50 // 반지름이 35.5인 원형 버튼


        원형_버튼14.layer.borderWidth = 1 // 테두리 두께 설정

        원형_버튼14.layer.borderColor = UIColor.white.cgColor
        원형_버튼14.backgroundColor = .black

        원형_버튼14.setTitleColor(.white, for: .normal)

        아티스트_버튼_뷰.addSubview(원형_버튼14)
        원형_버튼14.snp.makeConstraints { make in
            make.top.equalTo(아티스트_버튼_뷰.snp.top).inset(363)
            make.width.height.equalTo(100)
            make.leading.equalTo(아티스트_버튼_뷰.snp.leading).inset(190)

        }
        
        원형_버튼15.tag = 15

        원형_버튼15.layer.cornerRadius = 50 // 반지름이 35.5인 원형 버튼


        원형_버튼15.layer.borderWidth = 1 // 테두리 두께 설정

        원형_버튼15.layer.borderColor = UIColor.white.cgColor
        원형_버튼15.backgroundColor = .black


        원형_버튼15.setTitleColor(.white, for: .normal)

        아티스트_버튼_뷰.addSubview(원형_버튼15)
        원형_버튼15.snp.makeConstraints { make in
            make.top.equalTo(아티스트_버튼_뷰.snp.top).inset(310)
            make.width.height.equalTo(100)
            make.leading.equalTo(아티스트_버튼_뷰.snp.leading).inset(15)

        }

    }







}

extension 회원가입_세번째_뷰컨트롤러 {

    func UI레이아웃 () {
        view.addSubview(뒤로가기_버튼)
        view.addSubview(건너뛰기_버튼)
        view.addSubview(제목_라벨)
        view.addSubview(검색_백)
        view.addSubview(검색_텍스트필드)
        view.addSubview(다음_버튼)

        뒤로가기_버튼.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16)
            make.size.equalTo(40)
        }
        건너뛰기_버튼.snp.makeConstraints { make in
            make.centerY.equalTo(뒤로가기_버튼.snp.centerY)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(30)
        }
        제목_라벨.snp.makeConstraints { make in
            make.top.equalTo(뒤로가기_버튼.snp.bottom).offset(45)
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
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(64)
        }
    }
}


extension 회원가입_세번째_뷰컨트롤러 {

    private func 버튼_클릭() {
        뒤로가기_버튼.addTarget(self, action: #selector(뒤로가기_버튼_클릭), for: .touchUpInside)
        건너뛰기_버튼.addTarget(self, action: #selector(건너뛰기_버튼_클릭), for: .touchUpInside)
        다음_버튼.addTarget(self, action: #selector(다음_버튼_클릭), for: .touchUpInside)
    }

    @objc func 버튼이눌림(_ sender: UIButton) {
        if sender.backgroundColor == .black {
            // 버튼의 현재 상태가 기본 상태일 때, 색상을 변경
            sender.backgroundColor = UIColor(red: 0.882, green: 1, blue: 0, alpha: 1) // 배경색 변경
            sender.setTitleColor(.black, for: .normal) // 텍스트 색상 변경
            sender.layer.borderColor = UIColor(red: 0.882, green: 1, blue: 0, alpha: 1).cgColor // 테두리 색상 변경
        } else {
            // 버튼의 현재 상태가 변경된 상태일 때, 원래 색상으로 되돌림
            sender.backgroundColor = .black // 원래 배경색으로 변경
            sender.setTitleColor(.white, for: .normal) // 원래 텍스트 색상으로 변경
            sender.layer.borderColor = UIColor.white.cgColor // 원래 테두리 색상으로 변경
        }
    }



    @objc func 뒤로가기_버튼_클릭() {
        print("뒤로가기")
        navigationController?.popViewController(animated: true)
    }
    @objc func 건너뛰기_버튼_클릭() {
        print("건 너 뛰 기")
        let 다음화면_이동 = 회원가입_네번째_뷰컨트롤러()
        self.navigationController?.pushViewController(다음화면_이동, animated: true)
        navigationItem.hidesBackButton = true
    }

    @objc func 다음_버튼_클릭() {
        print("다음 페이지로 이동")
        let 다음화면_이동 = 회원가입_네번째_뷰컨트롤러()
        self.navigationController?.pushViewController(다음화면_이동, animated: true)
        navigationItem.hidesBackButton = true
    }
}

extension 회원가입_세번째_뷰컨트롤러 : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        활성화된텍스트필드 = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        활성화된텍스트필드 = nil
    }
}

extension 회원가입_세번째_뷰컨트롤러 {
    @objc func 키보드가올라올때(notification: NSNotification) {
        guard let 키보드크기 = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
              let 활성화된텍스트필드 = 활성화된텍스트필드 else {
            return
        }
        let 텍스트필드끝 = 활성화된텍스트필드.frame.origin.y + 활성화된텍스트필드.frame.size.height
        let 키보드시작 = view.frame.size.height - 키보드크기.height
        
        if 텍스트필드끝 > 키보드시작 {
            let 이동거리 = 키보드시작 - 텍스트필드끝
            view.frame.origin.y = 이동거리
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        self.view.frame.origin.y = 0
    }
}



extension 회원가입_세번째_뷰컨트롤러 {
    
    func 화면_제스쳐_실행 () {
        let 화면_제스쳐 = UISwipeGestureRecognizer(target: self, action: #selector(화면_제스쳐_뒤로_가기))
        화면_제스쳐.direction = .right
        view.addGestureRecognizer(화면_제스쳐)
    }
    @objc private func 화면_제스쳐_뒤로_가기() {
        navigationController?.popViewController(animated: true)
    }
    
}



