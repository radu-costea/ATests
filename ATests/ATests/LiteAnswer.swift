//
//  LiteAnswer.swift
//  ATests
//
//  Created by Radu Costea on 09/06/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation
import CoreData

@objc(LiteAnswer)
class LiteAnswer: NSManagedObject {

// Insert code here to add functionality to your managed object subclass

    func constructCopyParams() -> [String: AnyObject]? {
        var params = [String : AnyObject]()
        if let cloneContent = content?.makeCopy() {
            params["content"] = cloneContent
        }
        return params
    }
    
    func makeCopy<T: LiteAnswer>() -> T? {
        return LiteAnswer(with: constructCopyParams()) as? T
    }
}

extension LiteAnswer: AnswerModel {
    override var hasDeepChanges: Bool {
        return super.hasDeepChanges || (content?.hasDeepChanges ?? false)
    }
    
    var content: LiteContent? {
        get { return contentObject }
        set { contentObject = newValue }
    }
    
    func isValid() -> Bool {
        return content?.isValid() ?? false
    }
}
