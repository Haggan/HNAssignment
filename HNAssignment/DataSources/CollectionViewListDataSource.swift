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
        let nib = UINib(nibName: "HNCollectionViewCell", bundle: Bundle(for: type(of: self)))
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
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell =
            collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
                as? HNCollectionViewCell else { fatalError("Cell could not be founds, CRASH!") }
        
        let ad = ads[indexPath.item]
        setCellValues(cell, with: ad)
        setCellImage(cell, with: ad)
        
        return cell
    }
}

// MARK: - Helper functions
extension CollectionViewListDataSource {
    func setCellValues(_ cell: HNCollectionViewCell, with ad: BasicAd) {
        cell.titleLabel.text = ad.title
        cell.areaLabel.text = ad.location
        
        cell.topCollection.leftLabel.text = ad.price
        cell.topCollection.middleLabel.text = String(ad.livingArea) + " m2"
        cell.topCollection.rightLabel.text = String(ad.numberOfRooms)  + " rum"
        
        cell.bottomCollection.leftLabel.text = ad.monthlyFee
        cell.bottomCollection.rightLabel.text = String(ad.daysOnHemnet) + " dagar"
    }
    
    func setCellImage(_ cell: HNCollectionViewCell, with ad: BasicAd) {
        cell.thumbnailIdentifier = ad.thumbnail
        
        imageCache.image(for: ad.thumbnail) { (image, identifier) in
            DispatchQueue.main.async {
                if cell.thumbnailIdentifier == identifier {
                    cell.imageView.image = image
                }
            }
        }
    }
}
