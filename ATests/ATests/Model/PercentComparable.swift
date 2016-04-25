//
//  PercentComparable.swift
//  ATests
//
//  Created by Radu Costea on 25/04/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation
protocol PercentComparable {
    func match(with: Self, completion: (Float) -> Void)
}