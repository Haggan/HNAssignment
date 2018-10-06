//
//  CollectionViewListDataSource.swift
//  HNAssignment
//
//  Created by Robert Hagklint on 2018-10-06.
//  Copyright © 2018 Robert Hagklint. All rights reserved.
//

import UIKit

protocol ContentDataSource: UICollectionViewDataSource {
    func restart()
}

class CollectionViewListDataSource: NSObject {
    private let listService: ListService
    private let reuseIdentifier: String = "cell"
    
    private var ads: [BasicAd] = []
    
    private weak var collectionView: UICollectionView?
    private let cellProvider: HNCellProvider
    
    required init(listService: ListService,
                  collectionView: UICollectionView,
                  imageCache: ImageCache) {
        
        self.listService = listService
        self.collectionView = collectionView
        self.cellProvider = HNCellProvider(imageCache: imageCache)
        
        super.init()
    }
}

// MARK: - DataSource
extension CollectionViewListDataSource: ContentDataSource {
    func restart() {
        listService.resetList { [weak self] (listAds) in
            guard let unwrappedAds = listAds else { return }
            
            self?.ads = unwrappedAds
            self?.collectionView?.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ads.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let ad = ads[indexPath.item]
        
        // Inject cellProvider?
        return cellProvider.configureCell(´for´: ad,
                                          in: collectionView,
                                          at: indexPath)
    }
}
