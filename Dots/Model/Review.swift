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
    var nickname: String // 현재는 userId를 사용하지만, 이를 닉네임으로 변환하는 로직이 필요합니다.
    // 이미지 URL, 좋아요 수, 조회수 등 필요한 추가 필드를 여기에 포함시킵니다.
}
