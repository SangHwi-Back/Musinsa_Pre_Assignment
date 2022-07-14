//
//  UseCaseContainer.swift
//  MusinsaBeck
//
//  Created by 백상휘 on 2022/07/13.
//

import Foundation

class UseCaseContainer {
    static let shared = UseCaseContainer()
    let disposeBag = DisposeBag()
    
    func getUseCase(_ type: UseCaseResponsible.Type) -> UseCaseResponsible {
        return type.init(container: self) // Calling 'required' initializer thanks to metatype.
    }
}
