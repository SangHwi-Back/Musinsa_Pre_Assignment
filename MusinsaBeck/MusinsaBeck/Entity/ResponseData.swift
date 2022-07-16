//
//  ResponseData.swift
//  MusinsaBeck
//
//  Created by 백상휘 on 2022/07/13.
//

import Foundation

struct ResponseData: Codable {
    let header: Header?
    var contents: Contents
    let footer: Footer?
}
