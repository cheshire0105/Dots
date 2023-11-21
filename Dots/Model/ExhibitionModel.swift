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
    var period: String // 전시 기간 추가

    init(dictionary: [String: Any]) {
        self.title = dictionary["전시_타이틀"] as? String ?? "Unknown Title"
        self.poster = dictionary["전시_포스터"] as? String ?? "Unknown Poster"
        self.period = dictionary["전시_기간"] as? String ?? "Unknown Period"
    }
}




