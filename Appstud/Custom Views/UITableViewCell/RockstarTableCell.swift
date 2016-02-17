//
//  RockstarTableCell.swift
//  Appstud
//
//  Created by Toan on 2/17/16.
//  Copyright © 2016 Elisoft Viet Nam. All rights reserved.
//

import UIKit

class RockstarTableCell: UITableViewCell {

    static let kCellReuseIdentifier : String = "rockstarTableCell"
    
    static func cellReuseIdentifier() -> String {
        return kCellReuseIdentifier
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
