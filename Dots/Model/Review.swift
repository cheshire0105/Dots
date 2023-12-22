//
//  Review.swift
//  Dots
//
//  Created by cheshire on 12/4/23.
//

import Foundation

struct Review {
    var title: String
    var content: String
    var createdAt: Date
    var nickname: String
    var profileImageUrl: String
    var photoUrls: [String]
    var userId: String
    var userReviewUUID: String // 사용자 리뷰의 UUID를 저장하는 프로퍼티 추가
    var posterName: String?
    var likes: [String: Bool] // 사용자 ID와 좋아요 상태를 저장하는 딕셔너리

}




