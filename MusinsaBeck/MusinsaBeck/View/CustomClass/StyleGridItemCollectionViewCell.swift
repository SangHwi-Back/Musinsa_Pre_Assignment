//
//  StyleGridItemCollectionViewCell.swift
//  MusinsaBeck
//
//  Created by 백상휘 on 2022/07/14.
//

import UIKit

class StyleGridItemCollectionViewCell: UICollectionViewCell, MainCollectionViewCell {
    var data: Any?
    
    func setData(_ cellType: MainCellType) {
        guard let data = data as? Styles else {
            return
        }
        
        contentView.subviews.forEach {
            $0.removeFromSuperview()
        }
        
        layoutIfNeeded()
        
        if
            let views = Bundle.main.loadNibNamed("ContentsCollectionViewCell", owner: nil) as? [UIView],
            views.count >= 2,
            let superview = views[2] as? StyleCollectionView
        {
            contentView.addSubview(superview)
            superview.frame = contentView.bounds
            superview.linkedImageView.openURL = URL(string: data.linkURL)
            superview.playButton.layer.borderWidth = 1
            superview.playButton.layer.borderColor = UIColor.label.cgColor
            superview.linkedImageView.setImage(from: data.thumbnailURL)
        }
    }
}
