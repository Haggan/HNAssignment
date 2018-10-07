//
//  CollectionViewListDelegate.swift
//  HNAssignment
//
//  Created by Robert Hagklint on 2018-10-07.
//  Copyright © 2018 Robert Hagklint. All rights reserved.
//

import UIKit

/**
 Discussion: There exists a problem in this solution that would show itself when the expected behaviour introduces
 infinite scrolling in the collectionView. The delegate would be responsible for knowing when we should load more
 data, but the dataSource would be responsible for downloading that data. It could lead to high coupling. But managing
 that relationship with good thought out protocols could fix it. I have not really thought it through yet.
 
 */
class CollectionViewListDelegate: NSObject {
    let parent: UINavigationController
    let dataSource: ContentDataSource
    
    required init(parent: UINavigationController, dataSource: ContentDataSource) {
        self.parent = parent
        self.dataSource = dataSource
    }
}

extension CollectionViewListDelegate: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedAd = dataSource.ads[indexPath.item]
        let viewController = DetailViewController.instantiate(with: selectedAd)
        parent.pushViewController(viewController, animated: true)
    }
}
