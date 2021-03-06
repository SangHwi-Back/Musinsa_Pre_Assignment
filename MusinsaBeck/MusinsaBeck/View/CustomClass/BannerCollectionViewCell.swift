//
//  BannerCollectionViewCell.swift
//  MusinsaBeck
//
//  Created by 백상휘 on 2022/07/14.
//

import UIKit
import os.log

class BannerCollectionViewCell: UICollectionViewCell, MainCollectionViewCell {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var firstLeadingView: UIView?
    @IBOutlet weak var pageButton: CommonRoundedButton!
    
    var data: Any?
    
    func setData(_ cellType: MainCellType) {
        guard let data = data as? [Any] else {
            return
        }
        
        layoutIfNeeded()
        
        scrollView.delegate = self
        scrollView.subviews.forEach {
            $0.removeFromSuperview()
        }
        
        for (index, entity) in data.enumerated() {
            
            guard let entity = entity as? Banners else {
                continue
            }
            
            let imageView = LinkedUIImageView(frame: scrollView.frame)
            
            scrollView.addSubview(imageView)
            imageView.frame.origin = CGPoint(x: CGFloat(index) * scrollView.frame.width, y: 0)
            imageView.openURL = URL(string: entity.linkURL)
            imageView.setImage(from: entity.thumbnailURL)
        }
        
        if let lastView = scrollView.subviews.last {
            pageButton.setTitle("1 / \(data.count) >", for: .normal)
            pageButton.backgroundColor = pageButton.backgroundColor?.withAlphaComponent(0.5)
            scrollView.contentSize = CGSize(width: lastView.frame.maxX, height: scrollView.frame.height)
        }
    }
}

extension BannerCollectionViewCell: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let lastString = pageButton.currentTitle?.split(separator: "/").last {
            
            let currentImageViewCenterX = scrollView.contentOffset.x + (scrollView.frame.width / 2)
            let number = Int(floor(currentImageViewCenterX / scrollView.frame.width))+1
            pageButton.setTitle("\(number) /\(lastString)", for: .normal)
        }
    }
}

class LinkedUIImageView: UIImageView {
    
    var openURL: URL?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setGesture()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setGesture()
    }
    
    private func setGesture() {
        if let gestures = gestureRecognizers {
            gestures.forEach {
                removeGestureRecognizer($0)
            }
        }
        
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(openExternalURL))
        addGestureRecognizer(tapGesture)
        isUserInteractionEnabled = true
    }
    
    @objc func openExternalURL() {
        if let url = openURL {
            UIApplication.shared.open(url)
        } else {
            os_log("Unnecessary URL \(self.openURL?.absoluteString ?? "Unknown").")
        }
    }
    
    override func draw(_ layer: CALayer, in ctx: CGContext) {
        super.draw(layer, in: ctx)
        print(index)
    }
}
