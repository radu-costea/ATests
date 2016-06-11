//
//  ControllerTableViewCell.swift
//  ATests
//
//  Created by Radu Costea on 09/06/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit

class ControllerTableViewCell: UITableViewCell {
    var controller: ContainedViewController?
    
    func didMoveToControllerViewHierarchy(parentController: UIViewController) {
        if let containedController = controller {            
            parentController.addChildViewController(containedController)
            containedController.view.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(containedController.view)
            
            let constraints = [
                containedController.view.leadingAnchor.constraintEqualToAnchor(contentView.leadingAnchor),
                containedController.view.trailingAnchor.constraintEqualToAnchor(contentView.trailingAnchor),
                containedController.view.bottomAnchor.constraintEqualToAnchor(contentView.bottomAnchor),
                containedController.view.topAnchor.constraintEqualToAnchor(contentView.topAnchor),
            ]
            
            for constraint in constraints {
                constraint.priority = 950
                constraint.active = true
            }

            containedController.didMoveToParentViewController(parentController)
            containedController.presenter = parentController
        }
    }
    
    override func prepareForReuse() {
        if let containedController = controller {
            containedController.removeFromParentViewController()
            containedController.view.removeFromSuperview()
            containedController.didMoveToParentViewController(nil)
            controller = nil
        }
    }
}
