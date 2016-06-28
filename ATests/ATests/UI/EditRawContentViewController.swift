//
//  EditRawContentViewController.swift
//  ATests
//
//  Created by Radu Costea on 30/05/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit
import Parse

protocol Contained: class {
    associatedtype SelfType = Self
    static var storyboardName: String { get }
    static var storyboardId: String { get }
    static func controller() -> SelfType?
}

func storyboardController(storyboard: String, identifier: String) -> UIViewController {
     return UIStoryboard(name: storyboard, bundle: nil).instantiateViewControllerWithIdentifier(identifier)
}


class ContainedViewController: UIViewController, Contained {
    class var storyboardName: String { return "" }
    class var storyboardId: String { return "" }
    class func controller() -> ContainedViewController? {
        return storyboardController(storyboardName, identifier: storyboardId) as? ContainedViewController
    }
}

class EditContentController: ContainedViewController {
    typealias SelfType = EditContentController
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