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

    // 딕셔너리로부터 초기화하는 initializer를 추가합니다.
    init(dictionary: [String: Any]) {
        self.title = dictionary["전시_타이틀"] as? String ?? "Unknown Title"
        self.poster = dictionary["전시_포스터"] as? String ?? "Unknown Poster"
    }

}

