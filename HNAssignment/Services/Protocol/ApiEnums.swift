//
//  ApiEnums.swift
//  HNAssignment
//
//  Created by Robert Hagklint on 2018-10-06.
//  Copyright © 2018 Robert Hagklint. All rights reserved.
//

import Foundation

// MARK: - Useful values -
/// ApiResult and ResultCompletionHandler is modeled after the suggested behaviour by Alamofire and is good practice
public enum ApiResult<DataType> {
    case success(DataType)
    case failure(ApiError)
}

public enum ApiError {
    case noData
}

typealias ApiResultCompletionHandler = (ApiResult<Data>) -> ()
