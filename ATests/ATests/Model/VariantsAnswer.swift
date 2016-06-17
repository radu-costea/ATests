//
//  VariantsAnswer.swift
//  ATests
//
//  Created by Radu Costea on 27/04/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation

protocol UniqueObject: AnyObject {
    var objectId: String? { get }
}

extension UniqueObject {
    var objectId: String? {
        return nil
    }
}

protocol AnswerVariant: UniqueObject {
//    typealias ContentType: ContentModel
    var index: Int32 { get set }
    var correct: Bool { get set }
    var content: ContentModel? { get set }
    var answerContent: NewVariantsAnswerContent? { get set }
}

//extension AnswerVariant {
//    var content: ContentModel? {
//        get { return nil }
//        set { }
//    }
//}

protocol VariantsAnswerContent: ContentModel {
    associatedtype VariantType: AnswerVariant, Equatable
    var variants: [VariantType]? { get set }
}

extension NewVariantsAnswerContent {
    func isValid() -> Bool {
        guard let v = variants else {
            return false
        }
        
        let oneSelected = v.reduce(false){ $0 || $1.correct }
        let allValid = v.reduce(true){ $0 && ($1.content?.isValid() ?? false) }
        return allValid && oneSelected
    }
}

extension VariantsAnswerContent {
    var variants: [VariantType]? {
        get { return nil }
        set { }
    }
}

protocol VariantsAnswer: AnswerModel {
    associatedtype ContentType: VariantsAnswerContent, Equatable
}


/////// concrete  classes
