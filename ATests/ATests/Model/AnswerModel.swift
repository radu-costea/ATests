//
//  File.swift
//  ATests
//
//  Created by Radu Costea on 25/04/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation

protocol AnswerModel {
    typealias ContentType: ContentModel
    var content: ContentType { get set }
}