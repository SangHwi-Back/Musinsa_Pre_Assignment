//
//  HeaderCollectionReusableView.swift
//  MusinsaBeck
//
//  Created by 백상휘 on 2022/07/14.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
    
    func setHeaderData(_ header: Header?) {
        
        headerImageView.isHidden = (header?.iconURL == nil)
        headerTitleLabel.text = header?.title
        
        if let urlString = header?.linkURL {
            openURL = URL(string: urlString)
        }
        
        if let urlString = header?.iconURL {
            iconURL = URL(string: urlString)
            headerImageView.isHidden = false
        } else {
            headerImageView.isHidden = true
        }
    }
    
    var openURL: URL?
    var iconURL: URL? {
        didSet {
            self.setHeaderImage()
        }
    }
    
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
            return
        }
        
        URLSession.shared.dataTask(with: iconURL) { data, _, _ in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async { [weak self] in
                    self?.headerImageView.isHidden = false
                    self?.headerImageView.image = image
                }
            } else {
                self.headerImageView.isHidden = true
            }
        }.resume()
    }
}

extension UICollectionReusableView {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}
