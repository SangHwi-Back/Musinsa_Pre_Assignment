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
}
