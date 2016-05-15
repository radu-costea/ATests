//
//  VariantsQuestionConfiguration.swift
//  ATests
//
//  Created by Radu Costea on 15/05/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation

enum LayoutTypeEnum {
    case ImageAtTop
    case ImageAtBottom
    case ImageAtLeft
    case ImageAtRight
    
    func description() -> String {
        switch self {
        case ImageAtTop: return "ImageAtTop"
        case ImageAtBottom: return "ImageAtBottom"
        case ImageAtLeft: return "ImageAtLeft"
        case ImageAtRight: return "ImageAtRight"
        }
    }
}

enum ContentTypeEnum {
    case Text
    case Image
    case Mixed(layout: LayoutTypeEnum)
    
    func description() -> String {
        switch self {
        case Text:
            return "Text"
        case .Image:
            return "Image"
        case let .Mixed(layout):
            return "Mixed(\(layout.description()))"
        }
    }
}

protocol QuestionConfiguration {
    typealias T: QuestionModel
    func makeQuestion() -> T?
}

extension QuestionConfiguration {
    func makeQuestion() -> T? {
        return nil
    }
}

class VariantsQuestionConfiguration: QuestionConfiguration {
    typealias T = QuestionObject
    var questionContentType: ContentTypeEnum?
    var answerContentType: ContentTypeEnum?
    
    func description() -> String {
        return "variants question of type: \(questionContentType?.description() ?? "empty" ) answers: \(answerContentType?.description() ?? "empty")"
    }
    
    func makeQuestion() -> VariantsQuestionConfiguration.T? {
        guard let questionType = questionContentType, answerType = answerContentType else {
            return nil
        }
        
        switch (questionType, answerType) {
        case (.Text, .Text):
            let textContent = TextContentObject.new(nil) as? TextContentObject
            let answerObject = TextVariantsAnswerObject.new(nil) as? TextVariantsAnswerObject
            guard let answer = answerObject, content = textContent else {
                return nil
            }
            guard let question = VariantsQuestionTextText.new(["content" : content, "answer" : answer]) as? VariantsQuestionTextText else {
                return nil
            }
            return question as? QuestionObject
        case (.Text, .Image):
            return VariantsQuestionTextImage.new(nil) as? QuestionObject
        case let (.Text, .Mixed(layout)):
            return VariantsQuestionTextMixed.new(nil) as? QuestionObject
        case (.Image, .Text):
            return VariantsQuestionImageText.new(nil) as? QuestionObject
        case (.Image, .Image):
            return VariantsQuestionImageImage.new(nil) as? QuestionObject
        case let (.Image, .Mixed(layout)):
            return VariantsQuestionImageMixed.new(nil) as? QuestionObject
        case let (.Mixed(layout), .Text):
            return VariantsQuestionMixedText.new(nil) as? QuestionObject
        case let (.Mixed(layout), .Image):
            return VariantsQuestionMixedImage.new(nil) as? QuestionObject
        case let (.Mixed(questionLayout), .Mixed(answerLayout)):
            return VariantsQuestionMixedMixed.new(nil) as? QuestionObject
        }
    }
}