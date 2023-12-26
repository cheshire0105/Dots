import UIKit

class 켈린더_수정_뷰컨트롤러 : UIViewController {
    
    var 선택된셀데이터: 셀_데이터?

    
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
        
        
        
    }
    @objc private func handleBackgroundTap() {
            dismiss(animated: false, completion: nil)
        }
    @objc private func handlePan(sender: UIPanGestureRecognizer) {
       }
    
   
    
}



extension 켈린더_수정_뷰컨트롤러 {
    func 버튼_클릭() {
           변경하기_버튼.addTarget(self, action: #selector(변경하기_버튼_클릭), for: .touchUpInside)
       }
    @objc func 변경하기_버튼_클릭() {
           let 선택된년도 = 년도[연월일_피커뷰.selectedRow(inComponent: 0)]
           let 선택된월 = 월[연월일_피커뷰.selectedRow(inComponent: 1)]
           let 선택된일 = 일[연월일_피커뷰.selectedRow(inComponent: 2)]

//           print("[ 선택된 날짜: \(선택된년도)년 \(선택된월)월 \(선택된일)일 ]으로 변경되었습니다")
        let 결과값 = "\(선택된년도)-\(선택된월)-\(선택된일)"
            print("[ 선택된 날짜: \(결과값) ]으로 변경되었습니다")
           dismiss(animated: false, completion: nil)

       }
}

extension 켈린더_수정_뷰컨트롤러 {
    
    func 레이아웃() {
        view.addSubview(배경_백)
           
        view.addSubview(수정_뷰)
        수정_뷰.addSubview(다녀온_날짜_변경_라벨)
        수정_뷰.addSubview(연월일_피커뷰)
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
        연월일_피커뷰.snp.makeConstraints { make in
            make.top.equalTo(다녀온_날짜_변경_라벨.snp.bottom).offset(20)
            make.centerX.equalTo(수정_뷰.snp.centerX)
            make.leading.equalTo(수정_뷰.snp.leading).offset(16.5)
            make.trailing.equalTo(수정_뷰.snp.trailing).offset(-16.5)
            make.bottom.equalTo(변경하기_버튼.snp.top).offset(-20)
        }
        변경하기_버튼.snp.makeConstraints { make in
            make.bottom.equalTo(수정_뷰.snp.bottom).offset(-20)
            make.leading.equalTo(수정_뷰.snp.leading).offset(16.5)
            make.trailing.equalTo(수정_뷰.snp.trailing).offset(-16.5)
            make.height.equalTo(50)
        }
    }
}
extension 켈린더_수정_뷰컨트롤러 {
    func 년월일_피커뷰_초기값 () {
        let 현제값_데이터 = Date()
        let 켈린더 = Calendar.current
        let 현제_년 = 켈린더.component(.year, from: 현제값_데이터) - 2000
        let 현제_달 = 켈린더.component(.month, from: 현제값_데이터) - 1
        let 현제_일 = 켈린더.component(.day, from: 현제값_데이터) - 1
        연월일_피커뷰.selectRow(현제_년, inComponent: 0, animated: true)
        연월일_피커뷰.selectRow(현제_달, inComponent: 1, animated: true)
        연월일_피커뷰.selectRow(현제_일, inComponent: 2, animated: true)
    }
}

extension 켈린더_수정_뷰컨트롤러 : UIPickerViewDelegate , UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
           return 3
       }

       func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
           switch component {
           case 0:
               return 년도.count
           case 1:
               return 월.count
           case 2:
               return 일.count
           default:
               return 0
           }
       }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let 픽커뷰_년월일_텍스속성 = UILabel()

        switch component {
        case 0:
            픽커뷰_년월일_텍스속성.text = "\(년도[row])년"
            픽커뷰_년월일_텍스속성.textColor = .black
        case 1:
            픽커뷰_년월일_텍스속성.text = "\(월[row])월"
            픽커뷰_년월일_텍스속성.textColor = .black
        case 2:
            픽커뷰_년월일_텍스속성.text = "\(일[row])일"
            픽커뷰_년월일_텍스속성.textColor = .black
        default:
            break
        }

        픽커뷰_년월일_텍스속성.font = UIFont(name: "Pretendard-SemiBold", size: 15)
        픽커뷰_년월일_텍스속성.textAlignment = .center

        return 픽커뷰_년월일_텍스속성
    }

       func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       }
}
