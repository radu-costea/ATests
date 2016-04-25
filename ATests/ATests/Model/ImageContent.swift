//
//  ImageContent.swift
//  ATests
//
//  Created by Radu Costea on 25/04/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation
import UIKit

class ImageContent: ComparableContent {
    var base64Image: String = "" {
        didSet {
            if let data = base64Image.toBase64Data() {
                image = UIImage(data: data)
            }
        }
    }
    var image: UIImage!
}

func ==(lhs: ImageContent, rhs: ImageContent) -> Bool {
    return lhs.base64Image == rhs.base64Image
}

func <=(lhs: ImageContent, rhs: ImageContent) -> Bool {
    return lhs.base64Image <= rhs.base64Image
}

func >=(lhs: ImageContent, rhs: ImageContent) -> Bool {
    return lhs.base64Image >= rhs.base64Image
}

func <(lhs: ImageContent, rhs: ImageContent) -> Bool {
    return lhs.base64Image < rhs.base64Image
}

func >(lhs: ImageContent, rhs: ImageContent) -> Bool {
    return lhs.base64Image > rhs.base64Image
}