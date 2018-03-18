//
//  ResultDetailsPropertyCell.swift
//  Farfalla
//
//  Created by Stephen Rakonza on 3/17/18.
//  Copyright © 2018 SR. All rights reserved.
//

import UIKit

class ResultDetailsPropertyCell: UITableViewCell {
    
    @IBOutlet var lblProperty: UILabel?
    @IBOutlet var lblPropertyValye: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
