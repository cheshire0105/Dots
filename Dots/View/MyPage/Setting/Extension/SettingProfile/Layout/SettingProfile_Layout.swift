import UIKit


extension 프로필변경_화면{
    
     func UI레이아웃 () {
        view.addSubview(뒤로가기_버튼)
        view.addSubview(페이지_제목)
        view.addSubview(새_프로필_이미지_버튼)
        view.addSubview(새_프로필_추가_이미지뷰)
        view.addSubview(새_닉네임_백)
        view.addSubview(새_닉네임_텍스트필드)
        view.addSubview(구분선)
        view.addSubview(변경_버튼)
        
        
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
        새_프로필_이미지_버튼.snp.makeConstraints { make in
            make.top.equalTo(페이지_제목.snp.bottom).offset(88)
            make.centerX.equalToSuperview()
            make.size.equalTo(88)
        }
        새_프로필_추가_이미지뷰.snp.makeConstraints { make in
            make.bottom.equalTo(새_프로필_이미지_버튼.snp.bottom)
            make.trailing.equalTo(새_프로필_이미지_버튼.snp.trailing)
            make.size.equalTo(24)
        }
        새_닉네임_백.snp.makeConstraints { make in
            make.top.equalTo(새_프로필_이미지_버튼.snp.bottom).offset(75)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(44)
        }
        
        새_닉네임_텍스트필드.snp.makeConstraints { make in
            make.top.equalTo(새_닉네임_백)
            make.leading.equalTo(새_닉네임_백).offset(15)
            make.trailing.equalTo(새_닉네임_백).offset(-15)
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
    }
}

