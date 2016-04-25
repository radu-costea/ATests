//
//  ImageAndTextContent.swift
//  ATests
//
//  Created by Radu Costea on 25/04/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation

class ImageAndTextContent: ImageContent {
    var text: String = ""
}

func ==(lhs: ImageAndTextContent, rhs: ImageAndTextContent) -> Bool {
    return lhs.text == rhs.text && lhs.base64Image == rhs.base64Image
}

func <=(lhs: ImageAndTextContent, rhs: ImageAndTextContent) -> Bool {
    return lhs.text <= rhs.text && lhs.base64Image == rhs.base64Image
    return lhs.base64Image <= rhs.base64Image
}

func >=(lhs: ImageAndTextContent, rhs: ImageAndTextContent) -> Bool {
    return lhs.base64Image >= rhs.base64Image
}

func <(lhs: ImageAndTextContent, rhs: ImageAndTextContent) -> Bool {
    return lhs.base64Image < rhs.base64Image
}

func >(lhs: ImageAndTextContent, rhs: ImageAndTextContent) -> Bool {
    return lhs.base64Image > rhs.base64Image
}