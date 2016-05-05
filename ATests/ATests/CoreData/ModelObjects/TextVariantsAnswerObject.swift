//
//  TextVariantsAnswerObject.swift
//  ATests
//
//  Created by Radu Costea on 06/05/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation
import CoreData


class TextVariantsAnswerObject: VariantsAnswerObject {
    typealias ContentType = TextVariantsAnswerContentObject
    // Insert code here to add functionality to your managed object subclass
    var content: TextVariantsAnswerContentObject? {
        get { return contentObj }
        set { contentObj = newValue }
    }
}
