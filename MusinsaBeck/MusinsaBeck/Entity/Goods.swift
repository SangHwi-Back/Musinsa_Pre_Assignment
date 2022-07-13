//
//  Goods.swift
//  MusinsaBeck
//
//  Created by 백상휘 on 2022/07/13.
//

import Foundation

struct Goods: Codable {
    let linkURL: String
    let thumbnailURL: String
    let brandName: String
    let price: Int
    let saleRate: Int
    let hasCoupon: Bool
}
