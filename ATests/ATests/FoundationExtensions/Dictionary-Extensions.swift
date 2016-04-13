//
//  Dictionary-Extensions.swift
//  ATests
//
//  Created by Radu Costea on 12/04/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation

extension Dictionary {
    func join(with: Dictionary<Key, Value>) -> Dictionary<Key, Value> {
        var copy = self
        with.forEach{ copy[$0.0] = $0.1 }
        return copy
    }
}