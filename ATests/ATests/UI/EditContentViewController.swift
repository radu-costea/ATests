//
//  EditContentViewController.swift
//  ATests
//
//  Created by Radu Costea on 05/06/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit
import Parse

protocol EditContentViewControllerDelegate: class {
    func editContentViewControllerDidUpdateContent(controller: EditContentViewController)
}

class EditContentViewController: ContainedViewController {
    @IBOutlet var choseContentTypeView: UIView!
    @IBOutlet var contentView: UIView!
    
    weak var delegate: EditContentViewControllerDelegate? = nil
    private var editController: EditContentController?
    var contentLoaded: Bool = false
    
    var content: PFObject? {
        didSet {
            refresh()
            delegate?.editContentViewControllerDidUpdateContent(self)
        }
    }
    var allowedTypes: [ContentType] = [.Text, .Image]
    
    /// MARK: -
    /// MARK: Class
    
    override static var storyboardName: String { return "EditQuestionStoryboard" }
    override static var storyboardId: String { return "createOrEditContent" }
    override class func controller() -> EditContentViewController? {
        return super.controller() as? EditContentViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        refresh()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        guard contentLoaded else {
            if let currentContent = content {
                do {
                    try currentContent.fetchIfNeededInBackgroundWithBlock{ _, _ in
                        self.contentLoaded = true
                        self.refresh()
                    }
                } catch { contentLoaded = true }
            } else {
                contentLoaded = true
            }
            return
        }
        refresh()
    }
    
    func refresh() {
        guard contentLoaded else {
            return
        }
        
        let weHaveContent: Bool
        defer {
            contentView?.hidden = !weHaveContent
            choseContentTypeView?.hidden = weHaveContent
        }
        guard let contentObj = content else {
            weHaveContent = false
            editController?.view.removeFromSuperview()
            editController = nil
            return
        }
        weHaveContent = true
        editController = EditContentFabric.editController(contentObj)
        editController?.view.translatesAutoresizingMaskIntoConstraints = false
        editController?.presenter = self
        embedEditController()
    }
    
    func embedEditController() {
        guard let controller = editController,
            let editView = controller.view,
            let container = contentView else {
            return
        }
        addChildViewController(controller)
        container.addSubview(editView)
        NSLayoutConstraint.activateConstraints([
            editView.leadingAnchor.constraintEqualToAnchor(container.leadingAnchor),
            editView.trailingAnchor.constraintEqualToAnchor(container.trailingAnchor),
            editView.topAnchor.constraintEqualToAnchor(container.topAnchor),
            editView.bottomAnchor.constraintEqualToAnchor(container.bottomAnchor)
        ])
        controller.didMoveToParentViewController(self)
    }

    /// MARK: -
    /// MARK: Actions
    
    @IBAction func didTapSelectContent(sender: AnyObject?) {
        let alert = UIAlertController(title: nil, message: "Please select content type", preferredStyle: .ActionSheet)
        var actions = allowedTypes.map { type in
            return UIAlertAction(title: type.name(), style: .Default, handler: { [unowned self] _ in
                self.content = type.createNewParseContent()
                self.editController?.startEditing()
            })
        }
        actions.append(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        actions.forEach{ alert.addAction($0) }
        presentViewController(alert, animated: true, completion: nil)
    }
}
