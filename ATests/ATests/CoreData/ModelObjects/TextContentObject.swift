//
//  TextContentObject.swift
//  ATests
//
//  Created by Radu Costea on 05/05/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation
import CoreData


class TextContentObject: ContentObject, TextContent {

    // Insert code here to add functionality to your managed object subclass
    var text: String? {
        get { return string }
        set { string = newValue }
    }
}
