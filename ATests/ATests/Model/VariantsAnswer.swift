//
//  VariantsAnswer.swift
//  ATests
//
//  Created by Radu Costea on 27/04/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation

protocol AnswerVariant {
//    typealias ContentType: ContentModel
    var index: Int32 { get set }
    var correct: Bool { get set }
    var content: ContentModel? { get set }
}

extension AnswerVariant {
    var content: ContentModel? {
        get { return nil }
        set { }
    }
}

protocol VariantsAnswerContent: ContentModel {
    associatedtype VariantType: AnswerVariant, Equatable
    var variants: [VariantType]? { get set }
}

extension VariantsAnswerContent {
    var variants: [VariantType]? {
        get { return nil }
        set { }
    }
}

protocol VariantsAnswer: AnswerModel {
    associatedtype ContentType: VariantsAnswerContent, Equatable
}


/////// concrete  classes
