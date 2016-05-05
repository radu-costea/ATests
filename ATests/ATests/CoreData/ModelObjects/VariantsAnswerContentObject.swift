//
//  VariantsAnswerContentObject.swift
//  ATests
//
//  Created by Radu Costea on 05/05/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation
import CoreData


class VariantsAnswerContentObject: NSManagedObject {
    
// Insert code here to add functionality to your managed object subclass
    var identifier: String? { return objectID.URIRepresentation().relativePath }

}
