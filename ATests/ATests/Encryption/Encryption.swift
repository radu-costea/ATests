//
//  Encryption.swift
//  ATests
//
//  Created by Radu Costea on 13/04/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation
import CommonCrypto

enum Encryption {
    case MD5
    case SHA1
    case SHA224
    case SHA256
    case SHA384
    case SHA512
}

extension Encryption {
    private func toDigest() -> Digest {
        switch self {
        case MD5:
            return Digest(length: CC_MD5_DIGEST_LENGTH, function: CC_MD5)
        case SHA1:
            return Digest(length: CC_SHA1_DIGEST_LENGTH, function: CC_SHA1)
        case SHA224:
            return Digest(length: CC_SHA224_DIGEST_LENGTH, function: CC_SHA224)
        case SHA256:
            return Digest(length: CC_SHA256_DIGEST_LENGTH, function: CC_SHA256)
        case SHA384:
            return Digest(length: CC_SHA384_DIGEST_LENGTH, function: CC_SHA384)
        case SHA512:
            return Digest(length: CC_SHA512_DIGEST_LENGTH, function: CC_SHA512)
        }
    }
    
    func digest(data: NSData) -> NSData {
        return toDigest().digest(data)
    }
    
    func digest(string: String) -> String? {
        return toDigest().digest(string)
    }
}

extension Encryption {
    private func toHMAC() -> HMACAlgoritm {
        switch self {
        case MD5:
            return HMACAlgoritm(length: CC_MD5_DIGEST_LENGTH, algorithm: CCHmacAlgorithm(kCCHmacAlgMD5))
        case SHA1:
            return HMACAlgoritm(length: CC_SHA1_DIGEST_LENGTH, algorithm: CCHmacAlgorithm(kCCHmacAlgSHA1))
        case SHA224:
            return HMACAlgoritm(length: CC_SHA224_DIGEST_LENGTH, algorithm: CCHmacAlgorithm(kCCHmacAlgSHA224))
        case SHA256:
            return HMACAlgoritm(length: CC_SHA256_DIGEST_LENGTH, algorithm: CCHmacAlgorithm(kCCHmacAlgSHA256))
        case SHA384:
            return HMACAlgoritm(length: CC_SHA384_DIGEST_LENGTH, algorithm: CCHmacAlgorithm(kCCHmacAlgSHA384))
        case SHA512:
            return HMACAlgoritm(length: CC_SHA512_DIGEST_LENGTH, algorithm: CCHmacAlgorithm(kCCHmacAlgSHA512))
        }
    }
    
    func sign(data: NSData, key: NSData) -> NSData {
        return toHMAC().sign(data, key: key)
    }
    
    func sign(string: String, key: String) -> String? {
        return toHMAC().sign(message: string, key: key)
    }
}