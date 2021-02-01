//
//  CollectionViewCell.swift
//  Tripgram
//
//  Created by Ульяна Цимбалистая on 31.01.2021.
//  Copyright © 2021 Ульяна Цимбалистая. All rights reserved.
//

import UIKit

protocol TripCollectionCellDelegate {
       func likeButtonIsPressed(cell: TripCollectionViewCell)
   }

class TripCollectionViewCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var countryLabel: UILabel!
    @IBOutlet var totalDaysLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var likeButton: UIButton!
    
    var delegate:TripCollectionCellDelegate?
    
    var isLiked : Bool = false {
        didSet {
            if isLiked {
                likeButton.setBackgroundImage(UIImage(named: "heart.fill"), for: .normal)
            } else {
                likeButton.setBackgroundImage(UIImage(named: "heart"), for: .normal)
            }
        }
    }
    
    @IBAction func likeButtonTapped(sender: AnyObject) {
        delegate?.likeButtonIsPressed(cell: self)
    }
}
