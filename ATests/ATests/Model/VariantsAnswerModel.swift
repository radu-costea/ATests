//
//  VariantsAnswerModel.swift
//  ATests
//
//  Created by Radu Costea on 21/04/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation

protocol VariantsAnswerModel: AnswerModel, Equatable {
    associatedtype variantType: VariantsAnswerVariantModel
    var variants: [variantType] { get set }
    var sortedVariants: [variantType] { get }
}

func == <T: VariantsAnswerModel>(lhs: T, rhs: T) -> Bool {
    return lhs.sortedVariants == rhs.sortedVariants
}

func evaluate<T: VariantsAnswerModel>(answer: T, against: T) -> Float {
    return answer == against ? 1.0 : 0.0
}