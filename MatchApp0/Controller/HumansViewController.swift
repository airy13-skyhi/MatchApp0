//
//  HumansViewController.swift
//  MatchApp0
//
//  Created by Manabu Kuramochi on 2021/06/08.
//

import UIKit
import Firebase


class HumansViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    let sectionInsets = UIEdgeInsets(top: 10.0, left: 2.0, bottom: 2.0, right: 2.0)
    
    let itemsPerRow:CGFloat = 2
    var searchORNot = Bool()
    
    
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var ashiatoButton: UIButton!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
        
        
        if Auth.auth().currentUser?.uid != nil && searchORNot == false {
            
            
            collectionView.delegate = self
            collectionView.dataSource = self
            
            
            //let userData = key
            
            
        }else if Auth.auth().currentUser?.uid != nil && searchORNot == true {
            
            collectionView.reloadData()
            
            
            
        }else {
            performSegue(withIdentifier: "inputVC", sender: nil)
            
        }
        
        
        
        
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    
    
    
    
    
}
