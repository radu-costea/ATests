//
//  String-Extensions.swift
//  ATests
//
//  Created by Radu Costea on 08/04/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation
import CommonCrypto

extension String {
    var length: Int {
        return (startIndex.distanceTo(endIndex))
    }
    
    func digest(with encryption: Encryption) -> String? {
        return encryption.digest(self)
    }
    
    func sign(with encryption: Encryption, key: String) -> String? {
        return encryption.sign(self, key: key)
    }
}