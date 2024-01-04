import UIKit


extension Mypage {
    

     func UI레이아웃 () {
        
        for UI뷰 in [마이페이지_프로필_이미지_버튼,마이페이지_설정_버튼,마이페이지_알림_버튼,마이페이지_프로필_닉네임,마이페이지_프로필_이메일,버튼_백,구분선,]{
            view.addSubview(UI뷰)
        }
        마이페이지_프로필_이미지_버튼.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(65)
            make.leading.equalToSuperview().offset(28)
            make.size.equalTo(76)
        }
        마이페이지_설정_버튼.snp.makeConstraints { make in
            //            make.centerY.equalTo(마이페이지_프로필_이미지_버튼.snp.centerY)
            //            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(3)
            //            make.bottom.equalTo(마이페이지_프로필_닉네임.snp.bottom)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10) // 상단 safe area로부터 10포인트 아래에 위치
            make.trailing.equalToSuperview().offset(-26)
        }
//        마이페이지_알림_버튼.snp.makeConstraints { make in
//            //            make.centerY.equalTo(마이페이지_프로필_이미지_버튼.snp.centerY)
//            //            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(3)
//            //            make.bottom.equalTo(마이페이지_프로필_닉네임.snp.bottom)
////            make.top.equalToSuperview().offset(30)
////            make.trailing.equalTo(마이페이지_설정_버튼.snp.leading ).offset(-20)
//        }
        마이페이지_프로필_닉네임.snp.makeConstraints { make in
            make.leading.equalTo(마이페이지_프로필_이미지_버튼.snp.trailing).offset(16)
            make.centerY.equalTo(마이페이지_프로필_이미지_버튼.snp.centerY).offset(-10)
        }
        마이페이지_프로필_이메일.snp.makeConstraints { make in
            make.leading.equalTo(마이페이지_프로필_이미지_버튼.snp.trailing).offset(16)
            make.trailing.equalTo(마이페이지_프로필_닉네임.snp.trailing)
            make.centerY.equalTo(마이페이지_프로필_이미지_버튼.snp.centerY).offset(10)
        }
        버튼_백.snp.makeConstraints { make in
            make.top.equalTo(마이페이지_프로필_이미지_버튼.snp.bottom).offset(5)
            make.bottom.equalTo(구분선.snp.bottom).offset(-10)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        구분선.snp.makeConstraints { make in
            make.top.equalTo(마이페이지_프로필_이미지_버튼.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(0)
        }
        
    }
    
    func 캘린더_레이아웃() {
        view.addSubview(캘린더)
        캘린더.snp.makeConstraints { make in
            make.top.equalTo(구분선.snp.bottom).offset(0)
            make.leading.equalToSuperview().offset(4)
            make.trailing.equalToSuperview().offset(-4)
            make.bottom.equalToSuperview().offset(-70)
        }
    }
    func 백_레이아웃() {
        view.addSubview(배경_백)
             배경_백.snp.makeConstraints { make in
               make.edges.equalToSuperview()
           }
    }
}
