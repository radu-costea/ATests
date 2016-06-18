//
//  AnimatingViewController.swift
//  ATests
//
//  Created by Radu Costea on 16/06/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit
import Parse
class AnimatingViewController: UIViewController {
    @IBOutlet var statusLabel: UILabel!
    static var sharedInstance: AnimatingViewController? = nil
    var status: String? {
        didSet {
            refreshStatus()
        }
    }
    
    static func createControllerIfNeeded() -> AnimatingViewController {
        guard let instance = sharedInstance else {
            let controller = UIStoryboard(name: "Utils", bundle: nil).instantiateViewControllerWithIdentifier("Animating") as! AnimatingViewController
            sharedInstance = controller
            return controller
        }
        return instance
    }
    
    static func showInController(target: UIViewController, status: String?, completion: (() -> Void)? = nil) {
        let animationController = createControllerIfNeeded()
        animationController.modalTransitionStyle = .CrossDissolve
        animationController.status = status
        
        if animationController.presentingViewController !== target {
            target.presentViewController(animationController, animated: true, completion: completion)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        refreshStatus()
    }
    
    static func setStatus(status: String) {
        sharedInstance?.status = status
    }
    
    static func hide(completion: (() -> Void)? = nil) {
        if let presentingController = sharedInstance?.presentingViewController {
            presentingController.dismissViewControllerAnimated(false, completion: {
                sharedInstance = nil
                completion?()
            })
        } else {
            completion?()
        }
        
    }
    
    /// MARK: -
    /// MARK: Utils
    
    private func refreshStatus() {
        statusLabel?.text = status
    }
}
