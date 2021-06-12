//
//  ProfileTextCell.swift
//  MatchApp0
//
//  Created by Manabu Kuramochi on 2021/06/10.
//

import UIKit



class ProfileTextCell: UITableViewCell {
    
    
    @IBOutlet weak var profileTextView: UITextView!
    
    
    
    
    static let identifire = "ProfileTextCell"
    
    
    static func nib() -> UINib {
        
        return UINib(nibName: "ProfileTextCell", bundle: nil)
    }
    
    
    
    func configure(profileTextString:String) {
        
        profileTextView.text = profileTextString
        
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
        
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
        

        
    }
    
}
