//
//  RequestInterviewUseCase.swift
//  MusinsaBeck
//
//  Created by 백상휘 on 2022/07/13.
//

import Foundation

class RequestInterviewUseCase: UseCaseResponsible {
    
    required init(container: UseCaseContainer) {
        super.init(container: container)
    }
    
    private(set) var listModel: InterViewListModel?
    
    func request(_ completionHandler: @escaping (Result<InterViewListModel, Error>)->Void) {
        
        RequestURLModel().getRequest { requestResult, disposable in
            guard let requestResult = requestResult as? Data else {
                completionHandler(.failure(RequestError.networkRequest))
                return
            }
            
            guard let result = ResponseDecodeModel<InterviewList>().decode(requestResult) else {
                completionHandler(.failure(RequestError.decodeFailed))
                return
            }
            
            let model = InterViewListModel(list: result, from: requestResult)
            self.listModel = model
            
            completionHandler(.success(model))
            
            self.container.disposeBag.insert(disposable)
        }
    }
    
    deinit {
        container.disposeBag.dispose()
    }
}

enum RequestError: Error {
    case networkRequest
    case decodeFailed
}
