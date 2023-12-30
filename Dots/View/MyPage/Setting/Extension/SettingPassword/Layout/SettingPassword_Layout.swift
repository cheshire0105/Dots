import UIKit

extension 비밀번호변경_화면{
    
     func UI레이아웃 () {
        view.addSubview(뒤로가기_버튼)
        view.addSubview(페이지_제목)
        view.addSubview(현재_비밀번호_백)
        view.addSubview(현재_비밀번호_텍스트필드)
        view.addSubview(새_비밀번호_백)
        view.addSubview(새_비밀번호_텍스트필드)
        view.addSubview(새_비밀번호_확인_백)
        view.addSubview(새_비밀번호_확인_텍스트필드)
        view.addSubview(구분선)
        view.addSubview(변경_버튼)
        view.addSubview(현재비밀번호_라벨)
        view.addSubview(새비밀번호_라벨)
        view.addSubview(새비밀번호확인_라벨)
        view.addSubview(현재_비밀번호_표시_온오프)
        view.addSubview(새_비밀번호_표시_온오프)
        view.addSubview(새_비밀번호_확인_표시_온오프)
        
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
        
        현재_비밀번호_백.snp.makeConstraints { make in
            make.top.equalTo(페이지_제목.snp.bottom).offset(86)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(44)
        }
        
        현재_비밀번호_텍스트필드.snp.makeConstraints { make in
            make.top.equalTo(현재_비밀번호_백)
            make.leading.equalTo(현재_비밀번호_백).offset(15)
            make.trailing.equalTo(현재_비밀번호_백).offset(-15)
            make.height.equalTo(44)
        }
        
        새_비밀번호_백.snp.makeConstraints { make in
            make.top.equalTo(현재_비밀번호_텍스트필드.snp.bottom).offset(60)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(44)
        }
        새_비밀번호_텍스트필드.snp.makeConstraints { make in
            make.top.equalTo(새_비밀번호_백)
            make.leading.equalTo(새_비밀번호_백).offset(15)
            make.trailing.equalTo(새_비밀번호_백).offset(-15)
            make.height.equalTo(44)
        }
        새_비밀번호_확인_백.snp.makeConstraints { make in
            make.top.equalTo(새_비밀번호_텍스트필드.snp.bottom).offset(45)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(44)
        }
        새_비밀번호_확인_텍스트필드.snp.makeConstraints { make in
            make.top.equalTo(새_비밀번호_확인_백)
            make.leading.equalTo(새_비밀번호_확인_백).offset(15)
            make.trailing.equalTo(새_비밀번호_확인_백).offset(-15)
            make.height.equalTo(44)
        }
        구분선.snp.makeConstraints { make in
//            make.top.equalTo(새_비밀번호_확인_텍스트필드.snp.bottom).offset(141)
            make.bottom.equalTo(변경_버튼.snp.top).offset(-20)
        }
        변경_버튼.snp.makeConstraints { make in
//            make.top.equalTo(구분선.snp.bottom).offset(15)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(32)
            make.width.equalTo(74)
            make.bottom.equalToSuperview().offset(-50)
        }
        현재비밀번호_라벨.snp.makeConstraints { make in
            make.bottom.equalTo(현재_비밀번호_백.snp.top)
            make.leading.equalTo(현재_비밀번호_백.snp.leading)
            make.height.equalTo(22)
        }
        새비밀번호_라벨.snp.makeConstraints { make in
            make.bottom.equalTo(새_비밀번호_백.snp.top)
            make.leading.equalTo(새_비밀번호_백.snp.leading)
            make.height.equalTo(22)
        }
        새비밀번호확인_라벨.snp.makeConstraints { make in
            make.bottom.equalTo(새_비밀번호_확인_백.snp.top)
            make.leading.equalTo(새_비밀번호_확인_백.snp.leading)
            make.height.equalTo(22)
        }
        현재_비밀번호_표시_온오프.snp.makeConstraints { make in
            make.centerY.equalTo(현재_비밀번호_텍스트필드.snp.centerY)
            make.trailing.equalTo(현재_비밀번호_백.snp.trailing).offset(-10)
            make.size.equalTo(20)
        }
        새_비밀번호_표시_온오프.snp.makeConstraints { make in
            make.centerY.equalTo(새_비밀번호_텍스트필드.snp.centerY)
            make.trailing.equalTo(새_비밀번호_백.snp.trailing).offset(-10)
            make.size.equalTo(20)
        }
        새_비밀번호_확인_표시_온오프.snp.makeConstraints { make in
            make.centerY.equalTo(새_비밀번호_확인_텍스트필드.snp.centerY)
            make.trailing.equalTo(새_비밀번호_확인_백.snp.trailing).offset(-10)
            make.size.equalTo(20)
        }
    }
}


