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
    
    private var listCount = MainCellListCount()
    private(set) var currentListCount = MainCellListCount()
    
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
    
    func reloadSectionsCount() {
        listCount.grid = 0
        listCount.style = 0
        
        for (index, entity) in entities.enumerated() {
            switch cellType(index) {
            case .grid:
                listCount.grid += (entity.contents.goods?.count ?? 0)
            case .style:
                listCount.style += (entity.contents.styles?.count ?? 0)
            default:
                continue
            }
        }
        
        showMoreButtonTouchUpInside(.grid)
        showMoreButtonTouchUpInside(.style)
    }
    
    func showMoreButtonTouchUpInside(_ cellType: MainCellType) {
        if cellType == .grid {
            currentListCount.grid += 6
            
            if listCount.grid < currentListCount.grid {
                currentListCount.grid = listCount.grid
            }
        }
        
        if cellType == .style {
            currentListCount.style += 4
            
            if listCount.style < currentListCount.style {
                currentListCount.style = listCount.style
            }
        }
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

struct MainCellListCount {
    let banner = 1
    var grid = 0
    let scroll = 1
    var style = 0
    
    func getCount(type: MainCellType) -> Int {
        switch type {
        case .grid:
            return grid
        case .scroll:
            return scroll
        case .banner:
            return banner
        case .style:
            return style
        }
    }
}
