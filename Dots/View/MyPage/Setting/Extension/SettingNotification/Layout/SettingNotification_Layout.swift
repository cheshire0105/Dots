import UIKit


extension 알림설정_화면{
    
     func UI레이아웃 () {
        view.addSubview(뒤로가기_버튼)
        view.addSubview(페이지_제목)
        
        view.addSubview(팔로우_백)
        view.addSubview(팔로우_라벨)
        view.addSubview(팔로우_토글)
        
        view.addSubview(좋아요_백)
        view.addSubview(좋아요_라벨)
        view.addSubview(좋아요_토글)
        
        view.addSubview(댓글_백)
        view.addSubview(댓글_라벨)
        view.addSubview(댓글_토글)
        
        view.addSubview(보관한전시오픈_백)
        view.addSubview(보관한전시오픈_라벨)
        view.addSubview(보관한전시오픈_토글)
        
        view.addSubview(보관한전시마감임박_백)
        view.addSubview(보관한전시마감임박_라벨)
        view.addSubview(보관한전시마감임박_토글)
        
        view.addSubview(도트공지사항및약관변경_백)
        view.addSubview(도트공지사항및약관변경_라벨)
        view.addSubview(도트공지사항및약관변경_토글)
        
        view.addSubview(이벤트관련정보_백)
        view.addSubview(이벤트관련정보_라벨)
        view.addSubview(이벤트관련정보_토글)
        
        
        뒤로가기_버튼.snp.makeConstraints { make in
            make.centerY.equalTo(페이지_제목.snp.centerY)
            make.leading.equalToSuperview().offset(16)
            make.size.equalTo(40)
        }
        페이지_제목.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.centerX.equalToSuperview()
            make.height.equalTo(44)
        }
        
        팔로우_백.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(145)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.height.equalTo(44)
            
        }
        팔로우_라벨.snp.makeConstraints { make in
            make.centerY.equalTo(팔로우_백.snp.centerY)
            make.leading.equalTo(팔로우_백.snp.leading).offset(16)
        }
        팔로우_토글.snp.makeConstraints { make in
            make.centerY.equalTo(팔로우_백.snp.centerY)
            make.trailing.equalTo(팔로우_백.snp.trailing).offset(-16)
        }
        
        좋아요_백.snp.makeConstraints { make in
            make.top.equalTo(팔로우_백.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.height.equalTo(44)
            
        }
        좋아요_라벨.snp.makeConstraints { make in
            make.centerY.equalTo(좋아요_백.snp.centerY)
            make.leading.equalTo(좋아요_백.snp.leading).offset(16)
        }
        좋아요_토글.snp.makeConstraints { make in
            make.centerY.equalTo(좋아요_백.snp.centerY)
            make.trailing.equalTo(좋아요_백.snp.trailing).offset(-16)
        }
        댓글_백.snp.makeConstraints { make in
            make.top.equalTo(좋아요_백.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.height.equalTo(44)
            
        }
        댓글_라벨.snp.makeConstraints { make in
            make.centerY.equalTo(댓글_백.snp.centerY)
            make.leading.equalTo(댓글_백.snp.leading).offset(16)
        }
        댓글_토글.snp.makeConstraints { make in
            make.centerY.equalTo(댓글_백.snp.centerY)
            make.trailing.equalTo(댓글_백.snp.trailing).offset(-16)
        }
        보관한전시오픈_백.snp.makeConstraints { make in
            make.top.equalTo(댓글_백.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.height.equalTo(44)
            
        }
        보관한전시오픈_라벨.snp.makeConstraints { make in
            make.centerY.equalTo(보관한전시오픈_백.snp.centerY)
            make.leading.equalTo(보관한전시오픈_백.snp.leading).offset(16)
        }
        보관한전시오픈_토글.snp.makeConstraints { make in
            make.centerY.equalTo(보관한전시오픈_백.snp.centerY)
            make.trailing.equalTo(보관한전시오픈_백.snp.trailing).offset(-16)
        }
        보관한전시마감임박_백.snp.makeConstraints { make in
            make.top.equalTo(보관한전시오픈_백.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.height.equalTo(44)
            
        }
        보관한전시마감임박_라벨.snp.makeConstraints { make in
            make.centerY.equalTo(보관한전시마감임박_백.snp.centerY)
            make.leading.equalTo(보관한전시마감임박_백.snp.leading).offset(16)
        }
        보관한전시마감임박_토글.snp.makeConstraints { make in
            make.centerY.equalTo(보관한전시마감임박_백.snp.centerY)
            make.trailing.equalTo(보관한전시마감임박_백.snp.trailing).offset(-16)
        }
        
        도트공지사항및약관변경_백.snp.makeConstraints { make in
            make.top.equalTo(보관한전시마감임박_백.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.height.equalTo(44)
            
        }
        도트공지사항및약관변경_라벨.snp.makeConstraints { make in
            make.centerY.equalTo(도트공지사항및약관변경_백.snp.centerY)
            make.leading.equalTo(도트공지사항및약관변경_백.snp.leading).offset(16)
        }
        도트공지사항및약관변경_토글.snp.makeConstraints { make in
            make.centerY.equalTo(도트공지사항및약관변경_백.snp.centerY)
            make.trailing.equalTo(도트공지사항및약관변경_백.snp.trailing).offset(-16)
        }
        
        이벤트관련정보_백.snp.makeConstraints { make in
            make.top.equalTo(도트공지사항및약관변경_백.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.height.equalTo(44)
        }
        이벤트관련정보_라벨.snp.makeConstraints { make in
            make.centerY.equalTo(이벤트관련정보_백.snp.centerY)
            make.leading.equalTo(이벤트관련정보_백.snp.leading).offset(16)
        }
        이벤트관련정보_토글.snp.makeConstraints { make in
            make.centerY.equalTo(이벤트관련정보_백.snp.centerY)
            make.trailing.equalTo(이벤트관련정보_백.snp.trailing).offset(-16)
        }
        
    }
}
