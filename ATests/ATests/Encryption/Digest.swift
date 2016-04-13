//
//  Digest.swift
//  ATests
//
//  Created by Radu Costea on 13/04/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation
import CommonCrypto

typealias EncriptionFunction = (UnsafePointer<Void>, CC_LONG, UnsafeMutablePointer<UInt8>) -> UnsafeMutablePointer<UInt8>

struct Digest {
    let length: Int32
    let function: EncriptionFunction
    
    init(length: Int32, function: EncriptionFunction) {
        self.length = length
        self.function = function
    }
    
    func digest(data: NSData) -> NSData {
        var hash = [UInt8](count: Int(length), repeatedValue: 0)
        function(data.bytes, UInt32(data.length), &hash)
        return NSData(bytes: hash, length:  hash.count)
    }
    
    func digest(string: String) -> String? {
        guard let data = string.dataUsingEncoding(NSUTF8StringEncoding) else {
            return nil
        }
        let digestData = self.digest(data)
        
        var digest = [UInt8](count: Int(length), repeatedValue: 0)
        digestData.getBytes(&digest, length: Int(length) * sizeof(UInt8))
        
        var string = ""
        for i in 0..<length {
            string += String(format: "%02x", digest[Int(i)])
        }
        return string
    }
}