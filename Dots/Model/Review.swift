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
    var photoUrls: [String] // 유저가 올린 사진들의 URL
    var userId: String // 리뷰 작성자의 고유 식별자
}



