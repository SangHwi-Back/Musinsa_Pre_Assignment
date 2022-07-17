//
//  FooterCollectionReusableView.swift
//  MusinsaBeck
//
//  Created by 백상휘 on 2022/07/14.
//

import UIKit

enum MainFooterType: String, CaseIterable {
    case refresh = "REFRESH"
    case showMore = "MORE"
}

class FooterCollectionReusableView: UICollectionReusableView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    private(set) var type: MainFooterType = .showMore
    
    var delegate: MainViewDelegate?
    var section: Int?
    
    func setFooterData(_ footer: Footer?) {
        gestureRecognizers?.forEach({
            removeGestureRecognizer($0)
        })
        
        setTapGesture()
        
        if footer?.type == MainFooterType.refresh.rawValue.uppercased() {
            
            type = .refresh
            titleLabel.text = "새로운 추천"
            thumbnailImageView.isHidden = false
            thumbnailImageView.setImage(from: footer?.iconURL)
            
        } else {
            type = .showMore
            titleLabel.text = "더보기"
            thumbnailImageView.isHidden = true
            setNeedsDisplay()
        }
    }
    
    private func setTapGesture() {
        let gesture = UITapGestureRecognizer()
        
        gesture.addTarget(self, action: #selector(showMoreButtonTouchUpInside))
        
        addGestureRecognizer(gesture)
        isUserInteractionEnabled = true
    }
    
    @objc func showMoreButtonTouchUpInside() {
        if let section = section {
            delegate?.didSelectReusableView(section, reusableView: self)
        }
    }
}
