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
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return listModel?.entityCount() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let cellType = getCellType(section) else {
            return 0
        }
        
        return listModel?.currentListCount.getCount(type: cellType) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let model = listModel?.contents(indexPath.section), let cellType = indexPath.cellType() else {
            os_log("MainCollectionView reuse cell Failed.")
            return UICollectionViewCell()
        }
        
        var cell: MainCollectionViewCell?
        
        switch cellType {
        case .grid:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: GridItemCollectionViewCell.reuseIdentifier, for: indexPath) as? GridItemCollectionViewCell
            cell?.data = model.goods?[indexPath.item]
        case .banner:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionViewCell.reuseIdentifier, for: indexPath) as? BannerCollectionViewCell
            cell?.data = model.banners
        case .scroll:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScrollCollectionViewCell.reuseIdentifier, for: indexPath) as? ScrollCollectionViewCell
            cell?.data = model.goods
        case .style:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: StyleGridItemCollectionViewCell.reuseIdentifier, for: indexPath) as? StyleGridItemCollectionViewCell
            cell?.data = model.styles?[indexPath.item]
        }
        
        cell?.setData(cellType)
        
        return (cell as? UICollectionViewCell) ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderCollectionReusableView.reuseIdentifier, for: indexPath) as! HeaderCollectionReusableView
            header.isHidden = isHeaderHidden(indexPath.section)
            header.setHeaderData(listModel?.header(indexPath.section))
            
            return header
            
        case UICollectionView.elementKindSectionFooter:
            
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: FooterCollectionReusableView.reuseIdentifier, for: indexPath) as! FooterCollectionReusableView
            footer.isHidden = isFooterHidden(indexPath.section)
            footer.setFooterData(listModel?.footer(indexPath.section))
            footer.delegate = self
            footer.section = indexPath.section
            
            return footer
        default:
            os_log("MainCollectionView 'viewForSupplementaryElementOfKind' isn't contained in UICollectionView.elementKindSectionHeader or UICollectionView.elementKindSectionFooter")
            return UICollectionReusableView()
        }
    }
}

// MARK: - Interfaces need to communicate with ViewController.
extension MainCollectionViewDataSource {
    func request(_ completionHandler: @escaping () -> Void) {
        requestUseCase?.request({ result in
            switch result {
            case .success(let model):
                self.listModel = model
                model.reloadSectionsCount()
            case .failure(_):
                os_log("Request interviewListFailed")
            }
            
            completionHandler()
        })
    }
    
    func getCellType(_ indexPath: IndexPath) -> MainCellType? {
        listModel?.cellType(indexPath.section)
    }
    
    func getCellType(_ section: Int) -> MainCellType? {
        listModel?.cellType(section)
    }
    
    func isHeaderHidden(_ section: Int) -> Bool {
        listModel?.header(section) == nil
    }
    
    func isFooterHidden(_ section: Int) -> Bool {
        listModel?.footer(section) == nil
    }
}

extension MainCollectionViewDataSource: MainViewDelegate {
    func didSelectReusableView(_ section: Int) {
        if let type = listModel?.cellType(section) {
            
            switch listModel?.footerType(section) {
            case .refresh:
                listModel?.reloadSectionCount(section: section)
            case .showMore:
                listModel?.showMoreButtonTouchUpInside(type)
            default:
                return
            }
            
            NotificationCenter.default.post(
                name: NSNotification.Name(rawValue: ""),
                object: self,
                userInfo: ["IndexPath": IndexPath(item: 0, section: section)]
            )
        }
    }
}

// MARK: - Type extensions for MainCellType.
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
