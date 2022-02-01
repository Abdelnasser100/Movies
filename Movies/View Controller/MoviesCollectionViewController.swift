//
//  MoviesCollectionViewController.swift
//  Movies
//
//  Created by Abdelnasser on 12/08/2021.
//

import UIKit
import SDWebImage
import CoreData
import Alamofire

class MoviesCollectionViewController: UICollectionViewController , UICollectionViewDelegateFlowLayout{

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var sortBtn: UIBarButtonItem!
        
        var appDelegate:AppDelegate!
        var managedObjectContext : NSManagedObjectContext!
         var moveArray:[Result] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        activityIndicator.startAnimating()
               
               appDelegate = (UIApplication.shared.delegate as! AppDelegate)
               managedObjectContext = appDelegate.persistentContainer.viewContext
               
               // Check on Internet Connection
               if !(NetworkManager.shared.isConnected()) {
                displayData()
                 }
        
        
        //Create Menu of Sort Button
        let sortMenu = UIMenu(title: "", children: [
            UIAction(title: "Highst Rate", handler: { _ in
                self.activityIndicator.startAnimating()
                let sortedArray = self.moveArray.sorted { first, second in
                    return first.rate > second.rate
                }
                self.moveArray = sortedArray
                self.collectionView.reloadData()
                self.activityIndicator.stopAnimating()
            }),
            UIAction(title: "Popularity", handler: { _ in
                self.activityIndicator.startAnimating()
                let sortedArray = self.moveArray.sorted { first, second in
                    return first.popularity > second.popularity
                }
                self.moveArray = sortedArray
                self.collectionView.reloadData()
                self.activityIndicator.stopAnimating()
            })
        ])
        
        self.sortBtn.menu = sortMenu
        
         }
    
    override func viewWillAppear(_ animated: Bool) {
      
            
         
        ApiServiceManager().fetchDataFromApiByAlamofire {(fetchedMoveArray, error) in
            
            self.activityIndicator.stopAnimating()
            
            if let unwappedMoveArray = fetchedMoveArray{
                
                self.moveArray = unwappedMoveArray
                
                DispatchQueue.main.async {
                    
                    self.collectionView.reloadData()
                }
            }
            
            for result in self.moveArray{
                self.saveData(MovieObj: result)
            }
            
            if let unwappedError = error{
                print(unwappedError)
            }
            
        }
           
        setupUi()
       
    }

 

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return moveArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)as!SingleCollectionViewCell
    
        let url = "https://image.tmdb.org/t/p/w185/\(moveArray[indexPath.row].postar)"
        
        cell.moveImg.sd_setImage(with: URL(string: url), placeholderImage: UIImage(systemName: "exclamationmark.triangle.fill"))
        
        
        
        
        return cell
    }
    
    
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let vc = storyboard?.instantiateViewController(identifier: "DVC")as? DetailsViewController{


            vc.move = moveArray[indexPath.row]

            self.navigationController?.pushViewController(vc, animated: true)
        }
   
    }
    
    
    
    func saveData(MovieObj: Result){

            let entity = NSEntityDescription.entity(forEntityName: "Movies", in: managedObjectContext)!
            let movie = NSManagedObject(entity: entity, insertInto: managedObjectContext)

            movie.setValue(MovieObj.titel, forKey: "titel")
           // movie.setValue(MovieObj.releaseData, forKey: "releasedate")
            movie.setValue(MovieObj.rate, forKey: "rate")
            movie.setValue(MovieObj.postar, forKey: "postar")
           // movie.setValue(MovieObj.overView, forKey: "overview")

            do {
                 try managedObjectContext.save()
               // print("data saved")
            }
            catch let error as NSError {
                print(error.localizedDescription)
            }
        }

        func displayData(){

            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Movies")
            do {
                let movies = try managedObjectContext.fetch(fetchRequest)
                for mov in movies {

                   let titel  = mov.value(forKey: "titel") as! String
                   let postar =  mov.value(forKey: "postar") as! String
                  // let releaseDate = mov.value(forKey: "releasedate") as! String
                   let rating = mov.value(forKey: "rate") as! Double
                  // let overView = mov.value(forKey: "overview") as! String

                    let movObj = Result(postar: postar, id: 0, titel: titel, popularity: 0.0, overView: "overView", releaseData: "releaseDate", rate: rating)

                   moveArray.append(movObj)
               }
            }
            catch let error as NSError {
                print(error.localizedDescription)
            }
        }


 

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

    func setupUi(){
        
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
         
         item.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1)
         
         
        let horizontlGgroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.25)), subitem: item, count: 2)
         
         
         let section = NSCollectionLayoutSection(group: horizontlGgroup)
         
         let layout = UICollectionViewCompositionalLayout(section: section)
         
         
         collectionView.collectionViewLayout = layout
         
         
         
         
    }
    
    
}
