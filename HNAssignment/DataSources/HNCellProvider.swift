//
//  HNCellProvider.swift
//  HNAssignment
//
//  Created by Robert Hagklint on 2018-10-06.
//  Copyright © 2018 Robert Hagklint. All rights reserved.
//

import UIKit

class HNCellProvider {
    let imageCache: ImageCache
    
    required init(imageCache: ImageCache) {
        self.imageCache = imageCache
    }
    
    private var cellRegistered: Bool = false
    
    func configureCell(´for´ ad: BasicAd,
                       in collectionView: UICollectionView,
                       at indexPath: IndexPath) -> UICollectionViewCell {
        
        if cellRegistered == false {
            registerHNCell(in: collectionView)
            cellRegistered = true
        }
        
        guard let cell =
            collectionView.dequeueReusableCell(withReuseIdentifier: HNCellProvider.reuseIdentifier, for: indexPath)
                as? HNCollectionViewCell else { fatalError("Cell could not be dequeued") }
        
        //TODO: Implement handling of deactivated listings
        
        setCellValues(cell, with: ad)
        setCellImage(cell, with: ad)
        
        return cell
    }
}

// MARK: - Helper functions
extension HNCellProvider {
    private func setCellValues(_ cell: HNCollectionViewCell, with ad: BasicAd) {
        cell.titleLabel.text = ad.title
        cell.areaLabel.text = ad.location
        
        cell.topCollection.leftLabel.text = ad.price
        cell.topCollection.middleLabel.text = String(ad.livingArea) + " m2"
        cell.topCollection.rightLabel.text = String(ad.numberOfRooms)  + " rum"
        
        cell.bottomCollection.leftLabel.text = ad.monthlyFee
        cell.bottomCollection.rightLabel.text = String(ad.daysOnHemnet) + " dagar"
    }
    
    private func setCellImage(_ cell: HNCollectionViewCell, with ad: BasicAd) {
        cell.thumbnailIdentifier = ad.thumbnail
        
        imageCache.image(for: ad.thumbnail) { (image, identifier) in
            DispatchQueue.main.async {
                // Ensure that we are setting the image to the correct cell
                if cell.thumbnailIdentifier == identifier {
                    cell.imageView.image = image
                }
            }
        }
    }
    
    private static let reuseIdentifier: String = "cell"
    private func registerHNCell(in collectionView: UICollectionView) {
        let nib = UINib(nibName: "HNCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: HNCellProvider.reuseIdentifier)
    }
}
