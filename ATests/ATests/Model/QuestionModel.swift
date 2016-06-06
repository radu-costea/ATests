//
//  QuestionModel.swift
//  ATests
//
//  Created by Radu Costea on 25/04/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation

protocol QuestionModel {
    typealias ContentType: ContentModel
    typealias AnswerType: AnswerModel
    typealias EvaluatorType: AnswerEvaluatorModel
    
    var content: ContentType? { get set }
    var answer: AnswerType? { get set }
    var evaluator: EvaluatorType? { get set }
}

extension QuestionModel {
    var content: ContentType? {
        get { return nil }
        set { }
    }
    
    var answer: AnswerType? {
        get { return nil}
        set { }
    }
    
    var evaluator: EvaluatorType? {
        get { return nil}
        set { }
    }
}


protocol VariantsQuestion: QuestionModel {
    typealias AnswerType: VariantsAnswer
}

protocol FreeAnswerQuestion: QuestionModel {
    typealias AnswerType: PercentAnswer
}

protocol TestQuestion {
    typealias QuestionType: QuestionModel
    var question: QuestionType? { get set }
    var weight: Int { get set }
}

extension TestQuestion {
    var question: QuestionType? {
        get { return nil }
        set { }
    }
    
    var weight: Int {
        get { return 10 }
        set { }
    }
}

protocol TestModel {
    typealias QuestionType: TestQuestion
    var questions: [QuestionType] { get set }
}