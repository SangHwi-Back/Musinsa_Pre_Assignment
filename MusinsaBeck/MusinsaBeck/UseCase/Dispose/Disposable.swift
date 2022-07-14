//
//  Disposable.swift
//  MusinsaBeck
//
//  Created by 백상휘 on 2022/07/13.
//

import Foundation

class Disposable {
    private let isStopped = AtomicInt(0)
    
    func dispose() {
        fetchOr(self.isStopped, 1)
    }
    
    func disposed(by bag: DisposeBag) {
        bag.insert(self)
    }
}

final class AtomicInt: NSLock {
    fileprivate var value: Int32
    public init(_ value: Int32 = 0) {
        self.value = value
    }
}

@discardableResult
@inline(__always)
func fetchOr(_ this: AtomicInt, _ mask: Int32) -> Int32 {
    this.lock()
    let oldValue = this.value
    this.value |= mask
    this.unlock()
    return oldValue
}
