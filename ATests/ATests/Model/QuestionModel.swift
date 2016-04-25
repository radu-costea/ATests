//
//  QuestionModel.swift
//  ATests
//
//  Created by Radu Costea on 25/04/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation

protocol QuestionModel {
    associatedtype ContentType: ContentModel
    associatedtype AnswerType: Answer
    associatedtype EvaluatorType: AnswerEvaluatorModel
    
    var content: ContentType { get set }
    var answer: AnswerType { get set }
    var evaluator: EvaluatorType { get set }
}

