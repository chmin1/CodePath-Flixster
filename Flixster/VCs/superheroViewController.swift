//
//  superheroViewController.swift
//  Flixster
//
//  Created by Chavane Minto on 11/22/17.
//  Copyright © 2017 Chavane Minto. All rights reserved.
//

import UIKit
import AlamofireImage

class superheroViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var movies: [Movie] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.minimumInteritemSpacing = 5
        flowLayout.minimumLineSpacing = flowLayout.minimumInteritemSpacing
        let cellsPerLine: CGFloat = 2;
        let interItemSpacingTotal = flowLayout.minimumLineSpacing * (cellsPerLine - 1)
        let width = collectionView.frame.size.width / cellsPerLine - interItemSpacingTotal/cellsPerLine;
        flowLayout.itemSize = CGSize(width: width, height: width * 3/2)
        
        collectionView.dataSource = self;
        collectionView.delegate = self;
        
        getMovies()
        
    }
    
    func getMovies() {
        // *** CREATING A NETWORK REQUEST ***
        //Get the URL
        let url = URL(string: "https://api.themoviedb.org/3/movie/297761/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US")!
        
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
                self.collectionView.reloadData()
                
//                //End refreshing tableview for data
//                self.refreshController.endRefreshing()
                
//                //Display successful HUD animation
//                HUD.flash(.success, delay: 2.0)
                
            }
            
        }
        task.resume()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "posterCell", for: indexPath) as! posterCell
        let movie = movies[indexPath.item];
        cell.posterImageView.af_setImage(withURL: movie.posterURL);
        
        return cell;
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destVC = segue.destination as! movieDetailViewController;
        let item = sender as! UICollectionViewCell;
        
        if let indexPath = collectionView.indexPath(for: item) {
            let movie = movies[indexPath.item]
            destVC.movie = movie;
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
