//
//  ListAd.swift
//  HNAssignment
//
//  Created by Robert Hagklint on 2018-10-06.
//  Copyright © 2018 Robert Hagklint. All rights reserved.
//

import Foundation

/**
 ListAd is used by HemnetListService (via ListResult) when getting the result from the ApiService. The ListAd is used as the concrete
 implementation of BasicAd when we want to decode the json result.
 */
struct ListAd {
    let listingType: String
    let identifier: String
    let askingPrice: String
    let monthlyFee: String
    let municipality: String
    let area: String
    let daysOnHemnet: Int
    let livingArea: Int
    let numberOfRooms: Int
    let streetAddress: String
    let thumbnail: String
}

extension ListAd: BasicAd {
    
    var title: String { return streetAddress }
    var location: String { return area }
    var price: String { return askingPrice}
    
    
    var listing: ListingType {
        return ListingType(rawValue: listingType)
    }
}

extension ListAd: Codable {
    enum CodingKeys: String, CodingKey {
        case listingType
        case identifier = "id"
        case askingPrice
        case monthlyFee
        case municipality
        case area
        case daysOnHemnet
        case livingArea
        case numberOfRooms
        case streetAddress
        case thumbnail
    }
}
