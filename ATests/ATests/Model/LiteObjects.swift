//
//  LiteObjects.swift
//  ATests
//
//  Created by Radu Costea on 31/05/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation

class LiteQuestion: QuestionModel, CustomStringConvertible {
    var content: LiteContent?
    var answer: LiteAnswer?
    var evaluator: LiteEvaluator?
    
    init(content: LiteContent?, answer: LiteAnswer?, evaluator: LiteEvaluator?) {
        self.content = content
        self.answer = answer
        self.evaluator = evaluator
    }
    
    var description: String { return "\(self.dynamicType) content: \(content), answer: \(answer), evaluator: \(evaluator)" }
}

class LiteTestQuestion: TestQuestion {
    typealias QuestionType = LiteQuestion
    var question: LiteQuestion?
    var weight: Int = 10
}

/// Answers

class LiteAnswer: AnswerModel, CustomStringConvertible {
    var content: LiteContent?
    
    init(content: LiteContent) {
        self.content = content
    }
    
    var description: String { return "\(self.dynamicType) content: \(content)" }
}

// Concrete classes for content

class LiteContent: ContentModel, CustomStringConvertible {
    var identifier: String?
    
    init(identifier: String) {
        self.identifier = identifier
    }
    
    var description: String { return "\(self.dynamicType) identifier: \(identifier)" }
}

class LiteTextContent: LiteContent {
    var text: String?
    
    init(identifier: String, text: String?) {
        self.text = text
        super.init(identifier: identifier)
    }
    
    override var description: String { return "\(super.description) text: \(text)" }
}

class LiteImageContent: LiteContent {
    var base64Image: String?
    
    init(identifier: String, image: String?) {
        base64Image = image
        super.init(identifier: identifier)
    }
    
    override var description: String { return "\(super.description) image: \(base64Image?.hashValue)" }
}

enum LiteContentType {
    case Text
    case Image
    
    func name() -> String {
        switch self {
        case .Text:
            return "Text"
        case .Image:
            return "Image"
        }
    }
    
    func createNewContent(identifier: String)-> LiteContent {
        switch self {
        case .Text:
            return LiteTextContent(identifier: identifier, text: nil)
        case .Image:
            return LiteImageContent(identifier: identifier, image: nil)
        }
    }
}

// Answer specific content

class LiteVariantsAnswerContent: LiteContent, VariantsAnswerContent {
    typealias VariantType = LiteAnswerVariant
    var variants: [LiteAnswerVariant] = []
    
    init(identifier: String, variants: [LiteAnswerVariant]) {
        self.variants = variants
        super.init(identifier: identifier)
    }
}

// variants

class LiteAnswerVariant: AnswerVariant {
    typealias ContentType = LiteContent
    var index: UInt = 0
    var correct: Bool = false
    var content: LiteContent? = nil
    
    init(content: LiteContent?) {
        self.content = content
        correct = false
    }
}

/// Equatable:

extension LiteContent: Equatable { }

func ==<T: LiteContent>(lhs: T, rhs: T) -> Bool {
    guard let lhsIdentifier = lhs.identifier,
        let rhsIdentifier = rhs.identifier else {
            return (lhs.identifier == nil) && (rhs.identifier == nil)
    }
    return lhsIdentifier == rhsIdentifier
}

extension LiteAnswerVariant: Equatable { }

func ==<T: LiteAnswerVariant>(lhs: T, rhs: T) -> Bool {
    return lhs.content == rhs.content && rhs.correct == lhs.correct
}