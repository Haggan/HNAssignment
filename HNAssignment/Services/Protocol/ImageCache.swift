//
//  ImageCache.swift
//  HNAssignment
//
//  Created by Robert Hagklint on 2018-10-06.
//  Copyright © 2018 Robert Hagklint. All rights reserved.
//

import UIKit

protocol ImageCache {
    func image(for urlString: String, completion: @escaping (UIImage?, String) -> ())
}
