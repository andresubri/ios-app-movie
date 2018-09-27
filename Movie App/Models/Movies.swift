//
//  MovieList.swift
//  Movie App
//
//  Created by Carlos Andres on 9/21/18.
//  Copyright © 2018 Carlos Andres. All rights reserved.
//

import Foundation

struct PropertyKey {
    static let KEY = "FAVORITE_MOVIES"
}

class Movies: NSObject, NSCoding {
    
    var favoriteMovies: Array<Movie> = []
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(favoriteMovies, forKey: PropertyKey.KEY)
    }
    
    init(favoriteMovies: Array<Movie>){
        self.favoriteMovies = favoriteMovies
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        let favoriteMovies = aDecoder.decodeObject(forKey: PropertyKey.KEY) as! Array<Movie>
        self.init(favoriteMovies: favoriteMovies)

    }
    
}
