//
//  ExhibitionModel.swift
//  Dots
//
//  Created by cheshire on 11/8/23.
//

import Foundation

// 전시회 정보를 나타내는 모델
struct ExhibitionModel {
    var documentID: String    // Firestore에서 자동 생성된 문서 ID
    var museumName: String    // 미술관 이름
    var price: String         // 전시 가격
    var summary: String       // 전시 개요
    var duration: String      // 전시 기간
    var location: String      // 전시 장소
    var title: String         // 전시 제목
    var poster: String        // 전시 포스터의 URL

    // 딕셔너리에서 모델 인스턴스를 생성하기 위한 이니셜라이저.
    // Firestore에서 가져온 데이터를 이용해 초기화한다.
    init?(dictionary: [String: Any]) {
        guard let documentID = dictionary["서울_전시_1"] as? String, // 문서 ID 확인
              let museumName = dictionary["미술관_이름"] as? String, // 미술관 이름 확인
              let price = dictionary["전시_가격"] as? String, // 전시 가격 확인
              let summary = dictionary["전시_개요"] as? String, // 전시 개요 확인
              let duration = dictionary["전시_기간"] as? String, // 전시 기간 확인
              let location = dictionary["전시_장소"] as? String, // 전시 장소 확인
              let title = dictionary["전시_제목"] as? String, // 전시 제목 확인
              let poster = dictionary["전시_포스터"] as? String else { // 전시 포스터 URL 확인
            return nil // 하나라도 누락되면 nil을 반환하여 초기화 실패 처리
        }

        // 모든 값이 제대로 있으면 초기화를 진행한다.
        self.documentID = documentID
        self.museumName = museumName
        self.price = price
        self.summary = summary
        self.duration = duration
        self.location = location
        self.title = title
        self.poster = poster
    }
}


