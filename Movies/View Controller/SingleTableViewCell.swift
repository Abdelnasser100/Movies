//
//  SingleTableViewCell.swift
//  Movies
//
//  Created by Abdelnasser on 23/08/2021.
//

import UIKit

class SingleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var moveImg: UIImageView!
    
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var namelabel: UILabel!
    
    
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
