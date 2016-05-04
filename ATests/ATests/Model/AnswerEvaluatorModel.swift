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