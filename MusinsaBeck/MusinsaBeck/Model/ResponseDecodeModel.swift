//
//  ResponseDecodeModel.swift
//  MusinsaBeck
//
//  Created by 백상휘 on 2022/07/13.
//

import Foundation

class ResponseDecodeModel<T: Decodable>: Disposable {
    
    private let decoder = JSONDecoder()
    
    func decode(_ data: Data) -> [T]? {
        try? decoder.decode([T].self, from: data)
    }
}
