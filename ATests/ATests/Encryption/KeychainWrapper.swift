//
//  KeychainWrapper.swift
//  ATests
//
//  Created by Radu Costea on 05/07/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation
import Security

class KeychainItemWrapper {
    
    var genericPasswordQuery = [NSObject: AnyObject]()
    var keychainItemData = [NSObject: AnyObject]()
    
    var values = [String: AnyObject]()
    
    init(identifier: String, accessGroup: String? = nil) {
        genericPasswordQuery[kSecClass] = kSecClassGenericPassword
        genericPasswordQuery[kSecAttrAccount] = identifier
        
        if let group = accessGroup where TARGET_OS_SIMULATOR != 1 {
            genericPasswordQuery[kSecAttrAccessGroup] = group
        }
        
        genericPasswordQuery[kSecMatchLimit] = kSecMatchLimitOne
        genericPasswordQuery[kSecReturnAttributes] = kCFBooleanTrue
        
        var outDict: AnyObject?
        
        let copyMatchingResult = SecItemCopyMatching(genericPasswordQuery, &outDict)
        
        if copyMatchingResult != noErr {
            resetKeychain()
            
            keychainItemData[kSecAttrAccount] = identifier
            if let group = accessGroup where TARGET_OS_SIMULATOR != 1 {
                keychainItemData[kSecAttrAccessGroup] = group
            }
        } else {
            keychainItemData = secItemDataToDict(outDict as! [NSObject: AnyObject])
        }
    }
    
    subscript(key: String) -> AnyObject? {
        get {
            return values[key]
        }
        
        set(newValue) {
            values[key] = newValue
            writeKeychainData()
        }
    }
    
    func resetKeychain() {
        
        if !keychainItemData.isEmpty {
            let tempDict = dictToSecItemData(keychainItemData)
            var junk = noErr
            junk = SecItemDelete(tempDict as CFDictionary)
            
            assert(junk == noErr || junk == errSecItemNotFound, "Failed to delete current dict")
        }
        
        keychainItemData[kSecAttrAccount] = ""
        keychainItemData[kSecAttrLabel] = ""
        keychainItemData[kSecAttrDescription] = ""
        
        keychainItemData[kSecValueData] = ""
    }
    
    private func secItemDataToDict(data: [NSObject: AnyObject]) -> [NSObject: AnyObject] {
        var returnDict = [NSObject: AnyObject]()
        for (key, value) in data {
            returnDict[key] = value
        }
        
        returnDict[kSecReturnData] = kCFBooleanTrue
        returnDict[kSecClass] = kSecClassGenericPassword
        
        var passwordData: AnyObject?
        
        // We could use returnDict like the Apple example but this crashes the app with swift_unknownRelease
        // when we try to access returnDict again
        let queryDict = returnDict
        
        let copyMatchingResult = SecItemCopyMatching(queryDict as CFDictionary, &passwordData)
        
        if copyMatchingResult != noErr {
            assert(false, "No matching item found in keychain")
        } else {
            let retainedValuesData = passwordData as! NSData
            do {
                let val = try NSJSONSerialization.JSONObjectWithData(retainedValuesData, options: []) as! [String: AnyObject]
                
                returnDict.removeValueForKey(kSecReturnData)
                returnDict[kSecValueData] = val
                
                values = val
            } catch let error as NSError {
                assert(false, "Error parsing json value. \(error.localizedDescription)")
            }
        }
        
        return returnDict
    }
    
    private func dictToSecItemData(dict: [NSObject: AnyObject]) -> [NSObject: AnyObject] {
        var returnDict = [NSObject: AnyObject]()
        
        for (key, value) in keychainItemData {
            returnDict[key] = value
        }
        
        returnDict[kSecClass] = kSecClassGenericPassword
        
        do {
            returnDict[kSecValueData] = try NSJSONSerialization.dataWithJSONObject(values, options: [])
        } catch let error as NSError {
            assert(false, "Error paring json value. \(error.localizedDescription)")
        }
        
        return returnDict
    }
    
    private func writeKeychainData() {
        var attributes: AnyObject?
        var updateItem: [NSObject: AnyObject]?
        
        var result: OSStatus?
        
        let copyMatchingResult = SecItemCopyMatching(genericPasswordQuery, &attributes)
        
        if copyMatchingResult != noErr {
            result = SecItemAdd(dictToSecItemData(keychainItemData), nil)
            assert(result == noErr, "Failed to add keychain item")
        } else {
            updateItem = [String: AnyObject]()
            for (key, value) in attributes as! [String: AnyObject] {
                updateItem![key] = value
            }
            updateItem![kSecClass] = genericPasswordQuery[kSecClass]
            
            var tempCheck = dictToSecItemData(keychainItemData)
            tempCheck.removeValueForKey(kSecClass)
            
            if TARGET_IPHONE_SIMULATOR == 1 {
                tempCheck.removeValueForKey(kSecAttrAccessGroup)
            }
            
            result = SecItemUpdate(updateItem! as CFDictionary, tempCheck as CFDictionary)
            assert(result == noErr, "Failed to update keychain item")
        }
    }
}