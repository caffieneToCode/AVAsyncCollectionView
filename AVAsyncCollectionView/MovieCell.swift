//
//  MovieCell.swift
//  AVAsyncCollectionView
//
//  Created by Ashish Verma on 08/08/17.
//  Copyright © 2017 Ashish. All rights reserved.
//

import UIKit

//  Creating custom UICollectionViewCell to display Movie objects
class MovieCell: UICollectionViewCell {
    
    //  Elements connected in Storyboard
    @IBOutlet weak var posterImageView: PosterImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    //  Configuration method to show properties in the UI
    func configureCellFor(movie: Movie) {
        
        //  Optional binding to unwrap and use title from movie
        if let title = movie.title {
            titleLabel.text = title
        }
        
        // Calling PosterImageView's method to download Poster Image
        if let path = movie.poster_path {
            self.posterImageView.getImageFrom(urlString: path)
        }
    }
}
