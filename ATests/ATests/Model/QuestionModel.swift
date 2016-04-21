//
//  QuestionModel.swift
//  ATests
//
//  Created by Radu Costea on 21/04/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation


protocol QuestionModel {
    var answer: Answer { get set }
    var evaluator: AnswerEvaluatorModel { get set }
}