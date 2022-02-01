//
//  DetailsViewController.swift
//  Movies
//
//  Created by Abdelnasser on 12/08/2021.
//

import UIKit
import Cosmos
import youtube_ios_player_helper
import SDWebImage
import CoreData
import Foundation

class DetailsViewController: UIViewController{
    
    //OutLit
 
    @IBOutlet weak var titelLabel: UILabel!
    @IBOutlet weak var viewStar: CosmosView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var releasDataLabel: UILabel!
    @IBOutlet weak var overViewLabel: UILabel!
    @IBOutlet weak var favoritStarshang: UIButton!
    @IBOutlet weak var detailsTextView: UITextView!
    @IBOutlet weak var trialsCollectionView: UICollectionView!
    
    
    
    //vars
    
    let userDefault = UserDefaults.standard
    
    var appDelegate:AppDelegate!
    var managedObjectContext:NSManagedObjectContext!
 
   
   var contentArray :[Content] = []
   var videoArray:[Details] = []
   var movArray:[Result] = []
    var move : Result!
 
   
    override func viewDidLoad() {
        super.viewDidLoad()
   
       
        //Check if the star is highlight or no
        
        let highLightCheck = userDefault.bool(forKey: "highLightStar\(move.titel)")
        if highLightCheck {
            favoritStarshang.setImage(UIImage(systemName: "star.fill"), for: .normal)
        }else{
            favoritStarshang.setImage(UIImage(systemName: "star"), for: .normal)
        }
        
        favoritStarshang.tintColor = #colorLiteral(red: 0.90296489, green: 0.7730246186, blue: 0.3503800631, alpha: 1)
               
        
        // Display Component
           
        titelLabel.text = move.titel
       
        imgView.image = UIImage(named: move.postar)
        imgView.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w185/\(move.postar)"), placeholderImage: UIImage(systemName:"exclamationmark.triangle.fill" ))
        
        releasDataLabel.text = move.releaseData
        overViewLabel.text = move.overView
        
        
        move.rate = move.rate/2.0
        viewStar.rating = move.rate
        
        appDelegate = (UIApplication.shared.delegate as! AppDelegate)
        managedObjectContext = appDelegate.persistentContainer.viewContext
        
        trialsCollectionView.delegate = self
        trialsCollectionView.dataSource = self
    
    }


   
    override func viewWillAppear(_ animated: Bool) {
        
   
        ApiServiceManager().fetchDataFromApiByAlamofire(id: move.id) {(fetchVideoArray, error) in

            if let unwrappedVideoArray = fetchVideoArray{

                    self.videoArray = unwrappedVideoArray
                DispatchQueue.main.async {
               
                    self.trialsCollectionView.reloadData()
                }
            }
            if let unwappedError = error{
                print(unwappedError)

            }

        }
        

        ApiServiceManager().fetchDataFromApiByAlamofir(id:move.id){(fetchReview ,error) in

            if let unwrappedReviewArray = fetchReview{
                
                  self.contentArray = unwrappedReviewArray
                
                if !(self.contentArray .isEmpty){
                        self.detailsTextView.text = self.contentArray[0].content
                    }
            }
            if let unwappedError = error{
                print(unwappedError)

            }
      
        }
        
     setupUi()
    }
    
    

    @IBAction func textViewBut(_ sender: Any) {
        
        if let vc = self.storyboard?.instantiateViewController(identifier: "RVC")as?ReviewTableViewController{
           
            vc.ReviewArray = contentArray
                self.navigationController?.pushViewController(vc, animated: true)
            
        }
     
    }
    
    
    @IBAction func favoritBtu(_ sender: UIButton) {
        
        favoritStarshang.setImage(UIImage(systemName: "star.fill"), for: .normal)
        userDefault.setValue(true, forKey: "highLightStar\(move.titel)")
            saveData(MovieObj: move)
        movArray.removeAll()
     
    }
    

}


extension DetailsViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return videoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TrailsCollectionViewCell
    

        cell.viewPlayer.load(withVideoId: videoArray[indexPath.row].key)
            
            return cell
             
    }
    
    
    
    func setupUi(){

            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))

            let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)), subitem: item ,count: 1)

            let section = NSCollectionLayoutSection(group: group)
            
            section.orthogonalScrollingBehavior = .paging

            let layout = UICollectionViewCompositionalLayout(section: section)

           trialsCollectionView.collectionViewLayout = layout


        }
    
    func saveData(MovieObj: Result){
            
            let entity = NSEntityDescription.entity(forEntityName: "Entity", in: managedObjectContext)!
            let movie = NSManagedObject(entity: entity, insertInto: managedObjectContext)
    
            movie.setValue(MovieObj.titel, forKey: "name")
            movie.setValue(MovieObj.postar, forKey: "image")
            
            do {
                 try managedObjectContext.save()
                print("data saved")
                
            }
            
            catch let error as NSError {
                print(error.localizedDescription)
            }
        }
     

}
    
