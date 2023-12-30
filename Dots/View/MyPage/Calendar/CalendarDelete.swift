import UIKit
import FirebaseFirestore

class 켈린더_삭제_뷰컨트롤러 : UIViewController {
    
    var 삭제할셀데이터: 셀_데이터?

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
        label.textColor = .black
        
        label.textAlignment = .center
        return label
    }()
    
    let 전시기록_삭제_확인_라벨 = {
        let label = UILabel()
        label.text = "삭제된 기록은 복구할 수 없어요."
        label.font = UIFont(name: "Pretendard-Regular", size: 14)
        label.textColor = .black

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

