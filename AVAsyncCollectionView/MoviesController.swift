//
//  MoviesController.swift
//  AVAsyncCollectionView
//
//  Created by Ashish Verma on 08/08/17.
//  Copyright © 2017 Ashish. All rights reserved.
//

import UIKit

// Conforming to UICollectionView's Protocols.
class MoviesController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    // UICollectionView connected ni Storyboard.
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    
    //  Declaring url for API request.
    let URL_base = "https://api.themoviedb.org/3/movie/popular?api_key=e242bce06dcd45bd128ec19f08a37558&language=en-US&page=1"
    
    //  Declaring properties of MoviesController.
    var movies = [Movie]()
    var selectedMovie: Movie?
    
    //  Overriding parent class's viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting UINavigationBar's title
        self.title = "The Movie Database"
        
        //  Setting delegate and data souece for moviesCollectionView.
        self.moviesCollectionView.delegate = self
        self.moviesCollectionView.dataSource = self
        
        // Calling function to download movies from API.
        downloadMovies()
    }

    //  function to download movies from API.
    func downloadMovies() {
        
        //  Constructing URL from String.
        let url = URL.init(string: URL_base)
        
        //  Creating URLRequest from URL.
        let request = URLRequest(url: url!)
        
        //  Sending API request on serviceManager
        ServiceManager.sharedInstance.send(request: request, completinHandler: { (response) -> Void in
            
            //  Optional binding to check if the response exists
            if let results = response["results"] as? [[String : Any]] {
                //  Iterating over array of movies (Dictionary)
                for movieObject in results {
                    
                    // Initialing model from the movieObject (Dictionary).
                    let movie = Movie(movieObject: movieObject)
                    
                    //  Appending objects to array of Movies
                    self.movies.append(movie)
                    
                    //  Reloading moviesCollectionView's data on main thread to reflect changes.
                    DispatchQueue.main.async {
                        self.moviesCollectionView.reloadData()
                    }
                }
            }
        })
    }
    
    //MARK: UICollectionViewDataSource
    
    //  Returning movies array count to display required number of cells in moviesCollectionView.
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //  Dequeuing cells with reuseIdentifier to reuse MovieCells
        if let movieCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as? MovieCell {
            
            //  Configuring MovieCells to be used in moviesCollectionView.
            movieCell.configureCellFor(movie: movies[indexPath.row])
            
            return movieCell
            
        } else {
            return MovieCell()
        }
    }
    
    //MARK: UICollectionViewDelegate
    
    //  Handling events on MovieCells.
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectedMovie = movies[indexPath.row]
        
        //  Triggering navigation to DetailController.
        performSegue(withIdentifier: "ShowDetails", sender: self)
    }
    
     // MARK: - Navigation
    
     // Sending movie object to DetailController before navigation.
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Geting the new view controller using segue.destinationViewController.
        let detailController = segue.destination as? DetailController
        
        // Passing the selected object to DetailController.
        if let movie = selectedMovie {
            detailController?.movie = movie
        }
        
     }
}

