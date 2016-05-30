//
//  EditRawContentViewController.swift
//  ATests
//
//  Created by Radu Costea on 30/05/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit


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

class EditRawContentController: ContainedViewController {
    override class func controller() -> EditRawContentController? {
        return super.controller() as? EditRawContentController
    }
    
    class func editController<T: RawContent>(content: T?) -> EditRawContentController! {
        let controllerVC: EditRawContentController = self.controller()!
        controllerVC.loadWith(content)
        return controllerVC
    }
    
    func loadWith<T: RawContent>(content: T?) {
        // STUB
    }
}

class EditContentFabric {
    class func editController(content: RawContent) -> EditRawContentController {
        if let text = content as? String {
            return textController(text)!
        }
        
        if let image = content as? UIImage {
            return imageController(image)!
        }
        
        if let mixed = content as? MixedRawContent {
            return mixedController(mixed)!
        }
        
        fatalError("WE cant find a controller")
    }
}