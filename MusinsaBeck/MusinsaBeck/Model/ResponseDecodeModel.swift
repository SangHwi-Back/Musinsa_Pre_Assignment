//
//  ResponseDecodeModel.swift
//  MusinsaBeck
//
//  Created by 백상휘 on 2022/07/13.
//

import Foundation

class ResponseDecodeModel<T: Decodable>: Disposable {
    
    private let decoder = JSONDecoder()
    
    func decode(_ data: Data) -> T? {
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch DecodingError.dataCorrupted(let context) {
            print(context)
        } catch DecodingError.keyNotFound(let key, let context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch DecodingError.valueNotFound(let value, let context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch DecodingError.typeMismatch(let type, let context) {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print("error: ", error)
        }
        
        return nil
    }
}
