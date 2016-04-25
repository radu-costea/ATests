//
//  TextContent.swift
//  ATests
//
//  Created by Radu Costea on 25/04/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation

class TextContent: ComparableContent {
    var text: String = ""
}

func ==(lhs: TextContent, rhs: TextContent) -> Bool {
    return lhs.text == rhs.text
}

func <=(lhs: TextContent, rhs: TextContent) -> Bool {
    return lhs.text <= rhs.text
}

func >=(lhs: TextContent, rhs: TextContent) -> Bool {
    return lhs.text >= rhs.text
}

func <(lhs: TextContent, rhs: TextContent) -> Bool {
    return lhs.text < rhs.text
}

func >(lhs: TextContent, rhs: TextContent) -> Bool {
    return lhs.text > rhs.text
}