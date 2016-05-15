//
//  QuestionObject.swift
//  ATests
//
//  Created by Radu Costea on 12/05/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation
import CoreData

class VariantsAnswerEvaluator: AnswerEvaluatorModel {
    var reference: VariantsAnswerObject
    init(withReference referenceAnswer: VariantsAnswerObject) {
        reference = referenceAnswer
    }
    
    func match(with answer: VariantsAnswerObject, competion: (Float) -> Void) {
        competion(answer.isEqual(reference) ? 1.0 : 0.0)
    }
}

class QuestionObject: NSManagedObject, QuestionModel {
    typealias ContentType = ContentObject
    typealias AnswerType = VariantsAnswerObject
    typealias EvaluatorType = VariantsAnswerEvaluator
}
