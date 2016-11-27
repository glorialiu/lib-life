//
//  GroupTableViewCell.swift
//  LibLife
//
//  Created by Gloria Liu on 11/20/16.
//  Copyright © 2016 Gloria Liu. All rights reserved.
//

import UIKit

class GroupTableViewCell: UITableViewCell {

   var groupName: String = ""
   
   @IBOutlet weak var groupNameLabel: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
