//
//  EditVariantController.swift
//  ATests
//
//  Created by Radu Costea on 01/06/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit
import Parse
protocol EditVariantControllerDelegate: class {
    func editVariantControllerDidSelectDeleteVariant(controller: EditVariantController)
}

class EditVariantController: ContainedViewController {
    weak var delegate: EditVariantControllerDelegate?
    var editingEnabled: Bool = true
    
    @IBOutlet var selectionView: UIView!
    @IBOutlet var deleteButton: UIView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    var variant: ParseAnswerVariant?
    var editContentController: EditContentController!
    
    override class var storyboardName: String { return "EditQuestionStoryboard" }
    override class var storyboardId: String { return "editVariant" }
    
    class func controllerWithVariant(variant: ParseAnswerVariant) -> EditVariantController? {
        let ctlr = controller()
        ctlr?.variant = variant
        return ctlr
    }
    
    override static func controller() -> EditVariantController? {
        return storyboardController(storyboardName, identifier: storyboardId) as? EditVariantController
    }
    
    @IBOutlet var contentView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        deleteButton.hidden = !editingEnabled
        
        // Do any additional setup after loading the view.
        variant?.fetchIfNeededInBackgroundWithBlock({ (v, error) in
            self.activityIndicator.stopAnimating()
            self.editContentController = EditContentFabric.editController((self.variant?.content)!)
            self.editContentController.editingEnabled = self.editingEnabled
            self.addController(self.editContentController)
            self.refreshSelection()
        })
    }
    
    func addController(controller: EditContentController) {
        let subview = controller.view
        subview.translatesAutoresizingMaskIntoConstraints = false
        addChildViewController(controller)
        contentView.addSubview(subview)
        NSLayoutConstraint.activateConstraints([
            contentView.leadingAnchor.constraintEqualToAnchor(subview.leadingAnchor),
            contentView.trailingAnchor.constraintEqualToAnchor(subview.trailingAnchor),
            contentView.topAnchor.constraintEqualToAnchor(subview.topAnchor),
            contentView.bottomAnchor.constraintEqualToAnchor(subview.bottomAnchor)
        ])
        controller.didMoveToParentViewController(self)
    }
    
    func startEditing() {
        if editingEnabled {
            editContentController?.startEditing()
        }
    }
    
    /// MARK: -
    /// MARK: Actions
    
    @IBAction func didTapRemoveVariant(sender: AnyObject?) {
        delegate?.editVariantControllerDidSelectDeleteVariant(self)
    }
    
    @IBAction func didTapVariantAsCorrect(sender: AnyObject?) {
        guard let v = variant  else { return }
        
        v.correct = !v.correct
        refreshSelection()
//        AnimatingViewController.showInController(self, status: "Saving choice..")
//        v.saveInBackgroundWithBlock { (success, error) in
//            AnimatingViewController.hide()
//        }
    }
    
    func refreshSelection() {
        selectionView.backgroundColor = (variant?.correct ?? false) ? UIColor.greenColor() : UIColor.whiteColor()
    }

}
