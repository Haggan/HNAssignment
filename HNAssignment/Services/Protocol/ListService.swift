//
//  ListService.swift
//  HNAssignment
//
//  Created by Robert Hagklint on 2018-10-06.
//  Copyright © 2018 Robert Hagklint. All rights reserved.
//

import Foundation

// MARK: - List service -
protocol ListService {
    /**
     Use to get the page 0 in the api for the list (or offset, depending on what you use :)
     
     - parameter result: Async closure containg a list of ads
     */
    func resetList(_ result: ([BasicAd]?) -> ())
}
