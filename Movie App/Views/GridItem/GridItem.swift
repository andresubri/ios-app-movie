//
//  GridItem.swift
//  Movie App
//
//  Created by Carlos Andres on 9/20/18.
//  Copyright © 2018 Carlos Andres. All rights reserved.
//

import UIKit
import AlamofireImage

class GridItem: UICollectionViewCell {
    
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    func setImage(path: String) {
        if (path.count < 1) {return}
        let url = URL(string: "https://image.tmdb.org/t/p/w92\(path)")!
        //let placeholderImage = UIImage(named: "placeholder")!
        
        self.backgroundImage.af_setImage(withURL: url)
    }
}
