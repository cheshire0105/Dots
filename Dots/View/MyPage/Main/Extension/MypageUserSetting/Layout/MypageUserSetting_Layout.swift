import UIKit

extension 마이페이지_설정_페이지 {
    
    
     func UI레이아웃() {
        view.addSubview(뒤로가기_버튼)
        view.addSubview(페이지_제목)
        view.addSubview(설정_테이블뷰)
        
        뒤로가기_버튼.snp.makeConstraints { make in
            make.centerY.equalTo(페이지_제목.snp.centerY)
            make.leading.equalToSuperview().offset(16)
            make.size.equalTo(40)
        }
        페이지_제목.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10) // 상단 safe area로부터 10포인트 아래에 위치
            make.centerX.equalToSuperview()
            make.height.equalTo(44)
        }
        설정_테이블뷰.snp.makeConstraints { make in
            make.top.equalTo(페이지_제목.snp.bottom).offset(0)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-50)
        }
    }
    
     func 설정아이템들_구성() {
        설정아이템들 = [

            [
                설정아이템(title: "프로필 변경", isSwitchOn: false, action: {}),
                설정아이템(title: "이메일 변경", isSwitchOn: false, action: {}),
                설정아이템(title: "비밀번호 변경", isSwitchOn: false, action: {}),

            ],
            [설정아이템(title: "로그아웃", isSwitchOn: false, action: {})],
            [설정아이템(title: "회원 탈퇴", isSwitchOn: false, action: {})]
        ]
    }
}
