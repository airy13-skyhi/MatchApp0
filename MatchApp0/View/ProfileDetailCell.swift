//
//  ProfileDetailCell.swift
//  MatchApp0
//
//  Created by Manabu Kuramochi on 2021/06/10.
//

import UIKit



class ProfileDetailCell: UITableViewCell {
    
    

    @IBOutlet weak var nicnameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var prefectureLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var bloodLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var jobLabel: UILabel!
    
    
    static let identifire = "ProfileDetailCell"
    
    
    static func nib() -> UINib {
        
        return UINib(nibName: "ProfileDetailCell", bundle: nil)
    }
    
    
    func configure(nicnameLabelString:String, ageLabelString:String, prefectureLabelString:String, heightLabelString:String, bloodLabelStrng:String, genderLabelString:String, jobLabelString:String) {
        
        nicnameLabel.text = nicnameLabelString
        ageLabel.text = ageLabelString
        prefectureLabel.text = prefectureLabelString
        heightLabel.text = heightLabelString
        bloodLabel.text = bloodLabelStrng
        genderLabel.text = genderLabelString
        jobLabel.text = jobLabelString
        
        
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
