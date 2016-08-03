//
//  SearchEngine.swift
//  movie
//
//  Created by Albin on 02/08/16.
//  Copyright © 2016 Albin. All rights reserved.
//

import Foundation

//
//  MovieEngine.swift
//  movie
//
//  Created by Albin on 02/08/16.
//  Copyright © 2016 Albin. All rights reserved.
//

import Foundation
import SwiftyJSON

class SearchEngine {
    
    // MARK: - Classes -
    
    let coreDataManager = CoreDataManager()
    
    let http = Network()
    
    
    func getSearchResult(movieName:String,complete:(AnyObject,Bool) -> Void){
        
        http.get(Constants.url.search + movieName) { (result, error) in
            
            if error != nil{
                
                print(error)
                complete(error!,false)
                
            }else{
                
                let json = JSON(data: result)
                complete(self.movieParser(json),true)
            }
        }
    }
    
    
    func movieParser(jsonObject:JSON) -> [SearchModel]{
        
        
        var modelArray:[SearchModel] = []
        if jsonObject["Response"].string! == "True"{
            
            if jsonObject["Search"].count > 0{
                
                print(jsonObject["Search"])
                
                for (_,movie) in jsonObject["Search"]{
                    let model = SearchModel()
                    print( movie["Title"].string!)
                    
                    model.movieTitle = movie["Title"].string!
                    model.movieYear = movie["Year"].string!
                    model.moviePoster = movie["Poster"].string!
                    model.movieType = movie["Type"].string!
                    model.movieImdbString = movie["imdbID"].string!
                    model.response = "True"
                    
                    let data:[String:AnyObject] = [
                        
                        "movieTitle":movie["Title"].string!,
                        "moviePoster":movie["Poster"].string!,
                        "movieImdbString":movie["imdbID"].string!,
                        "movieType":movie["Type"].string!,
                        "movieYear":movie["Year"].string!
                        
                    ]
                    print(data)
                    coreDataManager.createHistoryWithModel(data)
                    modelArray.append(model)
                }
                
                
            }else{
                
                let model = SearchModel()
                model.response = "False"
                modelArray.append(model)
                
            }
            
        }else{
            let model = SearchModel()
            model.response = "False"
            modelArray.append(model)
        }
        
        return modelArray
        
    }
    
    
}
