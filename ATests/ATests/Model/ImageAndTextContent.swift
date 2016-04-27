//
//  ImageAndTextContent.swift
//  ATests
//
//  Created by Radu Costea on 25/04/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation

protocol ImageAndTextContent: ImageContent, TextContent { }

//func compare<T: ImageAndTextContent>(content: T, with otherContent: T) -> Int {
//    guard content.text == otherContent.text else {
//        return content.text < otherContent.text ? -1 : 1
//    }
//    guard content.base64Image == otherContent.base64Image else {
//        return content.base64Image < otherContent.base64Image ? -1 : 1
//    }
//    return 0
//}
//
//func <= <T: ImageAndTextContent>(lhs: T, rhs: T) -> Bool {
//    let result = compare(lhs, with: rhs)
//    return result == 0 || result == -1
//}
//
//func >= <T: ImageAndTextContent>(lhs: T, rhs: T) -> Bool {
//    let result = compare(lhs, with: rhs)
//    return result == 0 || result == 1
//}
//
//func == <T: ImageAndTextContent>(lhs: T, rhs: T) -> Bool {
//    return compare(lhs, with: rhs) == 0
//}
//
//func < <T: ImageAndTextContent>(lhs: T, rhs: T) -> Bool {
//    return compare(lhs, with: rhs) == -1
//}
//
//func > <T: ImageAndTextContent>(lhs: T, rhs: T) -> Bool {
//    return compare(lhs, with: rhs) == 1
//}