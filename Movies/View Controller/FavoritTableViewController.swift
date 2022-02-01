//
//  FavoritTableViewController.swift
//  Movies
//
//  Created by Abdelnasser on 14/08/2021.
//


import SDWebImage
import UIKit
import CoreData


class FavoritTableViewController: UITableViewController {
  
    var appdelegate:AppDelegate!
    var managedObjectContext:NSManagedObjectContext!
    var coreMoveArray :[NSManagedObject] = [ ]
    var favArray:[Result] = []
   
    
    
    override func viewDidLoad() {
        
        appdelegate = (UIApplication.shared.delegate as!AppDelegate)
        managedObjectContext = appdelegate.persistentContainer.viewContext
    
    }
    
    override func viewWillAppear(_ animated: Bool) {

        let request = NSFetchRequest<NSManagedObject>(entityName: "Entity")
        
        do {
            coreMoveArray = try managedObjectContext.fetch(request)
            
            favArray.removeAll()
            
            for move in coreMoveArray {
                
                let name = move.value(forKey: "name") as! String
                let image = move.value(forKey: "image") as! String
                
                let moveObj = Result(postar: image, id: 0, titel: name, popularity: 0.0, overView: "", releaseData: "", rate: 0.0)
                favArray.append(moveObj)
                
            }
            tableView.reloadData()
        }
        
        
        catch let error as NSError{
            
            print(error.localizedDescription)
        }
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return favArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)as!SingleTableViewCell
        
        cell.namelabel.text = favArray[indexPath.row].titel
        
        let img = favArray[indexPath.row].postar
        let url = "https://image.tmdb.org/t/p/w185\(img)"
        
        cell.moveImg?.sd_setImage(with: URL(string: "\(url)"), placeholderImage: UIImage(systemName: "exclamationmark.triangle.fill"))
        
                            

        return cell
    }
    
 
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 120
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let userDefault = UserDefaults.standard
            let deletedMovieTitle = favArray[indexPath.row].titel
            userDefault.setValue(false, forKey: "highLightStar\(deletedMovieTitle)" )
            
            favArray.remove(at: indexPath.row)
            managedObjectContext.delete(coreMoveArray[indexPath.row])
            
            do{
                try managedObjectContext.save()
            }
            catch let error as NSError {
                print(error.localizedDescription)
            }
            
            tableView.deleteRows(at: [indexPath], with: .fade)
//            tableView.reloadData()
                } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }

    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
