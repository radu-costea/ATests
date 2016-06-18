//
//  ContentType.swift
//  ATests
//
//  Created by Radu Costea on 18/06/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit
import Parse

enum ContentType {
    case Text
    case Image
    
    func name() -> String {
        switch self {
        case .Text:
            return "Text"
        case .Image:
            return "Image"
        }
    }
    
    func createNewParseContent() -> PFObject {
        switch self {
        case .Text:
            return ParseTextContent()
        case .Image:
            return ParseImageContent()
        }
    }
}