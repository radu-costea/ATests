//
//  LiteEvaluator.swift
//  ATests
//
//  Created by Radu Costea on 09/06/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation
import CoreData

@objc(LiteEvaluator)
class LiteEvaluator: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    
}

extension LiteEvaluator: AnswerEvaluatorModel {
    var reference: LiteAnswer? {
        get { return referenceObject }
        set { referenceObject = newValue }
    }
    func match(with answer: LiteAnswer, competion: (Float) -> Void) {
        competion(1.0)
    }
}