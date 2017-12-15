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
    
//    func isConnected() {
//        self.alertController = UIAlertController(title: "Network Error", message: "Are you connected to the internet?", preferredStyle: .alert)
//
//        //try to connect again
//        let connect = UIAlertAction(title: "Connect", style: .cancel) { (action) in
//            self.getMovies()
//        }
//
//        // add action to alertController
//        alertController.addAction(connect)
//
//        self.present(alertController, animated: true) {
//            HUD.flash( .error, delay: 2.0)
//        }
//    }
    
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
        // *** CREATING A NETWORK REQUEST ***
        //Get the URL
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        
        //Create a URL Request with a custom cache policy (never load from local cache) and a timeout interval
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        
        //Create a URL Session
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        
        //Create a data task to grab the data requested
        let task = session.dataTask(with: request) { (data, response, error) in
            
            //This runs asynchrously and will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                // IF DATA WAS RETURNED, PARSE IT USING JSON SERIALIZATION:
                
                /*Grab data from the Json object
                 Since the data is in the form of a dictionary, cast it as a dictionary*/
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let movieDictionaries = dataDictionary["results"] as! [[String:Any]];
                
                self.movies = Movie.movies(dictionaries: movieDictionaries)
                
                //Update the tableview once the network request completes
                self.movieTableView.reloadData()
                
                //End refreshing tableview for data
                self.refreshController.endRefreshing()
                
                //Display successful HUD animation
                HUD.flash(.success, delay: 2.0)
                
            }
            
        }
        task.resume()
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
        let overview = movie.overview as! String
        
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
