//
//  VariantsAnswer.swift
//  ATests
//
//  Created by Radu Costea on 27/04/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation

protocol AnswerVariant {
    typealias ContentType: ContentModel
    var index: UInt { get set }
    var correct: Bool { get set }
    var content: ContentType { get set }
}

protocol VariantsAnswerContent: ContentModel {
    typealias VariantType: AnswerVariant, Equatable
    var variants: [VariantType] { get set }
}

protocol VariantsAnswer: AnswerModel {
    typealias ContentType: VariantsAnswerContent, Equatable
}