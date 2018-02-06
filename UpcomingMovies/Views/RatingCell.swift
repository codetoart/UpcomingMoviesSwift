//
//  RatingCell.swift
//  UpcomingMovies
//
//  Created by Mahavir Jain on 14/10/16.
//  Copyright © 2016 CodeToArt. All rights reserved.
//

import UIKit
import HCSStarRatingView

class RatingCell: UITableViewCell {
    
    @IBOutlet var ratingView: HCSStarRatingView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(_ rating: Float?) {
        if let r = rating {
            self.ratingView.value = CGFloat(r)
        } else {
            self.ratingView.value = 0
        }
    }

}
