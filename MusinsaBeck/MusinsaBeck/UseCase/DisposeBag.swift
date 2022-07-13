//
//  Disposable.swift
//  MusinsaBeck
//
//  Created by 백상휘 on 2022/07/13.
//

import Foundation

class DisposeBag {
    private var lock = NSRecursiveLock()
    
    var disposables = [Disposable]()
    var isDisposed = false
    
    func insert(_ disposable: Disposable) {
        _insert(disposable)?.dispose()
    }
    
    private func _insert(_ disposable: Disposable) -> Disposable? {
        lock.performLocked {
            if self.isDisposed {
                return disposable
            }
            
            self.disposables.append(disposable)
            
            return nil
        }
    }
    
    func dispose() {
        let oldDisposables = self._dispose()

        for disposable in oldDisposables {
            disposable.dispose()
        }
    }
    
    private func _dispose() -> [Disposable] {
        lock.performLocked {
            let disposables = self.disposables
            
            self.disposables.removeAll(keepingCapacity: false)
            self.isDisposed = true
            
            return disposables
        }
    }
    
    deinit {
        self.dispose()
    }
}

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

extension NSRecursiveLock {
    func performLocked<T>(_ action: () -> T) -> T {
        self.lock()
        
        defer {
            self.unlock()
        }
        
        return action()
    }
}
