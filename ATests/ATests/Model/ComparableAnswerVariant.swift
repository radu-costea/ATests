//
//  AnswerVariant.swift
//  ATests
//
//  Created by Radu Costea on 26/04/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit

protocol ComparableAnswerVariant: Comparable {
    associatedtype ContentType: ComparableContent
    var correct: Bool { get set }
    var content: ContentType { get set }
}

func == <T: ComparableAnswerVariant>(lhs: T, rhs: T) -> Bool {
    guard lhs.content == rhs.content else {
        return false
    }
    return lhs.correct == rhs.correct
}

func < <T: ComparableAnswerVariant>(lhs: T, rhs: T) -> Bool {
    return lhs.content < rhs.content
}

func <= <T: ComparableAnswerVariant>(lhs: T, rhs: T) -> Bool {
    return lhs.content <= rhs.content
}

func > <T: ComparableAnswerVariant>(lhs: T, rhs: T) -> Bool {
    return lhs.content > rhs.content
}

func >= <T: ComparableAnswerVariant>(lhs: T, rhs: T) -> Bool {
    return lhs.content >= rhs.content
}
