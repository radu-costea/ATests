//
//  QuestionModel.swift
//  ATests
//
//  Created by Radu Costea on 25/04/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation

protocol QuestionModel {
    typealias ContentType: ContentModel
    typealias AnswerType: Answer
    typealias EvaluatorType: AnswerEvaluatorModel
    
    var content: ContentType { get set }
    var answer: AnswerType { get set }
    var evaluator: EvaluatorType { get set }
}

protocol VariantsQuestion: QuestionModel {
    typealias AnswerType: VariantsAnswer
}

protocol FreeAnswerQuestion: QuestionModel {
    typealias AnswerType: PercentAnswer
}

