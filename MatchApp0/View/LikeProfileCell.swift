//
//  LikeProfileCell.swift
//  MatchApp0
//
//  Created by Manabu Kuramochi on 2021/06/14.
//

import UIKit
import SDWebImage


class LikeProfileCell: UITableViewCell {
    
    
    var userData = [String:Any]()
    var uid = String()
    var profileImageViewString = String()
    
    
    static let identifier = "LikeProfileCell"
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nicnameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var prefectureLabel: UILabel!
    @IBOutlet weak var quickWordLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var bloodLabel: UILabel!
    @IBOutlet weak var jobLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    
    static func nib() -> UINib {
        
        return UINib(nibName: "LikeProfileCell", bundle: nil)
    }
    
    
    func configure(nicnameLabelString:String, ageLabelString:String, prefectureLabelString:String, heightLabelString:String, bloodLabelStrng:String, genderLabelString:String, jobLabelString:String, quickWordLabelString:String, profileImageViewString:String, uid:String, userData:[String:Any]) {
        
        nicnameLabel.text = nicnameLabelString
        ageLabel.text = ageLabelString
        prefectureLabel.text = prefectureLabelString
        heightLabel.text = heightLabelString
        bloodLabel.text = bloodLabelStrng
        genderLabel.text = genderLabelString
        jobLabel.text = jobLabelString
        quickWordLabel.text = quickWordLabelString
        profileImageView.sd_setImage(with: URL(string: profileImageViewString), completed: nil)
        
        self.uid = uid
        self.userData = userData
        self.profileImageViewString = profileImageViewString
        
        Util.rectButton(button: likeButton)
    }
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        profileImageView.layer.cornerRadius = profileImageView.frame.width/2
        
    }
    
    
    @IBAction func likeAction(_ sender: Any) {
        
        //いいねを飛ばす
        let sendDBModel = SendDBModel()
        sendDBModel.sendToLikeFromLike(likeFlag: true, thisUserID: self.uid, matchName: nicnameLabel.text!, matchID: self.uid)
        
        print(self.uid)
        print(self.userData["uid"].debugDescription)
        
        //マッチング成立＝collection(macthing)に入れる

        sendDBModel.sendToMatchingList(thisUserID: self.uid, nicname: nicnameLabel.text!, age: ageLabel.text!, bloodType: bloodLabel.text!, height: heightLabel.text!, prefecture: prefectureLabel.text!, gender: genderLabel.text!, profile: "", profileImageString: self.profileImageViewString, uid: self.uid, quickWord: quickWordLabel.text!, job: jobLabel.text!, userData: self.userData)
        
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
