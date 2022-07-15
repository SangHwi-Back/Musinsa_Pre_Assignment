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
    
    var data: Any?
    
    func setData(_ cellType: MainCellType) {
        guard let data = data as? [Any] else {
            return
        }
        
        layoutIfNeeded()
        
        scrollView.subviews.forEach {
            $0.removeFromSuperview()
        }
        
        var count = 5
        for entity in data {
            
            count -= 1
            guard count != 0 else {
                break
            }
            
            guard let entity = entity as? Banners else {
                continue
            }
            
            let lastView = scrollView.subviews.last ?? UIView()
            let imageView = LinkedUIImageView(frame: scrollView.frame)
            
            scrollView.addSubview(imageView)
            imageView.frame.origin = CGPoint(x: lastView.frame.maxX, y: 0)
            imageView.openURL = URL(string: entity.linkURL)
            
            if let url = URL(string: entity.thumbnailURL) {
                URLSession.shared.dataTask(with: url) { data, _, _ in // Asynchronous
                    if let data = data {
                        DispatchQueue.main.async {
                            imageView.image = UIImage(data: data)
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
}
