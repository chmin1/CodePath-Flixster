//
//  nowPlayingViewController.swift
//  Flixster
//
//  Created by Chavane Minto on 11/15/17.
//  Copyright © 2017 Chavane Minto. All rights reserved.
//

import UIKit

class nowPlayingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
                
                //The movies are in the form of a LIST of Dictionaries, grab that list
                //The LIST in the JSON object is known as "results"
                let movies = dataDictionary["results"] as! [[String: Any]]
            }
            
        }
        
        task.resume()
        
        
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