//
//  AdEnums.swift
//  HNAssignment
//
//  Created by Robert Hagklint on 2018-10-06.
//  Copyright © 2018 Robert Hagklint. All rights reserved.
//

import Foundation

enum ListingType: String {
    case active
    case deactivated
    
    init(rawValue: String) {
        switch rawValue {
        case "ActivePropertyListing":
            self = .active
        case "DeactivatedPropertyListing":
            self = .deactivated
        default:
            fatalError("Could not parse Listing type")
        }
    }
}
