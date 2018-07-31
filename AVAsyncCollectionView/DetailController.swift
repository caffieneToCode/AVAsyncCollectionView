//
//  DetailController.swift
//  AVAsyncCollectionView
//
//  Created by Ashish Verma on 08/08/17.
//  Copyright © 2017 Ashish. All rights reserved.
//

import UIKit

class DetailController: UIViewController {
    
    //  Elements connected in Storyboard
    @IBOutlet weak var posterImageView: PosterImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    //  Declaring DetailController's Properties
    var movie: Movie?

    //  Overriding parent class's viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //  Setting NavigationBar title from Movie's title property
        if let movieTitle = movie?.title {
            self.title = movieTitle
        }
        
        //  Displaying overview in UI (descriptionTextView) from Movie's overview property
        if let overview = movie?.overview {
            self.descriptionTextView.text = overview
        }
        
        // Calling PosterImageView's method to download Poster Image
        if let path = movie?.poster_path {
            self.posterImageView.getImageFrom(urlString: path)
        }
    }
}
