//
//  UIAlertController-Additions.swift
//  ATests
//
//  Created by Radu Costea on 15/06/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit
import Parse
extension UIAlertController {
    static func showIn(controller: UIViewController, title: String? = nil, message: String? = nil, style: UIAlertControllerStyle = .ActionSheet, actions:[(title: String, action: ((UIAlertAction) -> Void)?)], cancelAction: (title: String, action: ((UIAlertAction) -> Void)?), completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        let alertActions = actions.map{ UIAlertAction(title: $0.title, style: .Default, handler: $0.action) }
        alertActions.forEach{ alert.addAction($0) }
        alert.addAction(UIAlertAction(title: cancelAction.title, style: .Cancel, handler: cancelAction.action))
        controller.presentViewController(alert, animated: true, completion: completion)
    }
}
