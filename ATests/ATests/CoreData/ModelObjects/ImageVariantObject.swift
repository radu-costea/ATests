//
//  ImageVariantObject.swift
//  ATests
//
//  Created by Radu Costea on 05/05/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation
import CoreData


class ImageVariantObject: AnswerVariantObject {

// Insert code here to add functionality to your managed object subclass
    var content: ImageContentObject? {
        get { return contentObj }
        set { contentObj = newValue }
    }
}
