//
//  AnswerVariantModel.swift
//  ATests
//
//  Created by Radu Costea on 21/04/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation

protocol VariantsAnswerVariantModel: Equatable {
    associatedtype ContentType: EquatableContent
    var content: ContentType { get set }
    var correct: Bool { get set }
}

protocol EquatableContent: ContentModel, Comparable { }

func == <T: EquatableContent>(lhs: T, rhs: T) -> Bool {
    return true
}

func == <T: VariantsAnswerVariantModel>(lhs: T, rhs: T) -> Bool {
    return lhs.correct == rhs.correct && lhs.content == rhs.content
}