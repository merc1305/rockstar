//
//  RockstarTableCell.swift
//  Appstud
//
//  Created by Toan on 2/17/16.
//  Copyright © 2016 Elisoft Viet Nam. All rights reserved.
//

import UIKit

typealias tapCheckBoxClosure = (sender: UIButton) -> Void

class RockstarTableCell: UITableViewCell {

    static let kCellReuseIdentifier : String = "rockstarTableCell"
    
    static func cellReuseIdentifier() -> String {
        return kCellReuseIdentifier
    }
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var checkBoxButton: UIButton!
    
    var didTapCheckBoxClosure: tapCheckBoxClosure?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        avatarImageView.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func reloadDataFromRSContact(contact: RSContact){
        self.avatarImageView.sd_setImageWithURL(NSURL(string: (contact.profileImage())), placeholderImage: UIImage(named: "avatar"))
        self.nameLabel.text = "\(contact.firstName!) \(contact.lastName!)"
        self.statusLabel.text = contact.status!
        self.checkBoxButton.selected = contact.isBookmark!
    }

    @IBAction func checkBoxTapped(sender: UIButton) {
        self.didTapCheckBoxClosure?(sender: sender)
    }
    
}
