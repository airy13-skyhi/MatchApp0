//
//  MatchListViewController.swift
//  MatchApp0
//
//  Created by Manabu Kuramochi on 2021/06/15.
//

import UIKit
import Firebase


class MatchListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, GetWhoIsMatchListProtocol {
    
    
    
    
    
    var tableView = UITableView()
    var matchingArray = [UserDataModel]()
    var userData = [String:Any]()
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.frame = view.bounds
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MatchPersonCell.nib(), forCellReuseIdentifier: MatchPersonCell.identifier)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //マッチングの成立相手のデータを取得
        let loadDBModel = LoadDBModel()
        loadDBModel.getWhoIsMatchListProtocol = self
        loadDBModel.loadMatchPersonData()
        userData = KeyChainConfig.getkeyArrayData(key: "userData")
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return matchingArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MatchPersonCell.identifier, for: indexPath) as! MatchPersonCell
        
        cell.configure(nicnameLabelString: matchingArray[indexPath.row].name!, ageLabelString: matchingArray[indexPath.row].age!, jobLabelString: matchingArray[indexPath.row].job!, profileImageViewString: matchingArray[indexPath.row].profileImageString!)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let chatVC = self.storyboard?.instantiateViewController(identifier: "chatVC") as! ChatViewController
        
        self.navigationController?.pushViewController(chatVC, animated: true)
        
    }
    
    func getWhoIsMatchListProtocol(userDataModelArray: [UserDataModel]) {
        
        matchingArray = userDataModelArray
        tableView.reloadData()
    }
    
    
}
