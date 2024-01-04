import UIKit

extension 캘린더_스케쥴_등록_모달 {
    

     func UI레이아웃 () {
        view.addSubview(손잡이)
        view.addSubview(페이지_제목)
        view.addSubview(캘린더_전시_테이블뷰)
        
     

        캘린더_전시_테이블뷰.snp.makeConstraints { make in
            make.top.equalTo(view).offset(10)
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
            make.bottom.equalToSuperview().offset(-5)
        }
    }
}


