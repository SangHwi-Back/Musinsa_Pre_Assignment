//
//  ScrollCollectionViewCell.swift
//  MusinsaBeck
//
//  Created by 백상휘 on 2022/07/14.
//

import UIKit

class ScrollCollectionViewCell: UICollectionViewCell, MainCollectionViewCell {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var firstLeadingView: UIView?
    
    var data: Any?
    
    func setData(_ cellType: MainCellType) {
        guard let data = data as? [Goods] else {
            return
        }
        
        scrollView.subviews.forEach {
            $0.removeFromSuperview()
        }
        
        layoutIfNeeded()
        
        for entity in data {
            
            if
                let views = Bundle.main.loadNibNamed("ContentsCollectionViewCell", owner: nil) as? [UIView],
                views.count >= 1,
                let superview = views[1] as? ContentsCollectionView
            {
                let lastView = scrollView.subviews.last ?? UIView()
                
                scrollView.addSubview(superview)
                superview.frame = CGRect(
                    origin: CGPoint(x: lastView.frame.maxX, y: 0),
                    size: CGSize(width: scrollView.frame.height / 1.6, height: scrollView.frame.height)
                )
                
                superview.linkedImageView.openURL = URL(string: entity.linkURL)
                superview.titleLabel.text = entity.brandName
                superview.descriptionLabel.text = "\(entity.price) \(entity.saleRate)%"
                superview.couponLabel.isHidden = !entity.hasCoupon
                
                if let url = URL(string: entity.thumbnailURL) {
                    URLSession.shared.dataTask(with: url) { data, _, _ in
                        if let data = data {
                            DispatchQueue.main.async {
                                superview.linkedImageView.image = UIImage(data: data)
                            }
                        }
                    }.resume()
                }
            }
            
            if let lastView = scrollView.subviews.last {
                scrollView.contentSize = CGSize(width: lastView.frame.maxX, height: scrollView.frame.height)
            }
        }
    }
}
