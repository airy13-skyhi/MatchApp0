//
//  KeyChainConfig.swift
//  MatchApp0
//
//  Created by Manabu Kuramochi on 2021/06/08.
//

import Foundation
import KeychainSwift


class KeyChainConfig {
    
    
    static func getkeyData(key:String) -> String {
        
        let keychain = KeychainSwift()
        let keyString = keychain.get(key)
        
        return keyString!
    }
    
    
    
    static func setKeyData(value:[String:Any], key:String) {
        
        let keychain = KeychainSwift()
        
        //配列をデータ化
        let archivedData = try! NSKeyedArchiver.archivedData(withRootObject: value, requiringSecureCoding: false)
        keychain.set(archivedData, forKey: key)
        
        
        
    }
    
    
    
    static func getkeyArrayData(key:String) -> [String:Any] {
        
        let keychain = KeychainSwift()
        let keyData = keychain.getData(key)
        
        if keyData != nil {
            
            let unarchivedObject = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(keyData!) as! [String:Any]
                
            return unarchivedObject
                
        }else {
            
            
            return [:]
        }
    
    }
    
    static func getKeyArrayListData(key:String) -> [String] {
        
        let keychain = KeychainSwift()
        let keyData = keychain.getData(key)
        
        if keyData != nil {
            
            let unarchivedObject = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(keyData!) as! [String]
                
            return unarchivedObject
                
        }else {
            
            
            return []
        }
        
        
    }
    
    
    static func setKeyArrayData(value:[String], key:String) {
        
        let keychain = KeychainSwift()
        
        let archivedData = try! NSKeyedArchiver.archivedData(withRootObject: value, requiringSecureCoding: false)
        
        keychain.set(archivedData, forKey: key)
        
    }
    
    
    
}




