//
//  MainCollectionViewDataSource.swift
//  MusinsaBeck
//
//  Created by 백상휘 on 2022/07/14.
//

import UIKit
import os.log

enum MainCellType: String, CaseIterable {
    case grid = "GRID"
    case scroll = "SCROLL"
    case banner = "BANNER"
    case style = "STYLE"
}

class MainCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    private var listModel: InterviewListModel?
    
    private let requestUseCase = UseCaseContainer.shared.getUseCase(RequestInterviewUseCase.self) as? RequestInterviewUseCase
    
    func request(_ completionHandler: @escaping () -> Void) {
        requestUseCase?.request({ result in
            switch result {
            case .success(let model):
                self.listModel = model
                completionHandler()
            case .failure(_):
                os_log("Request interviewListFailed")
                completionHandler()
            }
        })
    }
    
    func getCellType(_ indexPath: IndexPath) -> MainCellType? {
        guard let data = listModel?.list.data[indexPath.section].contents else {
            return nil
        }
        
        return data.type.cellType()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return listModel?.list.data.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let data = listModel?.list.data[section].contents else {
            return 0
        }
        
        var array: [Any]?
        let cellType = data.type.cellType()
        
        if cellType == .grid {
            array = data.goods
        } else if cellType == .banner || cellType == .scroll {
            array = [""]
        } else if cellType == .style {
            array = data.styles
        }
        
        return array?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let model = listModel?.list.data[indexPath.section].contents, let cellType = indexPath.cellType() else {
            os_log("MainCollectionView reuse cell Failed.")
            return UICollectionViewCell()
        }
        
        var cell: MainCollectionViewCell?
        
        switch cellType {
        case .grid:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: GridItemCollectionViewCell.reuseIdentifier, for: indexPath) as? GridItemCollectionViewCell
            cell?.data = model.goods
        case .banner:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionViewCell.reuseIdentifier, for: indexPath) as? BannerCollectionViewCell
            cell?.data = model.banners
        case .scroll:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScrollCollectionViewCell.reuseIdentifier, for: indexPath) as? ScrollCollectionViewCell
            cell?.data = model.goods
        case .style:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: StyleGridItemCollectionViewCell.reuseIdentifier, for: indexPath) as? StyleGridItemCollectionViewCell
            cell?.data = model.styles
        }
        
        cell?.setData(cellType)
        
        return (cell as? UICollectionViewCell) ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderCollectionReusableView.reuseIdentifier, for: indexPath) as! HeaderCollectionReusableView
            header.isHidden = listModel?.list.data[indexPath.section].header == nil
            return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderCollectionReusableView.reuseIdentifier, for: indexPath) as! HeaderCollectionReusableView
        case UICollectionView.elementKindSectionFooter:
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: FooterCollectionReusableView.reuseIdentifier, for: indexPath) as! FooterCollectionReusableView
            footer.isHidden = listModel?.list.data[indexPath.section].footer == nil
            return footer
        default:
            return UICollectionReusableView()
        }
    }
}

extension String {
    func cellType() -> MainCellType? {
        MainCellType.allCases.first(where: { $0.rawValue == self })
    }
}

extension IndexPath {
    func cellType() -> MainCellType? {
        switch self.section {
        case 0:
            return .banner
        case 1:
            return .grid
        case 2:
            return .scroll
        case 3:
            return .style
        default:
            return nil
        }
    }
}
