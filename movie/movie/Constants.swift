//
//  Constants.swift
//  movie
//
//  Created by Albin on 02/08/16.
//  Copyright © 2016 Albin. All rights reserved.
//

import Foundation
import UIKit


class Constants {

    
    struct color {

        static var salmonColor = UIColor(hexString: "F37374")
        static var salmonLightColor = UIColor(hexString: "ffe3e3")
        static var grey = UIColor(hexString: "606060")
        static var white = UIColor(hexString: "ffffff")

        
    }
    
    struct home {
    
    static var searchTitle = "Search your fav movies"
    static var detail = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. "
    
    }
    
    struct error {
        
        static var notFound = "sorry we couldn't find what you were looking for"
        static var oopsError = "something wend wrong please try again"
        
    }
    
    
    struct url{
        
        static var singleMovie = "http://www.omdbapi.com/?i="
        static var search = "http://www.omdbapi.com/?s="
        
    }
    
}

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.stringByTrimmingCharactersInSet(NSCharacterSet.alphanumericCharacterSet().invertedSet)
        var int = UInt32()
        NSScanner(string: hex).scanHexInt(&int)
        let a, r, g, b: UInt32
        switch hex.characters.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}