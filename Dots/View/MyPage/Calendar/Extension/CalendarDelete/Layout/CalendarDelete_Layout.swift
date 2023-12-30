import UIKit

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

