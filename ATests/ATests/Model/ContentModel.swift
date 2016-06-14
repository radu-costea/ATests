//
//  ContentModel.swift
//  ATests
//
//  Created by Radu Costea on 22/04/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation
import UIKit


@objc protocol TimestampObject: class {
    var creationDate: NSTimeInterval { get set }
}

/**
 *  @brief <#Description#>
 */
protocol ContentModel {
    var identifier: String? { get }
    func isValid() -> Bool
}
