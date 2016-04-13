//
//  ValidationFieldViewModel.swift
//  ATests
//
//  Created by Radu Costea on 11/04/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation

protocol FieldValidationViewModel {
    var text: String? { get set }
    var textTouched: Bool { get set }
    var isValid: Bool { get }
}

class ValidationFieldViewModel: FieldValidationViewModel {
    var text: String?
    var pattern: String?
    var textTouched: Bool = false
    var isValid: Bool {
        guard let regex = pattern else {
            return true
        }
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluateWithObject(self.text)
    }
    
    init(pattern: String?) {
        self.pattern = pattern
    }
}

class WordLengthValidationFieldViewModel: FieldValidationViewModel {
    var text: String?
    var textTouched: Bool = false
    var length: UInt
    var isValid: Bool { return UInt(text?.length ?? 0) >= length }
    init(length: UInt) {
        self.length = length
    }
}

class BlockValidationFieldViewModel: FieldValidationViewModel {
    var text: String?
    var textTouched: Bool = false
    var validationBlock: (FieldValidationViewModel) -> Bool
    var isValid: Bool { return validationBlock(self) }
    init(validationBlock: (FieldValidationViewModel) -> Bool) {
        self.validationBlock = validationBlock
    }
}