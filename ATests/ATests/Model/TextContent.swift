//
//  TextContent.swift
//  ATests
//
//  Created by Radu Costea on 25/04/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation

protocol TextContent: ComparableContent {
    var text: String { get set }// = ""
}

func == <T: TextContent>(lhs: T, rhs: T) -> Bool {
    return lhs.text == rhs.text
}

func <= <T: TextContent>(lhs: T, rhs: T) -> Bool {
    return lhs.text <= rhs.text
}

func >= <T: TextContent>(lhs: T, rhs: T) -> Bool {
    return lhs.text >= rhs.text
}

func < <T: TextContent>(lhs: T, rhs: T) -> Bool {
    return lhs.text < rhs.text
}

func > <T: TextContent>(lhs: T, rhs: T) -> Bool {
    return lhs.text > rhs.text
}