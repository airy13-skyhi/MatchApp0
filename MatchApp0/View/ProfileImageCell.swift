//
//  ProfileImageCell.swift
//  MatchApp0
//
//  Created by Manabu Kuramochi on 2021/06/10.
//

import UIKit
import SDWebImage


class ProfileImageCell: UITableViewCell {
    
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nicnameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var prefectureLabel: UILabel!
    @IBOutlet weak var quickWordLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    
    static let identifire = "ProfileImageCell"
    
    
    static func nib() -> UINib {
        
        return UINib(nibName: "ProfileImageCell", bundle: nil)
    }
    
    
    func configure(profileImageString:String, nicnameLabelString:String, ageLabelString:String, prefectureLabelString:String, quickWordLabelString:String, likeLabelString:String) {
        
        profileImageView.sd_setImage(with: URL(string: profileImageString), completed: nil)
        nicnameLabel.text = nicnameLabelString
        ageLabel.text = ageLabelString
        prefectureLabel.text = prefectureLabelString
        quickWordLabel.text = quickWordLabelString
        likeLabel.text = likeLabelString
        
    }
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        profileImageView.layer.cornerRadius = profileImageView.frame.width/2
        profileImageView.clipsToBounds = true
        
        
    }

    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        

        
    }
    
}





