//
//  File.swift
//  ATests
//
//  Created by Radu Costea on 25/04/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation

protocol AnswerModel {
    associatedtype ContentType: ContentModel
    var content: ContentType { get set }
}

protocol EquatableAnswer: AnswerModel, Equatable {
    associatedtype ContentType: ComparableContent
}

func == <T: EquatableAnswer>(lhs: T, rhs: T) -> Bool {
    return lhs.content == rhs.content
}

protocol PercentComparableAnswer: AnswerModel, PercentComparable {
    associatedtype ContentType: PercentComparableContent
}

