//
//  AnswerEvaluatorModel.swift
//  ATests
//
//  Created by Radu Costea on 21/04/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation

protocol AnswerEvaluatorModel {
    associatedtype T: AnswerModel
    var answer: T { get set }
    init(answer: T)
    func evauateAnswer(candidateAnswer: T) -> Float
}

func evaluate<T: AnswerModel>(answer: T, against: T) -> Float { return 0.0 }