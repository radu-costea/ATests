//
//  VariantsQuestionTextText.swift
//  ATests
//
//  Created by Radu Costea on 12/05/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation
import CoreData


class VariantsQuestionTextText: QuestionObject {

// Insert code here to add functionality to your managed object subclass

    var content: TextContentObject? {
        get { return contentObj }
        set { contentObj = newValue }
    }
    
    var answer: TextVariantsAnswerObject? {
        get { return answerObj }
        set { answerObj = newValue }
    }
}
