//
//  MusinsaBeckTests.swift
//  MusinsaBeckTests
//
//  Created by 백상휘 on 2022/07/13.
//

import XCTest
@testable import MusinsaBeck

class MusinsaBeckTests: XCTestCase {
    let disposeBag = DisposeBag()
    
    func testDisposable() throws {
        
        var disposables = [Disposable]()
        var disposables2 = [Disposable]()
        
        measure(metrics: [XCTMemoryMetric()]) {
            for _ in 0..<10 {
                disposables.append(Disposable())
                disposables2.append(Disposable())
            }
            
            disposables.forEach {
                $0.disposed(by: self.disposeBag)
            }
            
            disposeBag.dispose()
            disposables2.removeAll()
        }
    }
}
