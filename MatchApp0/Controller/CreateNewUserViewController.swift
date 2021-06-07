//
//  CreateNewUserViewController.swift
//  MatchApp0
//
//  Created by Manabu Kuramochi on 2021/06/03.
//

import UIKit
import Firebase



class CreateNewUserViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, ProfileSendDone {
    
    
    
    
    var agePicker = UIPickerView()
    var heightPicker = UIPickerView()
    var bloodPicker = UIPickerView()
    var prefecturePicker = UIPickerView()
    
    var dataStringArray = [String]()
    var dataIntArray = [Int]()
    
    var fbAuth = Auth.auth()
    
    var gender = String()
    
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nicnameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var bloodTypeTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var jobTextField: UITextField!
    @IBOutlet weak var quickWordTextField: UITextField!
    
    @IBOutlet weak var toProfileButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    
    
    
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
        
        Util.rectButton(button: toProfileButton)
        Util.rectButton(button: doneButton)
        
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
            dataStringArray = Util.prefectures()
            return dataStringArray.count
            
        default:
            return 0
        }
        
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch pickerView.tag {
        
        case 1:
            ageTextField.text = String(dataIntArray[row]) + "歳"
            ageTextField.resignFirstResponder()
            break
        case 2:
            heightTextField.text = String(dataIntArray[row]) + "cm"
            heightTextField.resignFirstResponder()
            break
        case 3:
            bloodTypeTextField.text = dataStringArray[row] + "型"
            bloodTypeTextField.resignFirstResponder()
            break
        case 4:
            addressTextField.text = dataStringArray[row]
            addressTextField.resignFirstResponder()
            break
        default:
            break
        }
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        switch pickerView.tag {
        case 1:
            return String(dataIntArray[row]) + "歳"
        case 2:
            return String(dataIntArray[row]) + "cm"
        case 3:
            return dataStringArray[row] + "型"
        case 4:
            return dataStringArray[row]
            
        default:
            return ""
        }
        
    }
    
    
    
    @IBAction func genderSwitch(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            gender = "男性"
            
        }else {
            gender = "女性"
        }
        
        
        
    }
    
    
    @IBAction func done(_ sender: Any) {
        
        let manager = Manager.shared.profile
        
        fbAuth.signInAnonymously { result, error in
            
            if error != nil {
                print(error.debugDescription)
                return
            }
            
            if let range0 = self.ageTextField.text?.range(of: "歳") {
                self.ageTextField.text?.replaceSubrange(range0, with: "")
            }
            
            if let range1 = self.heightTextField.text?.range(of: "cm") {
                self.heightTextField.text?.replaceSubrange(range1, with: "")
            }
            
            
            let userData = UserDataModel(name: self.nicnameTextField.text, age: self.ageTextField.text, height: self.heightTextField.text, bloodType: self.bloodTypeTextField.text, prefecture: self.addressTextField.text, gender: self.gender, profile: manager, profileImageString: "", uid: self.fbAuth.currentUser?.uid, quickWord: self.quickWordTextField.text, job: self.jobTextField.text, date: Date().timeIntervalSince1970, onlineORNot: true)
            
            let sendDBModel = SendDBModel()
            sendDBModel.profileSendDone = self
            sendDBModel.sendProfileData(userData: userData, profileImageData: (self.imageView.image?.jpegData(compressionQuality: 0.4))!)
            
            
            
        }
        
        
    }
    
    
    
    func profileSendDone() {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    
    
    @IBAction func tap(_ sender: Any) {
        
        func openCamera() {
            let sourceType:UIImagePickerController.SourceType = .photoLibrary
            // カメラが利用可能かチェック
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                // インスタンスの作成
                let cameraPicker = UIImagePickerController()
                cameraPicker.sourceType = sourceType
                cameraPicker.delegate = self
                cameraPicker.allowsEditing = true
                //cameraPicker.showsCameraControls = true
                present(cameraPicker, animated: true, completion: nil)
                
            }else {
                
            }
            
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            
            if let pickedImage = info[.editedImage] as? UIImage {
                imageView.image = pickedImage
                //閉じる処理
                picker.dismiss(animated: true, completion: nil)
            }
            
        }
        
        // 撮影がキャンセルされた時に呼ばれる
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
        }
        
        
    }
    
    
    
}
