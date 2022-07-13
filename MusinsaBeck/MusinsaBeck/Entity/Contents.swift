//
//  Contents.swift
//  MusinsaBeck
//
//  Created by 백상휘 on 2022/07/13.
//

import Foundation

struct Contents: Codable {
    let type: String
    let banners: [Banners]?
    let goods: [Goods]?
    let styles: [Styles]?
}
