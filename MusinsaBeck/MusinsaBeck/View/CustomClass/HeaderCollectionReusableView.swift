//
//  HeaderCollectionReusableView.swift
//  MusinsaBeck
//
//  Created by 백상휘 on 2022/07/14.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
    
    func setHeaderData(_ header: Header?) {
        
        headerTitleLabel.text = header?.title
        
        let urlString = header?.linkURL
        linkedButton.setTitle(urlString == nil ? "" : "전체", for: .normal)
        openURL = (urlString == nil ? nil : URL(string: urlString!))
        linkedButton.isUserInteractionEnabled = (openURL != nil)
        
        headerImageView.setImage(from: header?.iconURL)
        headerImageView.isHidden = header?.iconURL == nil
    }
    
    private var openURL: URL?
    private var iconURL: URL?
    
    @IBOutlet weak var headerStackView: UIStackView!
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var headerTitleLabel: UILabel!
    
    @IBOutlet weak var linkedButton: UIButton!
    
    @IBAction func linkedButtonTouchUpInside(_ sender: UIButton) {
        guard let openURL = openURL else {
            return
        }
        
        UIApplication.shared.open(openURL)
    }
    
    private func setHeaderImage() {
        guard let iconURL = iconURL else {
            self.headerImageView.isHidden = true
            return
        }
        
        headerImageView.setImage(from: iconURL)
    }
}
