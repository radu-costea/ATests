//
//  AnswerEvaluatorModel.swift
//  ATests
//
//  Created by Radu Costea on 21/04/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation

protocol AnswerEvaluatorModel {
    func evaluateAnswer<T: AnswerModel>(answer: T, against: T, completion: (Float) -> Void)
}

protocol EquatableAnswer: AnswerModel, Equatable { }

func == <T: EquatableAnswer>(lhs: T, rhs: T) -> Bool {
    return false
}

class EqualAnswersEvaluator: AnswerEvaluatorModel {
    func evaluateAnswer<T: AnswerModel>(answer: T, against: T, completion: (Float) -> Void) {
        
        let v = evaluateEquatableAnswer(answer, against: against)
    }
    
    func evaluateEquatableAnswer<E: EquatableAnswer>(answer: E, against: E) -> Bool {
        return against == answer
    }
}