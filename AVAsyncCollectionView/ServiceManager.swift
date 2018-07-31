//
//  ServiceManager.swift
//  AVAsyncCollectionView
//
//  Created by Ashish Verma on 08/08/17.
//  Copyright © 2017 Ashish. All rights reserved.
//

import Foundation

//  Custom class to handle API requests
class ServiceManager {
    
    static let sharedInstance = ServiceManager()
    private init() {
    }
    
    //  Function to send request and asynchronously return response using escaping closure
    func send(request: URLRequest, completinHandler: @escaping ([String : Any]) -> Void) {
        
        //  Creating data task on shared URLsession
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // Logging error description
            if error != nil {
                print(error.debugDescription)
                return
            }
            do {
                // Parsing JSON from the response data
                let responseDictionary = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                
                //  Returning parsed JSON to the caller
                completinHandler(responseDictionary as! [String : Any])
            } catch {
                print("Error: Could not download movies")
            }
        
        }.resume()  //  Starting data task.
    }
}
