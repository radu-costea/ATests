//
//  AnswerEvaluator.swift
//  ATests
//
//  Created by Radu Costea on 25/04/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation


protocol AnswerEvaluatorModel {
    typealias AnswerType: AnswerModel
    var reference: AnswerType { get set }
    
    func match(with answer: AnswerType, competion: (Float) -> Void)
}

class LiteEvaluator: AnswerEvaluatorModel {
    typealias AnswerType = LiteAnswer
    var reference: LiteAnswer
    init(referenceAnswer answer: LiteAnswer) {
        reference = answer
    }
    
    func match(with answer: LiteAnswer, competion: (Float) -> Void) {
        competion(1.0)
    }
}