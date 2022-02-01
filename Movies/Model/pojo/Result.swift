//
//  Result.swift
//  Movies
//
//  Created by Abdelnasser on 12/08/2021.
//

import Foundation


struct Result :Codable{
    
    var postar :String
    var  id : Int
    var titel : String
    let popularity: Double
    var overView : String
    var releaseData :String
    var rate :Double
    
    
    enum CodingKeys : String,CodingKey{
        case popularity
        case postar = "poster_path"
        case id = "id"
        case titel = "original_title"
        case overView = "overview"
        case releaseData = "release_date"
        case rate = "vote_average"
        
    }
    
}
