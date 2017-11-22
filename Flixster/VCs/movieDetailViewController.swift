//
//  movieDetailViewController.swift
//  Flixster
//
//  Created by Chavane Minto on 11/22/17.
//  Copyright © 2017 Chavane Minto. All rights reserved.
//

import UIKit
import AlamofireImage

class movieDetailViewController: UIViewController {
    
    @IBOutlet weak var backdropImage: UIImageView!
    
    @IBOutlet weak var posterImage: UIImageView!
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    @IBOutlet weak var overviewLabel: UILabel!
    
    var movie: [String: Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Details"

        if let movie = movie {
            movieTitleLabel.text = movie["title"] as? String
            releaseDateLabel.text = movie["release_date"] as? String
            overviewLabel.text = movie["overview"] as? String
            let backdropPathString = movie["backdrop_path"] as! String
            
            let posterPathString = movie["poster_path"] as! String
            let baseURL = "https://image.tmdb.org/t/p/w500"
            
            let backdropURL = URL(string: baseURL + backdropPathString);
            backdropImage.af_setImage(withURL: backdropURL!)
            
            let posterPathURL = URL(string: baseURL + posterPathString);
            posterImage.af_setImage(withURL: posterPathURL!)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
