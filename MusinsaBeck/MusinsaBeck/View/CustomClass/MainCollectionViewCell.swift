//
//  MainCollectionViewCell.swift
//  MusinsaBeck
//
//  Created by 백상휘 on 2022/07/14.
//

import Foundation

protocol MainCollectionViewCell {
    var data: Any? { get set }
    /// Set UI elements from Nib Using local attribute 'data'.
    func setData(_ cellType: MainCellType)
}
