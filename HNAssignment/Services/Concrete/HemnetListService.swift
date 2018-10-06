//
//  HemnetListService.swift
//  HNAssignment
//
//  Created by Robert Hagklint on 2018-10-06.
//  Copyright © 2018 Robert Hagklint. All rights reserved.
//

import Foundation

struct HemnetListService {
    let apiService: ApiService
}

extension HemnetListService: ListService {
    
    // NOTE:
    // We return a closure that contains basic ad's and not listResult because ListResult has to contain
    // ListAd's since the ads property needs to conform to codable. By using basic ad in the application as a whole
    // we make it much easier to test and also replace the model in the future if we want to
    
    func resetList(_ result: ([BasicAd]?) -> ()) {
        apiService.fetchList { (apiResult) in
            
            switch apiResult {
                
            case .success(let jsonData):
                if let listResult = try? JSONDecoder().decode(ListResult.self, from: jsonData) {
                    result(listResult.ads) // Se the note why we use a list of BasicAd instead of executing the
                    // closure with the ListResult
                } else {
                    fatalError("We should really have gotten a list of ads here. Something is terribly wrong...")
                }
                
            case .failure(_):
                result(nil)
            }
        }
    }
}
