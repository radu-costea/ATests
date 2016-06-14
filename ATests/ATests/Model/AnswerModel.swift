//
//  File.swift
//  ATests
//
//  Created by Radu Costea on 25/04/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation

protocol AnswerModel {
    associatedtype ContentType: ContentModel
    var content: ContentType? { get set }
    func isValid() -> Bool
}

extension AnswerModel {
    var content: ContentType? {
        get { return nil }
        set { }
    }
}

