//
//  Trials.swift
//  Movies
//
//  Created by Abdelnasser on 14/08/2021.
//

import Foundation


struct Trials:Codable {
    
       let id: Int
       var results:[Details] 
}


struct Details : Codable {
    
    var key:String
    
    enum CodingKeys : String,CodingKey{
        
        case key = "key"
        
    }
}
