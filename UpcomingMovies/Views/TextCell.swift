//
//  TextCell.swift
//  UpcomingMovies
//
//  Created by Mahavir Jain on 14/10/16.
//  Copyright © 2016 CodeToArt. All rights reserved.
//

import UIKit

class TextCell: UITableViewCell {

    @IBOutlet var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.updateConstraintsIfNeeded()
        self.layoutIfNeeded()
    }
    
    func configure(_ text: String?, font: UIFont = UIFont.regularFont(15)) {
        if let txt = text {
            self.contentLabel.text = txt
        } else {
            self.contentLabel.text = "-"
        }
        self.contentLabel.font = font
    }

}
