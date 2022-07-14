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
    
    func getUseCase(_ usecaseType: UseCaseResponsible.Type) -> UseCaseResponsible {
        // disposables 안의 요소들의 메타 타입을 파라미터(메타타입)과 비교하여 일치하면 재사용 합니다.
        guard let result = disposeBag.disposables.first(where: { type(of: $0) == usecaseType }) as? UseCaseResponsible else {
            let disposable = usecaseType.init(container: self) // Calling 'required' initializer thanks to metatype.
            disposable.disposed(by: disposeBag)
            return disposable
        }
        
        return result
    }
}
