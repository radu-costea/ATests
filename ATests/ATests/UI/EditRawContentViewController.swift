//
//  EditRawContentViewController.swift
//  ATests
//
//  Created by Radu Costea on 30/05/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit
import Parse


class ContainedViewController: UIViewController, ContainedController {
    weak var presenter: UIViewController?
    
    class var storyboardName: String { return "" }
    class var storyboardId: String { return "" }
    
    class func controller() -> ContainedViewController? {
        return UIStoryboard(name: storyboardName, bundle: nil).instantiateViewControllerWithIdentifier(storyboardId) as? ContainedViewController
    }
    
    /// MARK: -
    /// MARK: Modal controllers
    
    override func presentViewController(viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?) {
        presenter?.presentViewController(viewControllerToPresent, animated: flag, completion: completion)
    }
    
    override func dismissViewControllerAnimated(flag: Bool, completion: (() -> Void)?) {
        presenter?.dismissViewControllerAnimated(flag, completion: completion)
    }
}

class EditContentController: ContainedViewController {
    var editingEnabled: Bool = true
    
    func getContent() -> PFObject? {
        return nil
    }
    
    override class func controller() -> EditContentController? {
        return super.controller() as? EditContentController
    }
    
    class func editController(content: PFObject?) -> EditContentController! {
        let controllerVC: EditContentController = self.controller()!
        controllerVC.loadWith(content)
        return controllerVC
    }
    
    func loadWith(content: PFObject?) { /* STUB */  }
    func startEditing() { /* STUB */  }
}

class EditContentFabric {
    class func editController(content: PFObject) -> EditContentController {
        if let text = content as? ParseTextContent {
            return textController(text)!
        }
        
        if let image = content as? ParseImageContent {
            return imageController(image)!
        }
        
        if let variants = content as? ParseAnswer {
            return variantsController(variants)!
        }
        
        fatalError("WE cant find a controller")
    }
}