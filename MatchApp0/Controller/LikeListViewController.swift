//
//  LikeListViewController.swift
//  MatchApp0
//
//  Created by Manabu Kuramochi on 2021/06/14.
//

import UIKit



class LikeListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, GetLikeDataProtocol {
    
    
    
    
    
    
    var userDataModelArray = [UserDataModel]()
    var userData = [String:Any]()
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(LikeProfileCell.nib(), forCellReuseIdentifier: LikeProfileCell.identifier)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
        
        let loadDBModel = LoadDBModel()
        loadDBModel.getLikeDataProtocol = self
        loadDBModel.loadLikeList()
        userData = KeyChainConfig.getkeyArrayData(key: "userData")
        tableView.reloadData()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userDataModelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: LikeProfileCell.identifier, for: indexPath) as! LikeProfileCell
        
        cell.configure(nicnameLabelString: userDataModelArray[indexPath.row].name!, ageLabelString: userDataModelArray[indexPath.row].age!, prefectureLabelString: userDataModelArray[indexPath.row].prefecture!, heightLabelString: userDataModelArray[indexPath.row].height!, bloodLabelStrng: userDataModelArray[indexPath.row].bloodType!, genderLabelString: userDataModelArray[indexPath.row].gender!, jobLabelString: userDataModelArray[indexPath.row].job!, quickWordLabelString: userDataModelArray[indexPath.row].quickWord!, profileImageViewString: userDataModelArray[indexPath.row].profileImageString!, uid: userDataModelArray[indexPath.row].uid!, userData: userData)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 580
    }
    
    
    func getLikeDataProtocol(userDataModelArray: [UserDataModel]) {
        
        self.userDataModelArray = []
        self.userDataModelArray = userDataModelArray
        tableView.reloadData()
        
    }
    
    
    
}
