
import Foundation

struct 유저정보 {
    var 사용자프로필이미지: String
    var 사용자프로필이름: String
    let 마이페이지_유저정보 = [(사용자프로필이미지: "cabanel", 사용자프로필이름: "박철우"),(사용자프로필이미지: "gyesung", 사용자프로필이름: "조계성")]
}
struct 전시정보_택스트 {
    
    var 전시아티스트이름: String
    var 전시장소이름: String
    var 본문제목: String
    var 본문내용: String

    let 인기_전시정보 =
        [(전시아티스트이름: "Alexandre Cabanel",
          전시장소이름: "musée du Louvre",
          본문제목: "Ô Lucifer",
          본문내용: """
          '타락한 천사’는 19세기 프랑스 화가 알렉상드르 카바넬(Alexandre Cabanel)의 작품이다. 에두아르 마네를 구심점으로 새로운 미술 운동인 인상주의가 태동하고 있을 때, 카바넬은 아카데믹한 고전주의 양식으로 작업한 제도권 미술계의 총아였다. 그는 신화와 역사, 성서 이야기를 주제로 하는 역사화, 종교화를 그렸다.이 장르의 전통적인 테마는 성인, 천사, 영웅적인 인물이었는데, 카바넬은 ‘타락한 천사’에서 악마를 묘사해 당대 많은 논란을 일으켰다.
          """),
         (전시아티스트이름: "various artists",
          전시장소이름: "uijungbu art library",
          본문제목: "Des nuages",
          본문내용: """
          철우님 그리고 제 생각엔 네비게이션 바 말고 그냥 타이틀 레이블 만들어서 위로 올린다 컬렉션 뷰의 가로 길이를 화면 가로 길이로 맞춰야 할거 같아용 지금 컬렉션 뷰 영역이 화면 가로 길이가 아니고 살짝 왼쪽에서 떨어진거 같은데 어차피 컬렉션 뷰는 셀 밑에 깔리는 거고 셀이 보여지는거니까 컬렉션 뷰 영역은 그냥 가로 길이 전체로 하는게 나은거 같아요 셀은 페이징 효과 넣어서 가운데로 정렬 하게 하면 되니까 그렇게 수정 부탁 드립니당
          """)]
}

struct 전시정보_이미지 {
    var 전시이미지묶음: [[String]] = [["morningStar", "help"], ["renee", "henri"]]
}