//
//  FirstViewController.swift
//  Movie App
//
//  Created by Carlos Andres on 9/20/18.
//  Copyright © 2018 Carlos Andres. All rights reserved.
//

import UIKit
import SwiftyJSON

class TopRatedMoviesController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var movies : NSArray = [];
    
    @IBOutlet weak var topRatedCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topRatedCollectionView.dataSource = self;
        topRatedCollectionView.delegate = self;
        fetchMovies()
    }

    func fetchMovies() {
        
        // Resolve promise and use assign values
        Movies.topRated(){  responseObject, error in
            
            let serializedData = responseObject!["results"] as! NSArray
            
            self.movies = serializedData
            
            self.topRatedCollectionView.reloadData()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // Set collection size
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count;
    }
    
    // Assign data to cellItem
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridItem", for: indexPath) as! GridItem;
        
        // Serialized object
        let movie = Movie(serializedMovie: movies[indexPath.item])
        
        cell.titleLabel.text = movie.title;
        cell.setImage(path: movie.poster)
        
        return cell;
    }
}

