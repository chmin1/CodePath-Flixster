//
//  movieCell.swift
//  Flixster
//
//  Created by Chavane Minto on 11/15/17.
//  Copyright © 2017 Chavane Minto. All rights reserved.
//

import UIKit

class movieCell: UITableViewCell {
    
    @IBOutlet weak var moviePosterImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var overviewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
