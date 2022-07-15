//
//  MainViewController.swift
//  MusinsaBeck
//
//  Created by 백상휘 on 2022/07/13.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    private let dataSource = MainCollectionViewDataSource()
    
    private let itemSpacing: CGFloat = 3
    private let lineSpacing: CGFloat = 15
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainCollectionView.dataSource = dataSource
        mainCollectionView.delegate = self
        dataSource.request {
            DispatchQueue.main.async {
                self.mainCollectionView.reloadData()
            }
        }
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let type = dataSource.getCellType(indexPath) else {
            return CGSize.zero
        }
        
        let layout = collectionViewLayout as? UICollectionViewFlowLayout
        var width: CGFloat, height: CGFloat = 0
        
        let interimSpacing = layout?.minimumInteritemSpacing ?? itemSpacing
        let lineWidth = collectionView.frame.width
        let lineSpacing = (2 * (layout?.minimumLineSpacing ?? lineSpacing))
        
        switch type {
        case .banner:
            width = lineWidth
            height = lineWidth
        case .scroll:
            width = lineWidth; height = lineWidth / 3
        case .grid:
            width = ((lineWidth - lineSpacing) / 3) - (interimSpacing)
            height = ((lineWidth - lineSpacing) / 3)
        case .style:
            width = ((lineWidth - lineSpacing) / 2) - (interimSpacing * 2)
            height = width * 1.5
        }
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        guard let cellType = dataSource.getCellType(section), let layout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return lineSpacing
        }
        
        let lineSpacing = 2 * (layout.minimumLineSpacing)
        
        switch cellType {
        case .banner, .scroll:
            return 0
        case .grid, .style:
            return lineSpacing
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let sectionInset = (collectionViewLayout as? UICollectionViewFlowLayout)?.sectionInset
        let verticalSpacing = sectionInset?.top ?? lineSpacing
        var horizontalSpacing = sectionInset?.left ?? lineSpacing
        
        if let type = dataSource.getCellType(section), [.scroll, .banner].contains(type) {
            horizontalSpacing = 0
        }
        
        return UIEdgeInsets(
            top: verticalSpacing,
            left: horizontalSpacing,
            bottom: verticalSpacing,
            right: horizontalSpacing
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        let height: CGFloat = dataSource.isHeaderHidden(section) ? 0 : 50
        return CGSize(width: collectionView.frame.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        let height: CGFloat = dataSource.isFooterHidden(section) ? 0 : 50
        return CGSize(width: collectionView.frame.width, height: height)
    }
}
