//
//  ImageService.swift
//  HNAssignment
//
//  Created by Robert Hagklint on 2018-10-06.
//  Copyright © 2018 Robert Hagklint. All rights reserved.
//

import UIKit

protocol ImageService {
    var urlSession: URLSession { get }
}

extension ImageService {
    // TODO: Remeber to add escaping to all the mocked request closures
    
    func download(with urlString: String, completion: @escaping (UIImage?) -> ()) {
        guard let url = URL(string: urlString) else { fatalError("No proper url") }
        
        urlSession.dataTask(with: url) { (data, response, error) in
            guard error != nil else { fatalError("ERROR!") }
            guard let data = data else { fatalError("No data") }
            guard let imageData = UIImage(data: data) else { fatalError("Data from request was corrupted") }
            
            completion(imageData)
        }
    }
}
