//
//  Network.swift
//  movie
//
//  Created by Albin on 02/08/16.
//  Copyright © 2016 Albin. All rights reserved.
//

import Foundation

class Network{
    
    func get(url:String,completionHandler: (result: NSData!, error: NSError?) -> ()) {
        
        if IJReachability.isConnectedToNetwork() {
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let session = NSURLSession.sharedSession()
        request.HTTPMethod = "GET"
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            
            if let error = error {
                completionHandler(result: nil, error: error)
            } else {
                completionHandler(result: data, error: nil)
            }
            
        })
        task.resume()
        
        }else{
            let error = NSError(domain: "no internet connection", code: 404, userInfo: nil)
            completionHandler(result: nil, error: error)
        }
    
    }
}