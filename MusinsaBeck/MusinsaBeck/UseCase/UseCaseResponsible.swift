//
//  UseCaseResponsible.swift
//  MusinsaBeck
//
//  Created by 백상휘 on 2022/07/13.
//

import Foundation

class UseCaseResponsible: Disposable {
    private(set) var container: UseCaseContainer
    
    required init(container: UseCaseContainer) { // Compiler에게 container가 반드시 정의되어야 한다고 알려주기 위해 사용합니다.
        self.container = container
    }
}
