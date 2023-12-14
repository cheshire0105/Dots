//
//  ExhibitionModel.swift
//  Dots
//
//  Created by cheshire on 11/8/23.
//

import Foundation

struct ExhibitionModel {
    var title: String
    var poster: String
    var period: String  // 전시 기간
    var likes: Int  // 좋아요 수
    var visits: Int  // '다녀옴' 수를 저장하는 필드


    init(dictionary: [String: Any]) {
        self.title = dictionary["전시_타이틀"] as? String ?? "Unknown Title"
        self.poster = dictionary["전시_포스터"] as? String ?? "Unknown Poster"
        self.period = dictionary["전시_날짜"] as? String ?? "Unknown Period"
        self.likes = dictionary["visits"] as? Int ?? 0  // 'likes' 필드도 초기화
        self.visits = dictionary["visits"] as? Int ?? 0  // 'visits' 필드로 초기화

    }
}



struct ExhibitionDetailModel {
    var museumName: String   // 미술관 이름
    var museumAddress: String // 미술관 주소
    var artistCount: String   // 작가 수
    var artworkCount: String  // 작품 수
    var exhibitionPrice: String // 전시 가격
    var exhibitionDates: String // 전시 날짜
    var exhibitionHours: String // 전시 시간
    var exhibitionTitle: String // 전시 타이틀
    var exhibitionGeo : String // 전시 좌표
    var exhibitionDetail : String // 전시 설명

    init(dictionary: [String: Any]) {
        self.museumName = dictionary["미술관_이름"] as? String ?? "Unknown Title"
        self.museumAddress = dictionary["미술관_주소"] as? String ?? "Unknown Title"
        self.artistCount = dictionary["작가_수"] as? String ?? "Unknown Title"
        self.artworkCount = dictionary["작품_수"] as? String ?? "Unknown Title"
        self.exhibitionPrice = dictionary["전시_가격"] as? String ?? "Unknown Title"
        self.exhibitionDates = dictionary["전시_날짜"] as? String ?? "Unknown Title"
        self.exhibitionHours = dictionary["전시_시간"] as? String ?? "Unknown Title"
        self.exhibitionTitle = dictionary["전시_타이틀"] as? String ?? "Unknown Title"
        self.exhibitionGeo = dictionary["전시_좌표"] as? String ?? "Unknown Title"
        self.exhibitionDetail = dictionary["전시_설명"] as? String ?? "Unknown Title"
    }
}

