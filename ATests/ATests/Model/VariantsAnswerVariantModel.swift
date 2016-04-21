//
//  AnswerVariantModel.swift
//  ATests
//
//  Created by Radu Costea on 21/04/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation

protocol VariantsAnswerVariantModel: Equatable {
    var correct: Bool { get set }
}

func == <T: VariantsAnswerVariantModel>(lhs: T, rhs: T) -> Bool {
    return lhs.correct == rhs.correct
}