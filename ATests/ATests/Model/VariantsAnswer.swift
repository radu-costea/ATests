//
//  VariantsAnswer.swift
//  ATests
//
//  Created by Radu Costea on 26/04/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit

protocol VariantsAnswer: EquatableAnswer {
    associatedtype ContentType: VariantsAnswerContent
}
