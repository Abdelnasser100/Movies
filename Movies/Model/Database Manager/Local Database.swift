//
//  Local Database.swift
//  Movies
//
//  Created by Abdelnasser on 31/08/2021.
//

import Foundation
import CoreData


//class LocalDatabase {
//    
//    var appDelegate:AppDelegate!
//    var managedObjectContext : NSManagedObjectContext!
//        
//        
//        var allMovies :[Result] = []
//    
//    
//    func saveData(MovieObj: Result){
//            
//            let entity = NSEntityDescription.entity(forEntityName: "Movies", in: managedObjectContext)!
//            
//            let movie = NSManagedObject(entity: entity, insertInto: managedObjectContext)
//            
//            movie.setValue(MovieObj.titel, forKey: "titel")
//            movie.setValue(MovieObj.releaseData, forKey: "releasedate")
//            movie.setValue(MovieObj.rate, forKey: "rate")
//            movie.setValue(MovieObj.postar, forKey: "postar")
//            movie.setValue(MovieObj.overView, forKey: "overview")
//            
//            do {
//                 try managedObjectContext.save()
//                print("data saved")
//            }
//            catch let error as NSError {
//                print(error.localizedDescription)
//            }
//            
//        }
//
//    
//    func displayData() -> [Result]{
//            
//            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Movies")
//            
//            do {
//                let movies = try managedObjectContext.fetch(fetchRequest)
//                
//                for mov in movies {
//               
//                   let titel  = mov.value(forKey: "titel") as! String
//                   let postar =  mov.value(forKey: "postar") as! String
//                   let releaseDate = mov.value(forKey: "releasedate") as! String
//                   let rating = mov.value(forKey: "rate") as! Double
//                   let overView = mov.value(forKey: "overview") as! String
//
//                    
//                    let movObj = Result(postar: postar, id: 0, titel: titel, popularity: 0.0, overView: overView, releaseData: releaseDate, rate: rating)
//                    
//                   allMovies.append(movObj)
//               }
//                
//            }
//            catch let error as NSError {
//                print(error.localizedDescription)
//            }
//            return allMovies
//        }
//    
//}
