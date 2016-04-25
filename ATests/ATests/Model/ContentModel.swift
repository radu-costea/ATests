//
//  ContentModel.swift
//  ATests
//
//  Created by Radu Costea on 22/04/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation

protocol ContentModel { }
protocol ComparableContent: ContentModel, Comparable { }
protocol PercentComparableContent: ContentModel, PercentComparable { }