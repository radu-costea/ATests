//
//  ContentModel.swift
//  ATests
//
//  Created by Radu Costea on 22/04/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation
import UIKit

/**
 *  @brief <#Description#>
 */
protocol ContentModel { }

/**
 *  @brief <#Description#>
 */
protocol TextContent: ContentModel {
    var text: String { get set }
}

/**
 *  @brief <#Description#>
 */
protocol ImageContent: ContentModel {
    var base64Image: String { get set }
    var image: UIImage { get }
}