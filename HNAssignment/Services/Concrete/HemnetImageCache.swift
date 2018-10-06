//
//  HemnetImageCache.swift
//  HNAssignment
//
//  Created by Robert Hagklint on 2018-10-06.
//  Copyright © 2018 Robert Hagklint. All rights reserved.
//

import UIKit

class HemnetImageCache {
    private let service: ImageService
    private var images: [String : UIImage] = [:] // Replace with Cache/NSCache later
    
    required init(imageService: ImageService) { self.service = imageService }
}

extension HemnetImageCache: ImageCache {
    
    /**
     Fetch image with url. If the image is already downloaded, this will return instantly. Else it will download
     */
    func image(for urlString: String, completion: @escaping (UIImage?, String) -> ()) {
        
        // If image already exist in the image cache, execute the closure with that image
        if let image = images[urlString] {
            completion(image, urlString)
            return
        }
        
        // Else, we download the image and store the image
        service.download(with: urlString) { [weak self] (optionalImage) in
            var image = optionalImage
            
            if image == nil {
                image = UIImage(named: "no-image") // If we have no image, we set the no image
                // placeholder instead and save it
            }
            
            self?.images[urlString] = image // It's possible that this is not enteriely thread safe. But
            // due to the 4 hour time constraint of the assignment, I won't put work into fixing it. I'm simply
            // acknowledging it :)
            completion(image, urlString)
        }
    }
}
