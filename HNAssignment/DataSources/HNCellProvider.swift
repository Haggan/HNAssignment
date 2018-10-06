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
        
        setCellValues(cell, with: ad)
        setCellImage(cell, with: ad)
        
        return cell
    }
}

// MARK: - Helper functions
extension HNCellProvider {
    private func setCellValues(_ cell: HNCollectionViewCell, with ad: BasicAd) {
        
        // Code for setting label text using the ad values
        cell.titleLabel.text = ad.title
        cell.areaLabel.text = ad.location
        
        cell.topCollection.leftLabel.text = ad.price
        cell.topCollection.middleLabel.text = String(ad.livingArea) + " m2"
        cell.topCollection.rightLabel.text = String(ad.numberOfRooms)  + " rum"
        
        cell.bottomCollection.leftLabel.text = ad.monthlyFee
        cell.bottomCollection.rightLabel.text = String(ad.daysOnHemnet) + " dagar"
        
        // Set the listing "mode" of the cell
        if ad.listing == .active {
            cell.coverView.isHidden = true
            cell.removedLabel.isHidden = true
        } else {
            cell.coverView.isHidden = false
            cell.removedLabel.isHidden = false
        }
        
        // Discussion: I could move listing mode to the cell and invoke it from there, but I am of the opinion
        // that cells and other UI elements should be pretty dumb, and not know what they are used for.
        // Therefore I use instances like this CellProvider instead
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
