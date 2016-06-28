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

extension EditContentViewController {
    override static var storyboardName: String { return "EditQuestionStoryboard" }
    override static var storyboardId: String { return "createOrEditContent" }
    override class func controller() -> EditContentViewController? {
        return storyboardController(storyboardName, identifier: storyboardId) as? EditContentViewController
    }
}

enum ContentState {
    case NotLoaded
    case Loading
    case Loaded
}

class EditContentViewController: ContainedViewController {
    @IBOutlet var choseContentTypeView: UIView!
    @IBOutlet var contentView: UIView!
    
    weak var delegate: EditContentViewControllerDelegate? = nil
    
    private var editController: EditContentController?
    private var contentState: ContentState = .NotLoaded
    
    var allowedTypes: [ContentType] = [.Text, .Image]
    var editingEnabled: Bool = true
    var content: PFObject?
    
    /// MARK: -
    /// MARK: Class

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        refresh()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let c = content {
            switch contentState {
            case .NotLoaded:
                contentState = .Loading
                c.fetchIfNeededInBackgroundWithBlock{ (fetched, error) in
                    guard let fetchedObj = fetched else {
                        self.contentState = .NotLoaded
                        return
                    }
                    self.contentState = .Loaded
                    self.createContentEditor(fetchedObj)
                    self.refresh()
                }
            case .Loading:
                self.refresh()
                break
            case .Loaded:
                self.refresh()
                break
            }
        }
    }
    
    func createContentEditor(object: PFObject) -> Void {
        editController = EditContentFabric.editController(object)
        editController?.view.translatesAutoresizingMaskIntoConstraints = false
        editController?.editingEnabled = self.editingEnabled
        embedEditController()
    }
    
    func refresh() {
        let weHaveContent = (content != nil)
        self.choseContentTypeView.hidden = weHaveContent
        self.contentView.hidden = !weHaveContent
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
                self.createContentEditor(self.content!)
                self.editController?.startEditing()
            })
        }
        actions.append(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        actions.forEach{ alert.addAction($0) }
        presentViewController(alert, animated: true, completion: nil)
    }
}
