//
//  RequestManager.swift
//  Movie App
//
//  Created by Carlos Andres on 9/21/18.
//  Copyright © 2018 Carlos Andres. All rights reserved.
//

import Alamofire
import SwiftyJSON
import Foundation

class RequestManager {
    
    static func get(endpoint: String, completionHandler: @escaping (NSDictionary?, Error?) -> ()) {
        Alamofire.request("https://api.themoviedb.org/3/movie\(endpoint)?api_key=87e63202cdc8f4b8ceee237236a9c654").responseJSON { response in
                switch response.result {
                    case .success(let value):
                        completionHandler(value as? NSDictionary, nil)
                    case .failure(let error):
                        completionHandler(nil, error)
                }
        }
    }
}
