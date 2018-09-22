//
//  FirstViewController.swift
//  Movie App
//
//  Created by Carlos Andres on 9/20/18.
//  Copyright © 2018 Carlos Andres. All rights reserved.
//

import UIKit
import SwiftyJSON
import Moya

class TopRatedMoviesController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var movies : JSON = [];
    let provider = MoyaProvider<TheMovieDB>()
    var page = 1
    
    @IBOutlet weak var topRatedCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //state = .loading

        topRatedCollectionView.dataSource = self;
        topRatedCollectionView.delegate = self;
        fetchMovies()
    }

    func fetchMovies() {
        
        //state = .loading
        
        provider.request(.topRated(page: self.page)) { result in
            
            switch result {
            case .success(let response):
                do {
                    // Parse response
                    let serialized = try response.mapJSON()
                    
                    try self.movies.merge(with: JSON(serialized)["results"])
                    
                    // Refresh view with new data
                    self.topRatedCollectionView.reloadData()
                } catch {
                    
                }
            case .failure: break
                
            }
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
    
    // Fetch new movies on scroll
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    
        // TODO: Smoother scrolling
        if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height / 6)
        {
            self.page = self.page + 1
            self.fetchMovies()
        }
    }
    
    
}

