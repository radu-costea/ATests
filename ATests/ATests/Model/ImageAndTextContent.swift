//
//  ImageAndTextContent.swift
//  ATests
//
//  Created by Radu Costea on 25/04/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation

protocol ImageAndTextContent: ImageContent, TextContent { }

extension ImageAndTextContent {
    func compareWith(content: Self) -> Int {
        guard text == content.text else {
            return text < content.text ? -1 : 1
        }
        guard base64Image == content.base64Image else {
            return base64Image < content.base64Image ? -1 : 1
        }
        return 0
    }
}

func <= <T: ImageAndTextContent>(lhs: T, rhs: T) -> Bool {
    let result = lhs.compareWith(rhs)
    return [-1, 0].contains(result)
}

func >= <T: ImageAndTextContent>(lhs: T, rhs: T) -> Bool {
    let result = lhs.compareWith(rhs)
    return [1, 0].contains(result)
}

func == <T: ImageAndTextContent>(lhs: T, rhs: T) -> Bool {
    return lhs.compareWith(rhs) == 0
}

func < <T: ImageAndTextContent>(lhs: T, rhs: T) -> Bool {
    return lhs.compareWith(rhs) == -1
}

func > <T: ImageAndTextContent>(lhs: T, rhs: T) -> Bool {
    return lhs.compareWith(rhs) == 1
}