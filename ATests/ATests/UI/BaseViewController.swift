//
//  BaseViewController.swift
//  ATests
//
//  Created by Radu Costea on 15/04/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    var navigationCallbacks: [String: (UIViewController) -> ()] { return [:] }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier, let callback = navigationCallbacks[identifier] {
            callback(segue.destinationViewController)
            return
        }
    }
}