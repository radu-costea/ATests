//
//  LiteQuestion.swift
//  ATests
//
//  Created by Radu Costea on 09/06/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation
import CoreData

@objc(LiteQuestion)
class LiteQuestion: NSManagedObject {

// Insert code here to add functionality to your managed object subclass

}

extension LiteQuestion: QuestionModel {
    var content: LiteContent? {
        get { return contentObject }
        set { contentObject = newValue }
    }
    var answer: LiteAnswer? {
        get { return answerObject }
        set { answerObject = newValue }
    }
    var evaluator: LiteEvaluator? {
        get { return evaluatorObject }
        set { evaluatorObject = newValue }
    }
}