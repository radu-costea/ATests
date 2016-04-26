//
//  ImageAndTextContent.swift
//  ATests
//
//  Created by Radu Costea on 25/04/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation

protocol ImageAndTextContent: ImageContent, TextContent { }

func == <T: ImageAndTextContent>(lhs: T, rhs: T) -> Bool {
    return lhs.text == rhs.text && lhs.base64Image == rhs.base64Image
}

func <= <T: ImageAndTextContent>(lhs: T, rhs: T) -> Bool {
    return lhs.text <= rhs.text && lhs.base64Image == rhs.base64Image
}

func >= <T: ImageAndTextContent>(lhs: T, rhs: T) -> Bool {
    return lhs.base64Image >= rhs.base64Image
}

func < <T: ImageAndTextContent>(lhs: T, rhs: T) -> Bool {
    return lhs.base64Image < rhs.base64Image
}

func > <T: ImageAndTextContent>(lhs: T, rhs: T) -> Bool {
    return lhs.base64Image > rhs.base64Image
}