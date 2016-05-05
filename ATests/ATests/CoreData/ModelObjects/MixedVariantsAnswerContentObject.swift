//
//  MixedVariantsAnswerContentObject.swift
//  ATests
//
//  Created by Radu Costea on 05/05/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation
import CoreData


class MixedVariantsAnswerContentObject: VariantsAnswerContentObject, VariantsAnswerContent {

// Insert code here to add functionality to your managed object subclass
    var variants: [MixedVariantObject]? {
        get { return variantsObjects?.allObjects as? [MixedVariantObject] }
        set {
            guard let newVariants = newValue else {
                variantsObjects = nil
                return
            }
            variantsObjects = NSSet(array: newVariants)
        }
    }
}
