//
//  ListResult.swift
//  HNAssignment
//
//  Created by Robert Hagklint on 2018-10-06.
//  Copyright © 2018 Robert Hagklint. All rights reserved.
//

import Foundation

// Used for convenience by HemnetListService when decoding the json of ads.

// TODO: Rename listobject.json file
struct ListResult {
    let ads: [ListAd]
}

extension ListResult: Codable {
    enum CodingKeys: String, CodingKey {
        case ads = "listings"
    }
}
