//
//  MatchPersonCell.swift
//  MatchApp0
//
//  Created by Manabu Kuramochi on 2021/06/15.
//

import UIKit




class MatchPersonCell: UITableViewCell {
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var jobLabel: UILabel!
    
    
    
    static let identifier = "MatchPersonCell"
    
    
    static func nib() -> UINib {
        
        return UINib(nibName: "MatchPersonCell", bundle: nil)
    }
    
    
    func configure(nicnameLabelString:String, ageLabelString:String, jobLabelString:String,  profileImageViewString:String) {
        
        userNameLabel.text = nicnameLabelString
        ageLabel.text = ageLabelString
        jobLabel.text = jobLabelString
        profileImageView.sd_setImage(with: URL(string: profileImageViewString), completed: nil)
        
    }
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        profileImageView.layer.cornerRadius = profileImageView.frame.width/2
        
        
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
