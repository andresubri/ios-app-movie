//
//  TheMovieDB.swift
//  Movie App
//
//  Created by Carlos Andres on 9/21/18.
//  Copyright © 2018 Carlos Andres. All rights reserved.
//

import Foundation
import Moya

public enum TheMovieDB {
    static private let publicKey = "87e63202cdc8f4b8ceee237236a9c654"
    
    case topRated(page : Int)
    case movie(id : Int)
}

extension TheMovieDB: TargetType {

    public var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3/movie")!
    }
    

    public var path: String {
        switch self {
        case .topRated: return "/top_rated"
        case .movie(let id): return "/\(id)"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .topRated: return .get
        case .movie: return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        
        // Auth Key
        //let authParams = ["api_key": TheMovieDB.publicKey]

        switch self {
        case .topRated(let page):
            return .requestParameters(
            parameters: ["page": page, "api_key": TheMovieDB.publicKey],
                encoding: URLEncoding.default)
        case .movie:
            return .requestParameters(
                parameters: ["api_key": TheMovieDB.publicKey],
                encoding: URLEncoding.default)
        }
    }
    
    public var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
}
