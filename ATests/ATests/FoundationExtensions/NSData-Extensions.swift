//
//  NSDAta-Extensions.swift
//  ATests
//
//  Created by Radu Costea on 13/04/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation

extension NSData {
    func digest(with encryption: Encryption) -> NSData {
        return encryption.digest(self)
    }
    
    func sign(with encryption: Encryption, key: NSData) -> NSData {
        return encryption.sign(self, key: key)
    }
    
    func toBase64String() -> String {
        return base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
    }
}