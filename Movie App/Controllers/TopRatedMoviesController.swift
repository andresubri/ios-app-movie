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
    
    var selectedMovie : Movie = Movie(id: 0, title: "String", overview: "String", rating: 0.0, poster: "String", releaseDate: "String", backdrop: "String")

    
    @IBOutlet weak var topRatedCollectionView: UICollectionView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //state = .loading

        topRatedCollectionView.dataSource = self;
        topRatedCollectionView.delegate = self;
        activityIndicator.hidesWhenStopped = true
        fetchMovies()
    }

    func fetchMovies() {
        
        //state = .loading
        
        activityIndicator.startAnimating()
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
        activityIndicator.stopAnimating()
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
        
        cell.setRound()
        cell.titleLabel.text = movie.title;
        cell.setImage(path: movie.poster)
        
        return cell;
    }
    
    // Navigate to movie detail
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.selectedMovie = Movie(serializedMovie: movies[indexPath.item])
        performSegue(withIdentifier: "TopMovieToDetail", sender: self)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let movieDetail : DetailController = segue.destination as! DetailController
        movieDetail.selected = self.selectedMovie.id
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

