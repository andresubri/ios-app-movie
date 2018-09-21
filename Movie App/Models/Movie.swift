//
//  Movie.swift
//  Movie App
//
//  Created by Carlos Andres on 9/21/18.
//  Copyright © 2018 Carlos Andres. All rights reserved.
//

import Foundation
import SwiftyJSON

class Movie {
    
    var title = "";
    var overview = "";
    var rating = 0.0;
    var poster = "";
    
    init(title: String, overview: String, rating: Double, poster: String) {
        self.title = title;
        self.overview = overview;
        self.rating = rating;
        self.poster = poster;
    }
    
    init(serializedMovie: Any) {
        let json = JSON(serializedMovie)
        self.title = json["title"].stringValue
        self.overview = json["overview"].stringValue
        self.rating = Double(json["vote_average"].stringValue)!
        self.poster = json["poster_path"].stringValue
    }
}
