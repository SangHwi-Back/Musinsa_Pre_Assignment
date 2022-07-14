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
        
        var width: CGFloat = 0
        var height: CGFloat = 0
        
        switch dataSource.getCellType(indexPath) {
        case .scroll:
            width = collectionView.frame.width
            height = collectionView.frame.width / 3
        case .grid:
            width = (collectionView.frame.width / 3) - (itemSpacing * 3)
            height = (collectionView.frame.width / 3)
        case .style:
            width = (collectionView.frame.width / 2) - (itemSpacing * 2)
            height = (collectionView.frame.width / 2)
        case .banner:
            width = collectionView.frame.width
            height = collectionView.frame.width
        case .none:
            width = 0
            height = 0
        }
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        lineSpacing
    }
}

extension MainViewController: UICollectionViewDelegate {
}
