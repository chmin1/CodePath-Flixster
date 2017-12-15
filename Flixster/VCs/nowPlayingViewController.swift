//
//  nowPlayingViewController.swift
//  Flixster
//
//  Created by Chavane Minto on 11/15/17.
//  Copyright © 2017 Chavane Minto. All rights reserved.
//

import UIKit
import AlamofireImage
import PKHUD

class nowPlayingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var movieTableView: UITableView!
    
    var refreshController: UIRefreshControl!
    
    var alertController: UIAlertController!
    
    var movies: [Movie] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        self.tabBarController?.tabBar.barStyle = .black
        
        movieTableView.dataSource = self;
        movieTableView.delegate = self;
        
        movieTableView.rowHeight = UITableViewAutomaticDimension;
        movieTableView.estimatedRowHeight = 50;
        
//        //alert if not connected to the internet
//        isConnected()
        
        //Function to use a network request
        getMovies()
        
        //Implement UIRefreshControl for PULL TO REFRESH
        refreshController = UIRefreshControl()
        
        //RefreshController calls a method when event is triggered
        refreshController.addTarget(self, action: #selector(nowPlayingViewController.didPullToRefresh(_:)), for: .valueChanged)
        movieTableView.insertSubview(refreshController, at: 0)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        HUD.dimsBackground = false
        HUD.allowsInteraction = false
        HUD.flash(.progress, delay: 0)
    }
    
    //Function used as action for refresh controller
    @objc func didPullToRefresh(_ refresher: UIRefreshControl) {
        getMovies()
    }
    
    func getMovies() {
        MovieApiManager().nowPlayingMovies { (movies, error) in
            if let movies = movies {
                self.movies = movies
                self.movieTableView.reloadData()
                self.refreshController.endRefreshing()
                HUD.flash(.success, delay: 1.0)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Get the reusable cell class
        let cell = movieTableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! movieCell;
        
        //Get a single movie for the list of movies
        let movie = movies[indexPath.row];
        
        //Get the info from the movie needed for the cell
        let title = movie.title;
        let overview = movie.overview
        
        //assign data from the movie to the movie cell
        cell.titleLabel.text = title;
        cell.overviewLabel.text = overview;
        cell.moviePosterImage.af_setImage(withURL: movie.posterURL)
        
        return cell;
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! movieDetailViewController
        
        //Cast the sender as what is sending information
        //In this case, it's the selected cell
        let cell = sender as! UITableViewCell;
        
        //get the indexpath for the cell selected
        if let indexPath = movieTableView.indexPath(for: cell) {
            //get the movie that is being sent
            let movie = movies[indexPath.row]
            //Send the selected Movie to the detail VC
            destVC.movie = movie;
            
            movieTableView.deselectRow(at: indexPath, animated: true)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    */

}
