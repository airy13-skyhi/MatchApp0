//
//  InputProfileTextController.swift
//  MatchApp0
//
//  Created by Manabu Kuramochi on 2021/06/04.
//

import UIKit

class InputProfileTextController: UIViewController {
    
    
    @IBOutlet weak var profileTextView: UITextView!
    @IBOutlet weak var doneButton: UIButton!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        Util.rectButton(button: doneButton)
        

        
    }
    
    
    
    @IBAction func done(_ sender: Any) {
        
        let manager = Manager.shared
        
        print(manager.profile)
        
        manager.profile = profileTextView.text
        dismiss(animated: true, completion: nil)
        
        
    }
    
    
    
    
    
    

}
