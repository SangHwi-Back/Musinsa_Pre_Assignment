//
//  ResponseDecodeModel.swift
//  MusinsaBeck
//
//  Created by 백상휘 on 2022/07/13.
//

import Foundation
import os.log

class ResponseDecodeModel<T: Decodable>: Disposable {
    
    private let decoder = JSONDecoder()
    
    func decode(_ data: Data) -> T? {
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            logError(error)
        }
        return nil
    }
    
    private func logError(_ error: Error) {
        
        let logger = Logger()
        
        switch error {
        case DecodingError.dataCorrupted(let context):
            logger.log(level: .debug, "[ResponseDecodeError] dataCorrupted.\n\(context.debugDescription)")
        case DecodingError.keyNotFound(let key, let context):
            logger.log(level: .info, "[ResponseDecodeError] keyNotFound.\nKey : \(key.stringValue), Description : \(context.debugDescription)")
        case DecodingError.valueNotFound(let value, let context):
            logger.log(level: .info, "[ResponseDecodeError] valueNotFound.\nValue : \(value), Description : \(context.debugDescription)")
        case DecodingError.typeMismatch(let type, let context):
            logger.log(level: .info, "[ResponseDecodeError] typeMismatch.\nType : \(type), Description : \(context.debugDescription)")
        default:
            logger.log(level: .debug, "\(error.localizedDescription)")
            return
        }
    }
}
