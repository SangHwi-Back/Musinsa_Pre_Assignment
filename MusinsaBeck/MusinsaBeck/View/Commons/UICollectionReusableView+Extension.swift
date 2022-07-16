//
//  UICollectionReusableView+Extension.swift
//  MusinsaBeck
//
//  Created by 백상휘 on 2022/07/16.
//

import UIKit

extension UICollectionReusableView {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}
