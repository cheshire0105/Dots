import UIKit

class 켈린더_삭제_뷰컨트롤러 : UIViewController {
    
    let 배경_백 = {
        let blurEffect = UIBlurEffect(style: .systemChromeMaterialDark)
               let visualEffectView = UIVisualEffectView(effect: blurEffect)
               return visualEffectView
       }()
    let 삭제_뷰 = {
    let view = UIView()
        view.backgroundColor = UIColor(named: "neon")
        view.layer.cornerRadius = 30
       return view
        
    }()
    
    let 전시기록_삭제_라벨 = {
        let label = UILabel()
        label.text = "전시 기록을 삭제하시겠습니까?"
        label.font = UIFont(name: "Pretendard-SemiBold", size: 18)
        label.textAlignment = .center
        return label
    }()
    
    let 전시기록_삭제_확인_라벨 = {
        let label = UILabel()
        label.text = "삭제된 기록은 복구할 수 없어요."
        label.font = UIFont(name: "Pretendard-Regular", size: 14)
        label.textAlignment = .center
        return label
    }()
    let 유지하기_버튼 = {
        let button = UIButton()
        button.setTitle("유지하기", for: .selected)
        button.setTitleColor(UIColor.black, for: .selected)
        button.setTitleColor(UIColor(named: "neon"), for: .normal)
        button.backgroundColor = UIColor(named: "neon")
        button.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 20)
        button.isSelected = !button.isSelected
        button.isEnabled = true
        button.layer.cornerRadius = 25
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        return button
    }()
    let 삭제하기_버튼 = {
        let button = UIButton()
        button.setTitle("삭제하기", for: .selected)
        button.setTitleColor(UIColor.white, for: .selected)
        button.setTitleColor(UIColor(named: "neon"), for: .normal)
        button.backgroundColor = UIColor.black
        button.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 20)
        button.isSelected = !button.isSelected
        button.isEnabled = true
        button.layer.cornerRadius = 25
        return button
    }()
    override func viewDidLoad() {
        view.backgroundColor = UIColor.clear
        
        레이아웃()
        버튼_클릭() 
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleBackgroundTap))
        배경_백.addGestureRecognizer(tapGestureRecognizer)
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
              배경_백.addGestureRecognizer(panGestureRecognizer)
        let panGestureRecognizer2 = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
              삭제_뷰.addGestureRecognizer(panGestureRecognizer2)
    }
    @objc private func handleBackgroundTap() {
            dismiss(animated: false, completion: nil)
        }
    @objc private func handlePan(sender: UIPanGestureRecognizer) {
       }
    
}




extension 켈린더_삭제_뷰컨트롤러 {
    
    func 버튼_클릭() {
        유지하기_버튼.addTarget(self, action: #selector(유지하기_버튼_클릭), for: .touchUpInside)
        삭제하기_버튼.addTarget(self, action: #selector(삭제하기_버튼_클릭), for: .touchUpInside)
    }
    
    @objc func 유지하기_버튼_클릭 () {
        print("다녀온 일정을 유지하겠습니다.")
        dismiss(animated: false, completion: nil)

    }
    @objc func 삭제하기_버튼_클릭 () {
        print("다녀온 일정을 삭제했습니다.")
        dismiss(animated: false, completion: nil)


    }
}

extension 켈린더_삭제_뷰컨트롤러 {
    
    func 레이아웃() {
        view.addSubview(배경_백)
           
        view.addSubview(삭제_뷰)
        삭제_뷰.addSubview(전시기록_삭제_라벨)
        삭제_뷰.addSubview(전시기록_삭제_확인_라벨)
        삭제_뷰.addSubview(유지하기_버튼)
        삭제_뷰.addSubview(삭제하기_버튼)
        
            배경_백.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        
        삭제_뷰.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.bottom.equalTo(삭제하기_버튼.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(43)
            make.trailing.equalToSuperview().offset(-42)
        }
        전시기록_삭제_라벨.snp.makeConstraints { make in
            make.top.equalTo(삭제_뷰.snp.top).offset(20)
            make.centerX.equalTo(삭제_뷰.snp.centerX)
        }
        전시기록_삭제_확인_라벨.snp.makeConstraints { make in
            make.top.equalTo(전시기록_삭제_라벨.snp.bottom).offset(7)
            make.centerX.equalTo(삭제_뷰.snp.centerX)
        }
        유지하기_버튼.snp.makeConstraints { make in
            make.top.equalTo(전시기록_삭제_확인_라벨.snp.bottom).offset(30)
            make.leading.equalTo(삭제_뷰.snp.leading).offset(16.5)
            make.trailing.equalTo(삭제_뷰.snp.trailing).offset(-16.5)
            make.height.equalTo(50)

        }
        삭제하기_버튼.snp.makeConstraints { make in
            make.top.equalTo(유지하기_버튼.snp.bottom).offset(15)
            make.leading.equalTo(삭제_뷰.snp.leading).offset(16.5)
            make.trailing.equalTo(삭제_뷰.snp.trailing).offset(-16.5)
            make.height.equalTo(50)

           
        }
    }
}
