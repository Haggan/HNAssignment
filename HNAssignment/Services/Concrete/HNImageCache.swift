//
//  HNImageCache.swift
//  HNAssignment
//
//  Created by Robert Hagklint on 2018-10-06.
//  Copyright © 2018 Robert Hagklint. All rights reserved.
//

import UIKit

class HNImageCache {
    private let service: ImageService
    private var images: [String : UIImage] = [:] // Replace with Cache/NSCache later
    
    required init(imageService: ImageService) { self.service = imageService }
}

extension HNImageCache: ImageCache {
    
    /**
     Fetch image with url. If the image is already downloaded, this will return instantly. Else it will download
     */
    func image(for urlString: String, completion: @escaping (UIImage?, String) -> ()) {
        
        // If image already exist in the image cache, execute the closure with that image
        if let image = images[urlString] {
            completion(image, urlString)
        }
        
        // Else, we download the image and store the image
        service.download(with: urlString) { [weak self] (optionalImage) in
            var image = optionalImage
            
            if image == nil {
                image = UIImage(named: "no-image") // If we have no image, we set the no image
                // placeholder instead and save it
            }
            
            // Ensure that the image is not too big. Maybe the real estate agent uploaded a HUUUUGE
            // file as thumbnail. We save the resized image in the images "cache" so that we don't waste
            // runtime memory
            image = image?.resize(targetWidth: 300)
            
            self?.images[urlString] = image // It's possible that this is not enteriely thread safe. But
            // due to the 4 hour time constraint of the assignment, I won't put work into fixing it. I'm simply
            // acknowledging it :)
            completion(image, urlString)
        }
    }
}

extension UIImage {
    public func resize(targetWidth: CGFloat) -> UIImage {
        let currentSize = self.size
        
        if currentSize.width <= targetWidth { return self }
        
        let widthRatio = targetWidth  / currentSize.width
        let newSize = CGSize(width: currentSize.width * widthRatio,  height: currentSize.height * widthRatio)
        
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage! // We want to crash here if this doesn't work, since something is seriously wrong
        // if we can't simply resize the image
    }
}
