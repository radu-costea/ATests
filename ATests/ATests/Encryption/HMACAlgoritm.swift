//
//  HMACAlgoritm.swift
//  ATests
//
//  Created by Radu Costea on 13/04/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation
import CommonCrypto

struct HMACAlgoritm {
    let length: Int32
    let algorithm: CCHmacAlgorithm
    init(length: Int32, algorithm: CCHmacAlgorithm) {
        self.length = length
        self.algorithm = algorithm
    }
    
    func sign(data: NSData, key: NSData) -> NSData {
        let signature = UnsafeMutablePointer<CUnsignedChar>.alloc(Int(length))
        CCHmac(algorithm, key.bytes, key.length, data.bytes, data.length, signature)
        return NSData(bytes: signature, length: Int(length))
    }
    
    func sign(message message: String, key: String) -> String? {
        let utf8 = NSUTF8StringEncoding
        guard let messageData = message.dataUsingEncoding(utf8), keyData = key.dataUsingEncoding(utf8) else {
            return nil
        }
        
        let data = sign(messageData, key: keyData)
        
        var hash = ""
        data.enumerateByteRangesUsingBlock { bytes, range, _ in
            let pointer = UnsafeMutablePointer<CUnsignedChar>(bytes)
            for i in range.location..<(range.location + range.length) {
                hash += String(format: "%02x", pointer[i])
            }
        }
        return hash
        
    }
}