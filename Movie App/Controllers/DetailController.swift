//
//  DetailController.swift
//  Movie App
//
//  Created by Carlos Andres on 9/25/18.
//  Copyright © 2018 Carlos Andres. All rights reserved.
//

import UIKit
import AlamofireImage
import SwiftyJSON
import Moya

class DetailController : UIViewController {
    
    let provider = MoyaProvider<TheMovieDB>()
    
    var selected = 0;
    
    var response : JSON = []
    
    var movie : Movie = Movie(id: 0, title: "String", overview: "String", rating: 0.0, poster: "String", releaseDate: "String", backdrop: "String")
    
    @IBOutlet weak var NavBar: UINavigationBar!
    
    @IBOutlet weak var backgroundPoster: UIImageView!
    
    @IBOutlet weak var mainPoster: UIImageView!
    
    @IBOutlet weak var runtime: UILabel!
    
    @IBOutlet weak var genre: UILabel!
    
    @IBOutlet weak var releaseDate: UILabel!
    
    @IBOutlet weak var overview: UILabel!
    
    @IBOutlet weak var leftNavButton: UIBarButtonItem!
    
    override func viewWillAppear(_ animated: Bool) {
     self.fetchMovie()
     self.viewDidLoad()
    }
    
    func fetchMovie() {
        
        //state = .loading
        
        provider.request(.movie(id: self.selected)) { result in
            
            switch result {
            case .success(let response):
                do {
                    
                    // Parse response
                    let serialized = try response.mapJSON()
                    print(serialized)
                    self.movie = Movie(serializedMovie: serialized)
                    
                } catch {
                    
                }
            case .failure: break
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(self.movie.title)
        NavBar.topItem?.title = self.movie.title
        overview.text = self.movie.overview
        genre.text = String(self.movie.rating)
        releaseDate.text = self.movie.releaseDate
        setPoster(path: self.movie.poster)
        setBackdrop(path: self.movie.backdrop)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setPoster(path: String) {
        if (path.count < 1) {return}
        let url = URL(string: "https://image.tmdb.org/t/p/w92\(path)")!
        //let placeholderImage = UIImage(named: "placeholder")!
        
        self.mainPoster.af_setImage(withURL: url)
    }
    func setBackdrop(path: String) {
        if (path.count < 1) {return}
        let url = URL(string: "https://image.tmdb.org/t/p/w92\(path)")!
        //let placeholderImage = UIImage(named: "placeholder")!
        
        self.backgroundPoster.af_setImage(withURL: url)
    }
    
    
    @IBAction func `return`(_ sender: Any) {
        dismiss(animated: true)
    }
    
}
