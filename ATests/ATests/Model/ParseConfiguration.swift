//
//  ParseConfiguration.swift
//  ATests
//
//  Created by Radu Costea on 18/06/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit
import Parse

class ParseConfiguration {
    static func registerClassNames() {
        ParseDomain.registerSubclass()
        ParseUser.registerSubclass()
        ParseAnswer.registerSubclass()
        ParseTextContent.registerSubclass()
        ParseImageContent.registerSubclass()
        ParseVariantsAnswerContent.registerSubclass()
        ParseQuestion.registerSubclass()
        ParseAnswerVariant.registerSubclass()
        ParseExamQuestion.registerSubclass()
        ParseExam.registerSubclass()
        ParseExamAnswer.registerSubclass()
        ParseExamResult.registerSubclass()
    }
}
