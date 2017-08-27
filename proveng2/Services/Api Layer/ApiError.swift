//
//  ApiError.swift
//  proveng2
//
//  Created by Pavel Nikitinsky on 8/27/17.
//  Copyright © 2017 Provectus. All rights reserved.
//

import Foundation

/**
 Object encapsulates information about an error condition
 - Parameters:
 - domain: string containing the error domain
 - code: the error code
 - userInfo: the user info dictionary
 */

struct ApiError: Error {
    var domain: String
    var code: Int
    var userInfo: [AnyHashable: Any]

    init(domain: String? = "", code: Int? = 0, userInfo dictionary: [AnyHashable: Any]) {
        self.domain = domain!
        self.code = code!
        self.userInfo = dictionary
    }

    init(errorDescription: String) {
        self.domain = ""
        self.code = 0
        self.userInfo = [NSLocalizedDescriptionKey: errorDescription]
    }
}

extension ApiError {
    var errorDescription: String {
        if let errDesc = self.userInfo[NSLocalizedDescriptionKey] as? String {
            return errDesc
        }
        return Constants.UnknownErrorDescription
    }
}

extension Error {
    var apiError: ApiError {
        if self is ApiError {
            guard let error = self as? ApiError else {
                fatalError("Can not convert self as ApiError")
            }
            return error
        } else {
            let castedError = self as NSError
            return ApiError(domain: castedError.domain, code: castedError.code, userInfo: castedError.userInfo)
        }
    }
}
