//
//  ContentModel.swift
//  ATests
//
//  Created by Radu Costea on 22/04/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation
import UIKit
import Parse

@objc protocol TimestampObject: class {
    var creationDate: NSTimeInterval { get set }
}

/**
 *  @brief <#Description#>
 */
protocol ContentModel: UniqueObject {
    func isValid() -> Bool
    
    func saveInBackgroundWithBlock(block: ((Bool, NSError?) -> Void)?)
    func fetchIfNeededInBackgroundWithBlock(block: PFObjectResultBlock?) throws
}

extension ContentModel {
//    func saveInBackgroundWithBlock(block: (sucess: Bool, error: NSError?) -> Void) {
//        block(sucess: true, error: nil)
//    }
}

protocol ImageContent: ContentModel {
    func getImageInBackgroundWithBlock(block: (image: UIImage?, error: NSError?) -> Void)
    func updateWithImage(image: UIImage, inBackgroundWithBlock block: (sucess: Bool, error: NSError?) -> Void)
}

protocol TextContent: ContentModel {
    var text: String?  { get set }
}

protocol NewVariantsAnswerContent: ContentModel {
    var variants: [AnswerVariant]? { get set }
    var sortedVariants: [AnswerVariant]? { get set }
    
    func loadVariantsInBackgroundWithBlock(block: (([PFObject]?, NSError?) -> Void)?)
}