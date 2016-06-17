//
//  LiteContentType.swift
//  ATests
//
//  Created by Radu Costea on 09/06/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//
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

    func createNewLiteContent(identifier: String)-> LiteContent {
        switch self {
        case .Text:
            return LiteTextContent(with: ["identifier" : identifier])!
        case .Image:
            return LiteImageContent(with: ["identifier" : identifier])!
        }
    }
    
    func createNewParseContent()-> ContentModel {
        switch self {
        case .Text:
            return ParseTextContent(className: ParseTextContent.parseClassName())
        case .Image:
            return ParseImageContent(className: ParseImageContent.parseClassName())
        }
    }
}