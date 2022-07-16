//
//  CommonRoundedButton.swift
//  MusinsaBeck
//
//  Created by 백상휘 on 2022/07/13.
//

import UIKit

class CommonRoundedButton: UIButton {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        makeUI()
    }
    
    private func makeUI() {
        layer.opacity = 0.3
        layer.cornerRadius = frame.height / 2
        layer.masksToBounds = true
    }
}
