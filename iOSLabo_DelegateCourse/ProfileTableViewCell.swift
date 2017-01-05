//
//  ProfileTableViewCell.swift
//  iOSLabo_DelegateCourse
//
//  Created by Pierre on 03/12/2016.
//  Copyright © 2016 Pierre Boudon. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    
    // Add delegate variable
    var delegate: ProfileTableViewCellDelegate?
    
    // Outlets
    @IBOutlet weak var userImageIV: UIImageView!
    @IBOutlet weak var pseudoL: UILabel!
    @IBOutlet weak var nameL: UILabel!
    
    @IBOutlet weak var followersCountL: UILabel!
    @IBOutlet weak var reposCountL: UILabel!
    @IBOutlet weak var gistsCountL: UILabel!
    @IBOutlet weak var followingCountL: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.userImageIV.layer.cornerRadius = 10
        
        self.userImageIV.isUserInteractionEnabled = true
        self.userImageIV.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ProfileTableViewCell.imageTapped)))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func imageTapped() {
        // Call delegate function
        if let d = self.delegate {
            d.onImageTapped(userImageView: self.userImageIV)
        }
    }
    
    internal static func profileCell() -> ProfileTableViewCell {
        let nibs = Bundle.main.loadNibNamed("ProfileTableViewCell", owner: self, options: nil)
        let cell: ProfileTableViewCell = nibs![0] as! ProfileTableViewCell
        
        return cell
    }
}

// Create ProfileTableViewCellDelegate protocol
// Create onImageTapped function
protocol ProfileTableViewCellDelegate {
    func onImageTapped(userImageView: UIImageView)
}





















