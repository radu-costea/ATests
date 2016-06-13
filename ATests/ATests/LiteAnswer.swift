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

}

extension LiteAnswer: AnswerModel {
    var content: LiteContent? {
        get { return contentObject }
        set { contentObject = newValue }
    }
    
    func isValid() -> Bool {
        return content?.isValid() ?? false
    }
}
