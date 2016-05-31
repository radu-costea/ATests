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

class EditContentController: ContainedViewController {
    override class func controller() -> EditContentController? {
        return super.controller() as? EditContentController
    }
    
    class func editController<T: LiteContent>(content: T?) -> EditContentController! {
        let controllerVC: EditContentController = self.controller()!
        controllerVC.loadWith(content)
        return controllerVC
    }
    
    func loadWith<T: LiteContent>(content: T?) {
        // STUB
    }
    
    func startEditing() {
        // STUB
    }
}

class EditContentFabric {
    class func editController(content: LiteContent) -> EditContentController {
        if let text = content as? LiteTextContent {
            return textController(text)!
        }
        
        if let image = content as? LiteImageContent {
            return imageController(image)!
        }
        
        if let variants = content as? LiteVariantsAnswerContent {
            return variantsController(variants)!
        }
        
//        if let mixed = content as? MixedRawContent {
//            return mixedController(mixed)!
//        }
        
        fatalError("WE cant find a controller")
    }
}