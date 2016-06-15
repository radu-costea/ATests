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
    func constructCopyParams() -> [String: AnyObject]? {
        var params = [String : AnyObject]()
        if let questionContent = content {
            params["content"] = questionContent.makeCopy()!
        }
        if let cloneAnswer = answer?.makeCopy() {
            params["answer"] = cloneAnswer
        }
        return params
    }
    
    func makeCopy<T: LiteQuestion>() -> T? {
        return LiteQuestion(with: constructCopyParams()) as? T
    }
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
    
    func isValid() -> Bool {
        return  (content?.isValid() ?? false) &&
                (answer?.isValid() ?? false)
    }
    
    override var hasDeepChanges: Bool {
        return  super.hasDeepChanges ||
                (content?.hasDeepChanges ?? false) ||
                (answer?.hasDeepChanges ?? false)
    }
}