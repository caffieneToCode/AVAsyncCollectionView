//
//  Movie.swift
//  AVAsyncCollectionView
//
//  Created by Ashish Verma on 08/08/17.
//  Copyright © 2017 Ashish. All rights reserved.
//

import Foundation

//  Creating Model class for Movie Objects.
class Movie {
    
    //  Setting the imgBaseUrl given by the API.
    let imgBaseUrl = "https://image.tmdb.org/t/p/w500"
    
    //  Declaring properties of Movie.
    var title: String!
    var overview: String!
    var poster_path: String!
    
    //  Initializer for Movie to set the properties when the object is created.
    init(movieObject: [String:Any]) {
        
        //  Optional binding to unwrap and use title from movieObject
        if let title = movieObject["title"] as? String {
            self.title = title
        }
        
        if let overview = movieObject["overview"] as? String {
            self.overview = overview
        }
        
        if let path = movieObject["poster_path"] as? String {
            self.poster_path = "\(imgBaseUrl)\(path)"
        }
    }
}
