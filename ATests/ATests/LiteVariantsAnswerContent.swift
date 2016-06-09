//
//  LiteVariantsAnswerContent.swift
//  ATests
//
//  Created by Radu Costea on 09/06/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation
import CoreData

@objc(LiteVariantsAnswerContent)
class LiteVariantsAnswerContent: LiteContent {

// Insert code here to add functionality to your managed object subclass

}

extension LiteVariantsAnswerContent: VariantsAnswerContent {
    var variants: [LiteAnswerVariant]? {
        get { return variantsObjects?.allObjects.flatMap{ $0 as? LiteAnswerVariant }}
        set { variantsObjects = NSSet(array: newValue ?? [])}
    }
    
    var sortedVariants: [LiteAnswerVariant] {
        let variantObjects = variantsObjects?.allObjects.flatMap{ ($0 as? LiteAnswerVariant)! } ?? []
        return variantObjects.sort{ $0.index < $1.index }
    }
}