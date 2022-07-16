//
//  GridItemCollectionViewCell.swift
//  MusinsaBeck
//
//  Created by 백상휘 on 2022/07/14.
//

import UIKit

class GridItemCollectionViewCell: UICollectionViewCell, MainCollectionViewCell {
    var data: Any?
    
    func setData(_ cellType: MainCellType) {
        guard let data = data as? Goods else {
            return
        }
        
        contentView.subviews.forEach {
            $0.removeFromSuperview()
        }
        
        layoutIfNeeded()
        
        if
            let views = Bundle.main.loadNibNamed("ContentsCollectionViewCell", owner: nil) as? [UIView],
            views.count >= 1,
            let superview = views[1] as? ContentsCollectionView
        {
            contentView.addSubview(superview)
            superview.frame = contentView.bounds
            
            superview.linkedImageView.openURL = URL(string: data.linkURL)
            superview.titleLabel.text = data.brandName
            superview.descriptionLabel.text = "\(data.price) \(data.saleRate)%"
            superview.couponLabel.isHidden = !data.hasCoupon
            superview.linkedImageView.setImage(from: data.thumbnailURL)
        }
    }
}
