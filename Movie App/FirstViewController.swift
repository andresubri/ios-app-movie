//
//  FirstViewController.swift
//  Movie App
//
//  Created by Carlos Andres on 9/20/18.
//  Copyright © 2018 Carlos Andres. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    let movies = ["Transporter 1", "Transporter 2", "Transporter 3", "Transporter 4", "Transporter 5", "Transporter 5", "Transporter 5", "Transporter 5", "Transporter 5"];
    
        @IBOutlet weak var topRatedCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topRatedCollectionView.dataSource = self;
        topRatedCollectionView.delegate = self;
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridItem", for: indexPath) as! GridItem;
        
        cell.titleLabel.text = movies[indexPath.item];
        
        return cell;
    }
}

