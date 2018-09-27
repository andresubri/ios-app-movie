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
    
    var movie : Movie = Movie(id: 0, title: "String", overview: "String", rating: 0.0, poster: "String", releaseDate: "String", backdrop: "String", duration: "0")
    

    @IBOutlet weak var navBar: UINavigationItem!
    
    @IBOutlet weak var backgroundPoster: UIImageView!
    
    @IBOutlet weak var mainPoster: UIImageView!
    
    @IBOutlet weak var runtime: UILabel!
    
    @IBOutlet weak var genre: UILabel!
    
    @IBOutlet weak var releaseDate: UILabel!
    
    @IBOutlet weak var mainScrollView: UIScrollView!
    
    @IBOutlet weak var overview: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navBar.title = self.movie.title
        overview.text = self.movie.overview
        genre.text = "\(self.movie.rating) / 10"
        releaseDate.text = self.movie.releaseDate
        setPoster(path: self.movie.poster)
        setBackdrop(path: self.movie.backdrop)
        overview.sizeToFit()
        var contentRect = CGRect.zero
        
        for view in mainScrollView.subviews {
            contentRect = contentRect.union(view.frame)
        }
        mainScrollView.contentSize = contentRect.size

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setPoster(path: String) {
        if (path.count < 1) {return}
        let url = URL(string: "https://image.tmdb.org/t/p/w300\(path)")!
    
    self.mainPoster.layer.cornerRadius = 12
        let filter = AspectScaledToFillSizeWithRoundedCornersFilter(
            size: self.mainPoster.frame.size,
            radius: 6.0
        )
        self.mainPoster.af_setImage(withURL: url, filter: filter)
    }
    
    func setBackdrop(path: String) {
        if (path.count < 1) {return}
        let url = URL(string: "https://image.tmdb.org/t/p/w300\(path)")!
        self.backgroundPoster.af_setImage(withURL: url)
    }
    
}
