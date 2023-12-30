import UIKit


extension Mypage {
    
     func 버튼_백_레이아웃 () {
        for 버튼배치 in [마이페이지_전시_버튼,마이페이지_후기_버튼,마이페이지_보관함_버튼,마이페이지_전시_아이콘,마이페이지_후기_아이콘,마이페이지_보관함_아이콘,마이페이지_전시_라벨,마이페이지_후기_라벨,마이페이지_보관함_라벨] {
            버튼_백.addSubview(버튼배치)
        }
        
        마이페이지_전시_버튼.snp.makeConstraints { make in
            make.top.equalTo(버튼_백.snp.top).offset(15)
            make.bottom.equalTo(버튼_백.snp.bottom).offset(-15)
            
            make.trailing.equalTo(마이페이지_후기_버튼.snp.leading).offset(-11)
            make.height.equalTo(마이페이지_후기_버튼)
            make.width.equalTo(마이페이지_후기_버튼)
            make.leading.equalTo(버튼_백.snp.leading).offset(10)
        }
        
        마이페이지_후기_버튼.snp.makeConstraints { make in
            make.top.equalTo(버튼_백.snp.top).offset(15)
            make.centerX.equalTo(버튼_백.snp.centerX)
            make.bottom.equalTo(버튼_백.snp.bottom).offset(-15)
            
        }
        마이페이지_보관함_버튼.snp.makeConstraints { make in
            make.top.equalTo(버튼_백.snp.top).offset(15)
            make.leading.equalTo(마이페이지_후기_버튼.snp.trailing).offset(11)
            make.width.equalTo(마이페이지_후기_버튼)
            make.height.equalTo(마이페이지_후기_버튼)
            make.trailing.equalTo(버튼_백.snp.trailing).offset(-10)
            make.bottom.equalTo(버튼_백.snp.bottom).offset(-15)
            
        }
        
        마이페이지_전시_아이콘.snp.makeConstraints { make in
            make.centerX.equalTo(마이페이지_전시_버튼.snp.centerX)
            make.bottom.equalTo(마이페이지_전시_버튼.snp.centerY)
            make.size.equalTo(20)
        }
        마이페이지_후기_아이콘.snp.makeConstraints { make in
            make.centerX.equalTo(마이페이지_후기_버튼.snp.centerX)
            make.bottom.equalTo(마이페이지_후기_버튼.snp.centerY)
            make.size.equalTo(20)
        }
        마이페이지_보관함_아이콘.snp.makeConstraints { make in
            make.centerX.equalTo(마이페이지_보관함_버튼.snp.centerX)
            make.bottom.equalTo(마이페이지_보관함_버튼.snp.centerY)
            make.size.equalTo(20)
        }
        마이페이지_전시_라벨.snp.makeConstraints { make in
            make.centerX.equalTo(마이페이지_전시_버튼.snp.centerX)
            make.top.equalTo(마이페이지_전시_버튼.snp.centerY).offset(6)
        }
        마이페이지_후기_라벨.snp.makeConstraints { make in
            make.centerX.equalTo(마이페이지_후기_버튼.snp.centerX)
            make.top.equalTo(마이페이지_후기_버튼.snp.centerY).offset(6)
        }
        
        마이페이지_보관함_라벨.snp.makeConstraints { make in
            make.centerX.equalTo(마이페이지_보관함_버튼.snp.centerX)
            make.top.equalTo(마이페이지_보관함_버튼.snp.centerY).offset(6)
        }
    }
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
            make.top.equalToSuperview().offset(65)
            make.trailing.equalToSuperview().offset(-26)
        }
        마이페이지_알림_버튼.snp.makeConstraints { make in
            //            make.centerY.equalTo(마이페이지_프로필_이미지_버튼.snp.centerY)
            //            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(3)
            //            make.bottom.equalTo(마이페이지_프로필_닉네임.snp.bottom)
            make.top.equalToSuperview().offset(65)
            make.trailing.equalTo(마이페이지_설정_버튼.snp.leading ).offset(-20)
        }
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
            make.top.equalTo(마이페이지_프로필_이미지_버튼.snp.bottom).offset(95)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
    }
    
    func 캘린더_레이아웃() {
        view.addSubview(캘린더)
        캘린더.snp.makeConstraints { make in
            make.top.equalTo(구분선.snp.bottom).offset(-10)
            make.leading.equalToSuperview().offset(4)
            make.trailing.equalToSuperview().offset(-4)
            make.bottom.equalToSuperview().offset(-60)
        }
    }
    func 백_레이아웃() {
        view.addSubview(배경_백)
             배경_백.snp.makeConstraints { make in
               make.edges.equalToSuperview()
           }
    }
}
