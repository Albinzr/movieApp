//
//  MovieEngine.swift
//  movie
//
//  Created by Albin on 02/08/16.
//  Copyright © 2016 Albin. All rights reserved.
//

import Foundation
import SwiftyJSON

class MovieEngine {
    
    let http = Network()
    
    
    func getMovieDetails(imdbString:String,complete:(AnyObject,Bool) -> Void){
        
        http.get(Constants.url.singleMovie + imdbString) { (result, error) in
            
            if error != nil{
                
                print(error)
                complete(error!,false)
                
            }else{
                
                let json = JSON(data: result)
                complete(self.movieParser(json),true)
            }
        }
    }
    
    
    func movieParser(jsonObject:JSON) -> MovieModel{
        
        let model = MovieModel()
        if jsonObject["Response"].string! == "True"{
            model.title = jsonObject["Title"].string!
            model.year = jsonObject["Year"].string!
            model.rated = jsonObject["Rated"].string!
            model.released = jsonObject["Released"].string!
            model.runTime = jsonObject["Runtime"].string!
            model.genre = jsonObject["Genre"].string!
            model.director = jsonObject["Director"].string!
            model.writer = jsonObject["Writer"].string!
            model.actor = jsonObject["Actors"].string!
            model.plot = jsonObject["Plot"].string!
            model.language = jsonObject["Language"].string!
            model.country = jsonObject["Country"].string!
            model.awards = jsonObject["Awards"].string!
            model.poster = jsonObject["Poster"].string!
            model.metaScore = jsonObject["Metascore"].string!
            model.imdbRating = jsonObject["imdbRating"].string!
            model.imdbVotes = jsonObject["imdbVotes"].string!
            model.response = jsonObject["Response"].string!
        }else{
            model.response = "False"
        }
        
        return model
        
    }
    
    
}
