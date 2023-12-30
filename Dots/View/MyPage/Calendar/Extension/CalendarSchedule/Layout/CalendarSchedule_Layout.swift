import UIKit

extension 캘린더_스케쥴_등록_모달 {
    
     func UI레이아웃 () {
        view.addSubview(손잡이)
        view.addSubview(페이지_제목)
        view.addSubview(캘린더_전시_테이블뷰)
        
        손잡이.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
            make.height.equalTo(5)
            make.width.equalTo(40)
        }
        페이지_제목.snp.makeConstraints { make in
            make.top.equalTo(손잡이.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        캘린더_전시_테이블뷰.snp.makeConstraints { make in
            make.top.equalTo(페이지_제목.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
            make.bottom.equalToSuperview().offset(-5)
        }
    }
}


