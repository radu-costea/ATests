//
//  ContentModel.swift
//  ATests
//
//  Created by Radu Costea on 22/04/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation

/**
 *  @brief <#Description#>
 */
protocol ContentModel { }

/**
 *  @brief <#Description#>
 */
protocol ComparableContent: ContentModel, Comparable { }

/**
 *  @brief <#Description#>
 */
protocol PercentComparableContent: ContentModel, PercentComparable { }