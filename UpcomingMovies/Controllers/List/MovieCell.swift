//
//  MovieCell.swift
//  UpcomingMovies
//
//  Created by Mahavir Jain on 13/10/16.
//  Copyright © 2016 CodeToArt. All rights reserved.
//

import UIKit
import AsyncImageView

class MovieCell: UITableViewCell {

    @IBOutlet var movieImageView: AsyncImageView!
    @IBOutlet var movieTitleLabel: UILabel!
    @IBOutlet var releaseDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        self.movieImageView.layer.cornerRadius = 5
        self.movieImageView.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(mcvm: MovieCellViewModel) {
        self.movieImageView.showActivityIndicator = false
        self.movieImageView.imageURL = mcvm.getImageURL()
        self.movieTitleLabel.text = mcvm.getMovieTitle()
        self.releaseDateLabel.text = mcvm.formattedReleaseDate()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.movieImageView.image = nil
    }

}
