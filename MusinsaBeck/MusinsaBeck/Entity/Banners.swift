//
//  Banners.swift
//  MusinsaBeck
//
//  Created by 백상휘 on 2022/07/13.
//

import Foundation

struct Banners: Codable {
    let linkURL: String
    let thumbnailURL: String
    let title: String
    let desc: String // 원래는 description. CustomStringConvertible 의 var description: String 프로퍼티와 중복될 우려가 있어서 변경합니다.
    let keyword: String
    
    enum CodingKeys: String, CodingKey {
        case linkURL
        case thumbnailURL
        case title
        case desc = "description"
        case keyword
    }
}
