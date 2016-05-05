//
//  MixedVariantObject.swift
//  ATests
//
//  Created by Radu Costea on 05/05/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation
import CoreData


class MixedVariantObject: AnswerVariantObject {

// Insert code here to add functionality to your managed object subclass
    var content: MixedContentObject? {
        get { return contentObj }
        set { contentObj = newValue }
    }
}
