//
//  ImageContentObject.swift
//  ATests
//
//  Created by Radu Costea on 05/05/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation
import CoreData


class ImageContentObject: ContentObject, ImageContent {

// Insert code here to add functionality to your managed object subclass
    var base64Image: String? {
        get { return image }
        set { image = newValue }
    }
}
