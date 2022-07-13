//
//  UseCaseResponsible.swift
//  MusinsaBeck
//
//  Created by 백상휘 on 2022/07/13.
//

import Foundation

class UseCaseResponsible: Disposable {
    var container: UseCaseContainer
    
    init(container: UseCaseContainer) {
        self.container = container
    }
}
