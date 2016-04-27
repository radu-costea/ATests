//
//  TextContent.swift
//  ATests
//
//  Created by Radu Costea on 25/04/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation

/**
 *  @brief <#Description#>
 */
protocol TextContent: ContentModel, Comparable {
    var text: String { get set }// = ""
}

class TextContentObject: TextContent, Comparable {
    var text: String = ""
}

func < (lhs: TextContentObject, rhs: TextContentObject) -> Bool {
    return lhs.text < rhs.text
}

func <= (lhs: TextContentObject, rhs: TextContentObject) -> Bool {
    return lhs.text <= rhs.text
}

func > (lhs: TextContentObject, rhs: TextContentObject) -> Bool {
    return lhs.text > rhs.text
}

func >= (lhs: TextContentObject, rhs: TextContentObject) -> Bool {
    return lhs.text >= rhs.text
}

func == (lhs: TextContentObject, rhs: TextContentObject) -> Bool {
    return lhs.text > rhs.text
}

//func == <T: TextContent>(lhs: T, rhs: T) -> Bool {
//    return lhs.text == rhs.text
//}
//
//func <= <T: TextContent>(lhs: T, rhs: T) -> Bool {
//    return lhs.text <= rhs.text
//}
//
//func >= <T: TextContent>(lhs: T, rhs: T) -> Bool {
//    return lhs.text >= rhs.text
//}
//
//func < <T: TextContent>(lhs: T, rhs: T) -> Bool {
//    return lhs.text < rhs.text
//}
//
//func > <T: TextContent>(lhs: T, rhs: T) -> Bool {
//    return lhs.text > rhs.text
//}