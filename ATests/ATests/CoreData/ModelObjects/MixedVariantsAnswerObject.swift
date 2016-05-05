//
//  MixedVariantsAnswerObject.swift
//  ATests
//
//  Created by Radu Costea on 06/05/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation
import CoreData


class MixedVariantsAnswerObject: VariantsAnswerObject {
    typealias ContentType = MixedVariantsAnswerContentObject
    // Insert code here to add functionality to your managed object subclass
    var content: MixedVariantsAnswerContentObject? {
        get { return contentObj }
        set { contentObj = newValue }
    }
}
