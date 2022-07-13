//
//  RequestInterviewUseCase.swift
//  MusinsaBeck
//
//  Created by 백상휘 on 2022/07/13.
//

import Foundation

class RequestInterviewUseCase: UseCaseResponsible {
    
    override init(container: UseCaseContainer) {
        super.init(container: container)
    }
    
    let urlRequestModel = RequestURLModel()
    let responseDecodeModel = ResponseDecodeModel<InterviewList>()
    
    func request(_ completionHandler: @escaping (Result<[InterviewList], Error>)->Void) {
        
        urlRequestModel.getRequest { requestResult, disposable in
            guard let requestResult = requestResult as? Data else {
                completionHandler(.failure(RequestError.networkRequest))
                return
            }
            
            guard let result = self.responseDecodeModel.decode(requestResult) else {
                completionHandler(.failure(RequestError.decodeFailed))
                return
            }
            
            completionHandler(.success(result))
            
            self.container.disposeBag.insert(disposable)
        }
    }
}

enum RequestError: Error {
    case networkRequest
    case decodeFailed
}
