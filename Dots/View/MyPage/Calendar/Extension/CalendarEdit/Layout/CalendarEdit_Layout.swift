import UIKit

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
