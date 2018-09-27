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
    
    var id = 0;
    var title = "";
    var overview = "";
    var rating = 0.0;
    var poster = "";
    var releaseDate = "";
    var backdrop = "";
    
    init(id: Int, title: String, overview: String, rating: Double, poster: String, releaseDate: String,
         backdrop: String) {
        self.id = id;
        self.title = title;
        self.overview = overview;
        self.rating = rating;
        self.poster = poster;
        self.releaseDate = releaseDate;
        self.backdrop = backdrop;
    }
    
    init(serializedMovie: Any) {
        let json = JSON(serializedMovie)
        
        self.id = Int(json["id"].stringValue)!
        self.title = json["title"].stringValue
        self.overview = json["overview"].stringValue
        self.rating = Double(json["vote_average"].stringValue)!
        self.poster = json["poster_path"].stringValue
        self.releaseDate = json["release_date"].stringValue;
        self.backdrop = json["backdrop_path"].stringValue;
    }
}
