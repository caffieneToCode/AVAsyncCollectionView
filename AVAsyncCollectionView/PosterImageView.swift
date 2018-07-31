//
//  PosterImageView.swift
//  AVAsyncCollectionView
//
//  Created by Ashish Verma on 08/08/17.
//  Copyright © 2017 Ashish. All rights reserved.
//

import UIKit

// Creating a cache to cache downloaded images.
let imageCache = NSCache<AnyObject, AnyObject>()

//  Custom UIImageView with fuction to doqwnload images from urlString.
class PosterImageView: UIImageView {
    
    var imgUrlString: String? = nil
    
    //  function to download image for imageview.
    func getImageFrom(urlString: String) {
        
        imgUrlString = urlString
        
        //  constructing URL fron String.
        let imgUrl = URL(string: urlString)
        
        //  Setting placeholder image.
        self.image = UIImage(named: "MoviePlaceHolder")
        
        // Checking for image in the cache.
        if let cachedImage = imageCache.object(forKey: imgUrl as AnyObject) as? UIImage {
            self.image = cachedImage
            
            //  If image is cached return to avoid downloading image again.
            return
        }
        
        //  Creating data task on shared URLsession to download poster image.
        URLSession.shared.dataTask(with: imgUrl!, completionHandler: { (data, response, error) -> Void in
            
            // Logging error description
            if error != nil {
                print(error.debugDescription)
                return
            }
            
            //  Processing UI changes on main thread.
            DispatchQueue.main.async {
                
                //  Caching the image.
                let imageToCache = UIImage(data: data!)
                if self.imgUrlString == urlString {
                    self.image = imageToCache
                }
            }
            
        }).resume() //  Starting data task.
    }
}
