//
//  Disposable.swift
//  MusinsaBeck
//
//  Created by 백상휘 on 2022/07/13.
//

import Foundation

final class DisposeBag {
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

extension NSRecursiveLock {
    func performLocked<T>(_ action: () -> T) -> T {
        self.lock()
        
        defer {
            self.unlock()
        }
        
        return action()
    }
}
