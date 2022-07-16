//
//  FooterCollectionReusableView.swift
//  MusinsaBeck
//
//  Created by 백상휘 on 2022/07/14.
//

import UIKit

class FooterCollectionReusableView: UICollectionReusableView {
    
    @IBOutlet weak var showMoreButton: UIButton!
    
    @IBAction func showMoreButtonTouchUpInside(_ sender: UIButton) {
        
    }
    
    func setFooterData(_ footer: Footer?) {
        if footer?.type == "REFRESH" {
            showMoreButton.setTitle("새로운 추천", for: .normal)
            showMoreButton.setImage(UIImage(systemName: "goforward"), for: .normal)
        } else {
            showMoreButton.setTitle("더보기", for: .normal)
            showMoreButton.setImage(nil, for: .normal)
        }
    }
}
