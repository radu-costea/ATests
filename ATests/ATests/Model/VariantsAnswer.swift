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
    var content: ContentType? { get set }
}

extension AnswerVariant {
    var content: ContentType? {
        get { return nil }
        set { }
    }
}

protocol VariantsAnswerContent: ContentModel {
    typealias VariantType: AnswerVariant, Equatable
    var variants: [VariantType]? { get set }
}

extension VariantsAnswerContent {
    var variants: [VariantType]? {
        get { return nil }
        set { }
    }
}

protocol VariantsAnswer: AnswerModel {
    typealias ContentType: VariantsAnswerContent, Equatable
}


/////// concrete  classes
