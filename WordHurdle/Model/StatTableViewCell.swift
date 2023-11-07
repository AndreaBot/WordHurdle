//
//  StatTableViewCell.swift
//  WordHurdle
//
//  Created by Andrea Bottino on 07/11/2023.
//

import UIKit

class StatTableViewCell: UITableViewCell {
    
    @IBOutlet weak var statNameLabel: UILabel!
    @IBOutlet weak var statValueLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
