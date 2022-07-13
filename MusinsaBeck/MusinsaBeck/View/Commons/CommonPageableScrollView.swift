//
//  CommonPageableScrollView.swift
//  MusinsaBeck
//
//  Created by 백상휘 on 2022/07/13.
//

import UIKit

/// Paging을 목적으로 하는 ScrollView를 미리 생성해 놓습니다.
class CommonPageableScrollView: UIScrollView {
    
    private var images = [PageableImage]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setImages(_ image: PageableImage) -> Int {
        
        if let index = images.firstIndex(where: { $0.url == image.url }) {
            images[index] = image
        } else {
            images.append(image)
        }
        
        return images.count
    }
}

struct PageableImage {
    let url: URL
    let image: Data
}
