//
//  NetworkDatabase Manager.swift
//  Movies
//
//  Created by Abdelnasser on 12/08/2021.
//

import Foundation
import Alamofire


class ApiServiceManager{
    
   
    func fetchDataFromApiByAlamofire( completion :@escaping ([Result]?,String?)->Void){
     
       let url = URL(string:"https://api.themoviedb.org/3/discover/movie?api_key=15ce9ec70ad1f97cc77805efcdc0bb68")
  
        
        let request = AF.request(url!,method: .get,encoding: JSONEncoding.default)
        
  
        request.responseJSON { (dataResponse) in
            
            
            if let data = dataResponse.data {
                
                
              let jsonDecoder = JSONDecoder()
                if let decodedObj = try?jsonDecoder.decode(Movie.self , from: data){
                   completion(decodedObj.results , nil)
                }
            }
           
            if let error = dataResponse.error {
                completion(nil , error.localizedDescription)
                
            }
        }
    }
   

    func fetchDataFromApiByAlamofire(id :Int, completion :@escaping ([Details]?,String?)->Void){

        let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)/videos?api_key=15ce9ec70ad1f97cc77805efcdc0bb68")

        let request = AF.request(url! , method: .get , encoding: JSONEncoding.default)

        request.responseJSON { (dataResponse) in

            if let data = dataResponse.data{

                let jsonDecoder = JSONDecoder()
                if let decodedObj = try?jsonDecoder.decode(Trials.self , from : data){

                    completion(decodedObj.results,nil)
                }

                }
            if let error = dataResponse.error{
                completion(nil,error.localizedDescription)
            }
        }

    }
    
    
    
        func fetchDataFromApiByAlamofir(id:Int , completion :@escaping ([Content]?,String?)->Void){
            
             
           let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)/reviews?api_key=15ce9ec70ad1f97cc77805efcdc0bb68")
            
            let request = AF.request(url! , method: .get , encoding: JSONEncoding.default)
            
            request.responseJSON { (dataResponse) in
                
                if let data = dataResponse.data{
                    
                    let jsonDecoder = JSONDecoder()
                    if let decodedObj = try?jsonDecoder.decode(Review.self , from : data){
                      // print(decodedObj)
                        completion(decodedObj.results,nil)
                    }
                        
                    }
                if let error = dataResponse.error{
                    completion(nil,error.localizedDescription)
                }
            }
            
        }
}



