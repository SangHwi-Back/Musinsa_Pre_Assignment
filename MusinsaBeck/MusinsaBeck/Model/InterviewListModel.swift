//
//  InterviewListModel.swift
//  MusinsaBeck
//
//  Created by 백상휘 on 2022/07/14.
//

import Foundation

class InterviewListModel {
    private(set) var data: Data
    private(set) var list: InterviewList
    
    var entities: [ResponseData] {
        list.data
    }
    
    subscript(index: Int) -> ResponseData? {
        get {
            guard check(index) else {
                return nil
            }
            
            return list.data[index]
        }
    }
    
    init(list: InterviewList, from data: Data) {
        self.list = list
        self.data = data
    }
    
    func setList(_ list: InterviewList) {
        self.list = list
    }
    
    func setData(_ data: Data) {
        self.data = data
    }
    
    func entityCount() -> Int {
        list.data.count
    }
    
    func cellType(_ section: Int) -> MainCellType? {
        contents(section)?.type.cellType()
    }
    
    // MARK: - Need to check index.
    func contents(_ index: Int) -> Contents? {
        guard check(index) else {
            return nil
        }
        
        return list.data[index].contents
    }
    
    func header(_ index: Int) -> Header? {
        guard check(index) else {
            return nil
        }
        
        return list.data[index].header
    }
    
    func footer(_ index: Int) -> Footer? {
        guard check(index) else {
            return nil
        }
        
        return list.data[index].footer
    }
    
    // MARK: - Check index
    private func check(_ index: Int) -> Bool {
        return index >= 0 && list.data.count > index
    }
}
