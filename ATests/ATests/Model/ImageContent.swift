//
//  ImageContent.swift
//  ATests
//
//  Created by Radu Costea on 25/04/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation
import UIKit

protocol ImageContent: ContentModel, Equatable {
    var base64Image: String { get set }
    var image: UIImage! { get set }
}

//func == <T: ImageContent>(lhs: T, rhs: T) -> Bool {
//    return lhs.base64Image == rhs.base64Image
//}
//
//func <= <T: ImageContent>(lhs: T, rhs: T) -> Bool {
//    return lhs.base64Image <= rhs.base64Image
//}
//
//func >= <T: ImageContent>(lhs: T, rhs: T) -> Bool {
//    return lhs.base64Image >= rhs.base64Image
//}
//
//func < <T: ImageContent>(lhs: T, rhs: T) -> Bool {
//    return lhs.base64Image < rhs.base64Image
//}
//
//func > <T: ImageContent>(lhs: T, rhs: T) -> Bool {
//    return lhs.base64Image > rhs.base64Image
//}