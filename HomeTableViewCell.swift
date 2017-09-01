//
//  HomeTableViewCell.swift
//  Learning
//
//  Created by Pivotal DX218 on 2017-08-04.
//  Copyright © 2017 Pivotal DX218. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    // MARK: Properties
    @IBOutlet weak var homeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
