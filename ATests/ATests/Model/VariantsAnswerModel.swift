//
//  VariantsAnswerModel.swift
//  ATests
//
//  Created by Radu Costea on 21/04/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation

protocol VariantsAnswerModel: EquatableAnswer {
    associatedtype variantType: VariantsAnswerVariantModel
    var variants: [variantType] { get set }
    var sortedVariants: [variantType] { get }
}

func == <T: VariantsAnswerModel>(lhs: T, rhs: T) -> Bool {
    return lhs.sortedVariants == rhs.sortedVariants
}