//
//  SimulationQuestionBuider.swift
//  ATests
//
//  Created by Radu Costea on 15/06/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation

class SimulationQuestionBuilder {
    var weight: Int = 1
    var question: LiteQuestion
    var include: Bool = false
    
    init(question: LiteQuestion, weight: Int = 1, include: Bool = false) {
        self.weight = weight
        self.question = question
        self.include = include
    }
    
    func buildSimulationQuestion() -> LiteSimulationQuestion? {
        guard include else {
            return nil
        }
        var params: [String: AnyObject] = ["weight" : NSNumber(long: weight)]
        if let questionParams = question.constructCopyParams() {
            params = params.join(questionParams)
        }
        return LiteSimulationQuestion(with: params)
    }
}