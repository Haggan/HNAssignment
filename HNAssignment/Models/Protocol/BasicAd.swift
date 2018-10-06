//
//  BasicAd.swift
//  HNAssignment
//
//  Created by Robert Hagklint on 2018-10-06.
//  Copyright © 2018 Robert Hagklint. All rights reserved.
//

import Foundation

protocol BasicAd {
    var listing: ListingType { get }
    var identifier: String { get }
    var title: String { get }
    var location: String { get }
    var price: String { get }
    var thumbnail: String { get }
    var livingArea: Int { get }
    var numberOfRooms: Int { get }
    var daysOnHemnet: Int { get }
    var monthlyFee: String { get }
}
