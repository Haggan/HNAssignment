//
//  HNMockApiService.swift
//  HNAssignment
//
//  Created by Robert Hagklint on 2018-10-06.
//  Copyright © 2018 Robert Hagklint. All rights reserved.
//

import Foundation

struct HNMockApiService: ApiService {
    func fetchList(_ result: (ApiResult<Data>) -> ()) {
        /**
         Mocking ApiService by using a json file to "fetch" the list. This is code that would not be in the regular
         application
         */
        
        if let path = Bundle.main.path(forResource: "Result", ofType: "json") {
            do {
                // First we try to read the json file
                let url = URL(fileURLWithPath: path)
                let data = try Data(contentsOf: url, options: .alwaysMapped)
                
                result(ApiResult.success(data))
            } catch {
                // Handle error
                result(ApiResult.failure(.noData))
            }
        } else {
            fatalError("Could not find the mock result file")
        }
    }
}
