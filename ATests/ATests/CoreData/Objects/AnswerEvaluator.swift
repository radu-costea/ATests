//
//  AnswerEvaluator.swift
//  ATests
//
//  Created by Radu Costea on 21/04/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation
import CoreData


class AnswerEvaluator: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    func computeScoreForAnswer(answer: Answer, completion: (Float) -> Void) {
        completion(0)
    }
}
