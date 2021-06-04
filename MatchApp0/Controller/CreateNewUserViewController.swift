//
//  CreateNewUserViewController.swift
//  MatchApp0
//
//  Created by Manabu Kuramochi on 2021/06/03.
//

import UIKit

class CreateNewUserViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    
    var agePicker = UIPickerView()
    var heightPicker = UIPickerView()
    var bloodPicker = UIPickerView()
    var prefecturePicker = UIPickerView()
    
    var dataStringArray = [String]()
    var dataIntArray = [Int]()
    
    
    var gender = String()
    
    
    
    @IBOutlet weak var nicnameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var bloodTypeTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var jobTextField: UITextField!
    @IBOutlet weak var quickWordTextField: UITextField!
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        ageTextField.inputView = agePicker
        heightTextField.inputView = heightPicker
        bloodTypeTextField.inputView = bloodPicker
        addressTextField.inputView = prefecturePicker
        
        
        agePicker.delegate = self
        agePicker.dataSource = self
        heightPicker.delegate = self
        heightPicker.dataSource = self
        bloodPicker.delegate = self
        bloodPicker.dataSource = self
        prefecturePicker.delegate = self
        prefecturePicker.dataSource = self
        
        agePicker.tag = 1
        heightPicker.tag = 2
        bloodPicker.tag = 3
        prefecturePicker.tag = 4
        
        gender = "男性"
        
        
        
        
    }
    
    
    

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch pickerView.tag {
        case 1:
            dataIntArray = ([Int])(18...80)
            return dataIntArray.count
        case 2:
            dataIntArray = ([Int])(130...200)
            return dataIntArray.count
        case 3:
            dataStringArray = ["A型","B型","O型","AB型"]
            return dataStringArray.count
        case 4:
            dataStringArray = ["A型","B型","O型","AB型"]
            return dataStringArray.count
            
        default:
            return 0
        }
        
    }
    
    
    
    

}
