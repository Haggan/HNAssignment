//
//  ApiService.swift
//  HNAssignment
//
//  Created by Robert Hagklint on 2018-10-06.
//  Copyright © 2018 Robert Hagklint. All rights reserved.
//

import Foundation

// MARK: - Api service protocol -
protocol ApiService {
    func fetchList(_ result: ApiResultCompletionHandler)
}
