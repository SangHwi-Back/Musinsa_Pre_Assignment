//
//  RequestURLModel.swift
//  MusinsaBeck
//
//  Created by 백상휘 on 2022/07/13.
//

import Foundation

class RequestURLModel: Disposable {
    private var urlString: String = "https://meta.musinsa.com/interview/list.json"
    
    func getRequest(_ completionHandler: @escaping (Any, Disposable)->Void) {
        guard let url = URL(string: urlString) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, _, _ in
            if let data = data {
                completionHandler(data, self)
            }
        }.resume()
    }
    
    func postRequest(_ completionHandler: @escaping (Any, Disposable)->Void) {
        guard let url = URL(string: urlString) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
    }
}
