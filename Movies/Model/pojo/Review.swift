//
//  Review.swift
//  Movies
//
//  Created by Abdelnasser on 13/08/2021.
//

import Foundation

struct Review:Codable {

    let id, page: Int
    var results:[Content] 
    
}


struct Content:Codable {
    
    var content :String
    var author : String
    
    enum CodingKeys : String,CodingKey {
        case content = "content"
        case author = "author"
    }
}



