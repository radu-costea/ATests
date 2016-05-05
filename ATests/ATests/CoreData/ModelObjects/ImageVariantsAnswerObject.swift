//
//  ImageVariantsAnswerObject.swift
//  ATests
//
//  Created by Radu Costea on 06/05/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation
import CoreData


class ImageVariantsAnswerObject: VariantsAnswerObject {
    typealias ContentType = ImageVariantsAnswerContentObject
// Insert code here to add functionality to your managed object subclass
    var content: ImageVariantsAnswerContentObject? {
        get { return contentObj }
        set { contentObj = newValue }
    }
}
