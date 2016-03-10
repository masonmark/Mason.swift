// Keychain.swift Created by mason on 2016-02-21. Copyright © 2016 masonmark.com. All rights reserved.

import Foundation
import Security


/// Simplest possible wrapper for keychain read/write. (Be aware that this **overwrites** any existing value for key when it writes, by design).

class Keychain {
    
    /// Find and return a blob of data previously stored under `key` using this class's `write()` method. Returns nil if not found.
    
    static func read(key: String) -> NSData? {
        guard key != "" else {
            return nil; // because actually querying with empty string key returns something weird
        }
        
        let query = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : key,
            kSecReturnData as String  : kCFBooleanTrue,
            kSecMatchLimit as String  : kSecMatchLimitOne
        ]
        
        var dataTypeRef: AnyObject?
        let status = withUnsafeMutablePointer(&dataTypeRef) { SecItemCopyMatching(query, UnsafeMutablePointer($0)) }
        
        if status == errSecSuccess {
            if let data = dataTypeRef as! NSData? {
                return data
            }
        }
        return nil
    }
    
    
    static func readString(key:String) -> String? {
        if let data = read(key), stringValue = NSString(data: data, encoding: NSUTF8StringEncoding) {
            return stringValue as String
        } else {
            return nil
        }
    }
    
    
    /// Store `data` to the Keychain, under `key`, **overwriting** any existing value. Returns true on success, false on error.
    
    static func write(key: String, data: NSData) -> Bool {
        let query = [
            kSecClass as String       : kSecClassGenericPassword as String,
            kSecAttrAccount as String : key,
            kSecValueData as String   : data
        ]
        
        SecItemDelete(query as CFDictionary)
        
        let status: OSStatus = SecItemAdd(query as CFDictionary, nil)
        
        return status == noErr
    }
    
}

// Thanks, Obama: https://gist.github.com/jackreichert/414623731241c95f0e20
