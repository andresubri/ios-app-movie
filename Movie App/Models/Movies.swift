//
//  MovieList.swift
//  Movie App
//
//  Created by Carlos Andres on 9/21/18.
//  Copyright © 2018 Carlos Andres. All rights reserved.
//

import Foundation

class Movies {
    static func topRated(completionHandler: @escaping (NSDictionary?, Error?) -> ()) {
        RequestManager.get(endpoint: RequestTypes.TOP_RATED, completionHandler: completionHandler)
    }
}
