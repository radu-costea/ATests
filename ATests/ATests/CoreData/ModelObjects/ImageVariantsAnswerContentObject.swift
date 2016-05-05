//
//  ImageVariantsAnswerContentObject.swift
//  ATests
//
//  Created by Radu Costea on 05/05/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation
import CoreData


class ImageVariantsAnswerContentObject: VariantsAnswerContentObject {

// Insert code here to add functionality to your managed object subclass
    var variants: [ImageVariantObject]? {
        get { return variantsObjects?.allObjects as? [ImageVariantObject] }
        set {
            guard let newVariants = newValue else {
                variantsObjects = nil
                return
            }
            variantsObjects = NSSet(array: newVariants)
        }
    }
}
