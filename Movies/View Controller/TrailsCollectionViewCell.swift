//
//  TrailsCollectionViewCell.swift
//  Movies
//
//  Created by Abdelnasser on 14/08/2021.
//

import UIKit
import youtube_ios_player_helper

class TrailsCollectionViewCell: UICollectionViewCell {
   
   @IBOutlet weak var viewPlayer: YTPlayerView!
    
    
    
         
         override init(frame: CGRect) {
             super.init(frame: frame)
             
         }
         
         required init?(coder: NSCoder) {
             super.init(coder: coder)
             
         }
         
    
}
