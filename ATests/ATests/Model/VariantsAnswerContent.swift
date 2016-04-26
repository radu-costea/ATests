//
//  VariantsAnswerContent.swift
//  ATests
//
//  Created by Radu Costea on 26/04/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit

protocol VariantsAnswerContent: EquatableContent {
    associatedtype VariantType: ComparableAnswerVariant
    var variants: [VariantType] { get set }
}

func == <T: VariantsAnswerContent>(lhs: T, rhs: T) -> Bool {
    guard lhs.variants.count == rhs.variants.count else {
        return false
    }
    return lhs.variants.sort() == rhs.variants.sort()
}