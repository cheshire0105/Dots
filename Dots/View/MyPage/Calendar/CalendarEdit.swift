import UIKit

class 켈린더_수정_뷰컨트롤러 : UIViewController {
    
    let 배경_백 = {
        let blurEffect = UIBlurEffect(style: .systemChromeMaterialDark)
               let visualEffectView = UIVisualEffectView(effect: blurEffect)
               return visualEffectView
       }()
    let 수정_뷰 = {
    let view = UIView()
        view.backgroundColor = UIColor(named: "neon")
        view.layer.cornerRadius = 30
       return view
        
    }()
    
    let 다녀온_날짜_변경_라벨 = {
        let label = UILabel()
        label.text = "다녀온 날짜 변경"
        label.font = UIFont(name: "Pretendard-SemiBold", size: 18)
        label.textAlignment = .center
        return label
    }()
    let 변경하기_버튼 = {
        let button = UIButton()
        button.setTitle("변경하기", for: .selected)
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
     
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleBackgroundTap))
        배경_백.addGestureRecognizer(tapGestureRecognizer)
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
              배경_백.addGestureRecognizer(panGestureRecognizer)
        let panGestureRecognizer2 = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
              수정_뷰.addGestureRecognizer(panGestureRecognizer2)
    }
    @objc private func handleBackgroundTap() {
            dismiss(animated: false, completion: nil)
        }
    @objc private func handlePan(sender: UIPanGestureRecognizer) {
       }
    
}



extension 켈린더_수정_뷰컨트롤러 {
    
    func 레이아웃() {
        view.addSubview(배경_백)
           
        view.addSubview(수정_뷰)
        수정_뷰.addSubview(다녀온_날짜_변경_라벨)
        수정_뷰.addSubview(변경하기_버튼)
        
        배경_백.snp.makeConstraints { make in
            배경_백.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
        수정_뷰.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalTo(수정_뷰.snp.width)
            make.leading.equalToSuperview().offset(43)
            make.trailing.equalToSuperview().offset(-42)
        }
        다녀온_날짜_변경_라벨.snp.makeConstraints { make in
            make.top.equalTo(수정_뷰.snp.top).offset(20)
            make.centerX.equalTo(수정_뷰.snp.centerX)
        }
        변경하기_버튼.snp.makeConstraints { make in
            make.bottom.equalTo(수정_뷰.snp.bottom).offset(-20)
            make.leading.equalTo(수정_뷰.snp.leading).offset(16.5)
            make.trailing.equalTo(수정_뷰.snp.trailing).offset(-16.5)
            make.height.equalTo(50)
        }
    }
}
