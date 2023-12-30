import UIKit
import Firebase
import FirebaseFirestore

class 켈린더_수정_뷰컨트롤러 : UIViewController {

    var 수정할셀데이터: 셀_데이터?
    
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
        label.textColor = .black
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
    
    //피커뷰
    let 연월일_피커뷰 = {
        let pickerView = UIPickerView()
        return pickerView
    }()
    
    let 년도: [String] = {
        return Array(2000...2099).map { "\($0)" }
    }()
    
    let 월: [String] = {
        return Array(1...12).map { "\($0)" }
    }()
    
    let 일: [String] = {
        return Array(1...31).map { "\($0)" }
    }()
    //
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.clear
        연월일_피커뷰.dataSource = self
        연월일_피커뷰.delegate = self
        레이아웃()
        버튼_클릭()
        년월일_피커뷰_초기값 ()
        
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleBackgroundTap))
        배경_백.addGestureRecognizer(tapGestureRecognizer)
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        배경_백.addGestureRecognizer(panGestureRecognizer)
        let panGestureRecognizer2 = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        수정_뷰.addGestureRecognizer(panGestureRecognizer2)
        
        print("다녀온 날짜 변경 화면")
        print("----전달 받은 셀 데이터----")
        print("포스터이미지URL: \(수정할셀데이터?.포스터이미지URL ?? "")")
        print("전시명: \(수정할셀데이터?.전시명 ?? "")")
        print("장소: \(수정할셀데이터?.장소 ?? "")")
        print("방문날짜: \(수정할셀데이터?.방문날짜 ?? "")")
        print("리뷰문서ID: \(수정할셀데이터?.리뷰문서ID ?? "")")
        print("포스터스문서ID: \(수정할셀데이터?.포스터스문서ID ?? "")")
        
        
    }
    @objc private func handleBackgroundTap() {
        dismiss(animated: false, completion: nil)
    }
    @objc private func handlePan(sender: UIPanGestureRecognizer) {
    }
    
    
    
}

