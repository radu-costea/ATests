//
//  PercentAnswer.swift
//  ATests
//
//  Created by Radu Costea on 27/04/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation

protocol PercentAnswer: AnswerModel {
    associatedtype ContentType: ContentModel, PercentEquatable
}