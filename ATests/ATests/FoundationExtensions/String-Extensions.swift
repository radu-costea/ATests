//
//  String-Extensions.swift
//  ATests
//
//  Created by Radu Costea on 08/04/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation

extension String {
    var length: Int {
        return (startIndex.distanceTo(endIndex))
    }
}