//
//  QuestionModel.swift
//  ATests
//
//  Created by Radu Costea on 25/04/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation

protocol QuestionModel: class {
    associatedtype ContentType: ContentModel
    associatedtype AnswerType: AnswerModel
    associatedtype EvaluatorType: AnswerEvaluatorModel
    
    var content: ContentType? { get set }
    var answer: AnswerType? { get set }
    var evaluator: EvaluatorType? { get set }
    
    func isValid() -> Bool
}

protocol SimulationQuestionModel: QuestionModel {
    var simulationAnswer: AnswerType? { get set }
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
    associatedtype AnswerType: VariantsAnswer
}

protocol FreeAnswerQuestion: QuestionModel {
    associatedtype AnswerType: PercentAnswer
}

protocol TestQuestion {
    associatedtype QuestionType: QuestionModel
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
    associatedtype QuestionType: TestQuestion
    var questions: [QuestionType] { get set }
}