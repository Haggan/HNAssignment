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
    private let imageCache: ImageCache
    private let reuseIdentifier: String = "cell"
    
    private var ads: [BasicAd] = []
    
    private weak var collectionView: UICollectionView?
    
    required init(listService: ListService,
                  collectionView: UICollectionView,
                  imageCache: ImageCache) {
        
        self.listService = listService
        self.collectionView = collectionView
        self.imageCache = imageCache
        
        super.init()
        registerCell(in: collectionView)
    }
}

extension CollectionViewListDataSource {
    func registerCell(in collectionView: UICollectionView) {
        let nib = UINib(nibName: "HNColletionViewCell", bundle: Bundle(for: type(of: self)))
        collectionView.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
    }
}

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
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell =
            collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
                as? HNCollectionViewCell else { fatalError("Cell could not be founds, CRASH!") }
        
        let ad = ads[indexPath.item]
        
        cell.titleLabel.text = ad.title
        cell.areaLabel.text = ad.location
        
        return cell
    }
}
