//
//  ViewController.swift
//  Tripgram
//
//  Created by Ульяна Цимбалистая on 31.01.2021.
//  Copyright © 2021 Ульяна Цимбалистая. All rights reserved.
//

import UIKit

class TripViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, TripCollectionCellDelegate {
    
    func likeButtonIsPressed(cell: TripCollectionViewCell) {
        if let indexPath = collectionView.indexPath(for: cell) {
            if trips[indexPath.row].isLiked {
                trips[indexPath.row].isLiked = false
                cell.isLiked = false
            } else {
                trips[indexPath.row].isLiked = true
                cell.isLiked = true
            }
        }
        print("heart pressed")
    }
    
    @IBOutlet var collectionView: UICollectionView!
    
    private var trips = [Trip(tripId: "Paris001",
                              city: "Paris",
                              country: "France",
                              featuredImage: UIImage(named: "paris"),
                              price: 2000,
                              totalDays: 5,
                              isLiked: false),
                         Trip(tripId: "Rome001",
                              city: "Rome",
                              country: "Italy",
                              featuredImage: UIImage(named: "rome"),
                              price: 800,
                              totalDays: 3,
                              isLiked: false),
                         Trip(tripId: "Istanbul001",
                              city: "Istanbul",
                              country: "Turkey",
                              featuredImage: UIImage(named: "istanbul"),
                              price: 2200,
                              totalDays: 10,
                              isLiked: false),
                        ]
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trips.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! TripCollectionViewCell
        // идентификация ячейки
        cell.cityLabel.text = trips[indexPath.row].city
        cell.countryLabel.text = trips[indexPath.row].country
        cell.imageView.image = trips[indexPath.row].featuredImage
        cell.priceLabel.text = "$\(String(trips[indexPath.row].price))"
        cell.totalDaysLabel.text = "\(trips[indexPath.row].totalDays) days"
        cell.isLiked = trips[indexPath.row].isLiked
        // скругление
        cell.layer.cornerRadius = 4.0
        
        cell.delegate = self
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = UIColor.clear
        
        if UIScreen.main.bounds.size.height == 568.0 {
            let flowLayout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
            flowLayout.itemSize = CGSize(width: 250.0, height: 330.0)
        }
    }
}
