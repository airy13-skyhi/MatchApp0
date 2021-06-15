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
        
        
        //マッチング成立＝collection(macthing)に入れる
        sendDBModel.sendToMatchingList(thisUserID: self.uid, nicname: self.userData["nicname"] as! String, age: self.userData["age"] as! String, bloodType: self.userData["bloodType"] as! String, height: self.userData["height"] as! String, prefecture: self.userData["prefecture"] as! String, gender: self.userData["gender"] as! String, profile: self.userData["profile"] as! String, profileImageString: self.userData["profileImageString"] as! String, uid: self.userData["uid"] as! String, quickWord: self.userData["quickWord"] as! String, job: self.userData["job"] as! String, userData: self.userData)
        
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
