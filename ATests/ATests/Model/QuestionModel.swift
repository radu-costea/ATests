//
//  QuestionModel.swift
//  ATests
//
//  Created by Radu Costea on 21/04/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation


protocol QuestionModel {
    associatedtype EvaluatorType: AnswerEvaluatorModel
    associatedtype AnswerType: AnswerModel
    associatedtype ContentType: ContentModel
    var content: ContentType { get set }
    var answer: AnswerType { get set }
    var evaluator: EvaluatorType { get set }
}