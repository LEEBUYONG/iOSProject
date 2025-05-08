//
//  Viedeo.swift
//  NetflixCloneApp_BY
//
//  Created by iOS study on 5/8/25.
//

import Foundation

struct VideoResponse: Codable {
    let results: [Video]
}

struct Video: Codable {
    let key: String?
    let site: String?
    let type: String?
}
