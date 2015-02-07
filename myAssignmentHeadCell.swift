//
//  myAssignmentHeadCell.swift
//  PeopleMakingADifference
//
//  Created by Brian Tan on 2/6/15.
//  Copyright (c) 2015 Brian Tan. All rights reserved.
//

import UIKit

class myAssignmentHeadCell: UITableViewCell {

   
   @IBOutlet weak var headerImage: UIImageView!
   @IBOutlet weak var headerMessage: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
    func setHeaderCell(hImage: String, message: String)
    {
      headerImage.image = UIImage(named: hImage)
      headerMessage.text = message
    }

}
