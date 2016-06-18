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
    
    @IBOutlet var selectionView: UIView!
    var variant: ParseAnswerVariant?
    var editContentController: EditContentController!
    
    override class var storyboardName: String { return "EditQuestionStoryboard" }
    override class var storyboardId: String { return "editVariant" }
    
    override class func controller() -> EditVariantController? {
        return UIStoryboard(name: storyboardName, bundle: nil).instantiateViewControllerWithIdentifier(storyboardId) as? EditVariantController
    }
    
    class func controllerWithVariant(variant: ParseAnswerVariant) -> EditVariantController? {
        let ctlr = controller()
        ctlr?.variant = variant
        return ctlr
    }
    
    @IBOutlet var contentView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        editContentController = EditContentFabric.editController((variant?.content)!)
        addController(editContentController)
        refreshSelection()
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
        controller.presenter = self
    }
    
    func startEditing() {
        editContentController?.startEditing()
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
        AnimatingViewController.showInController(self, status: "Saving choice..")
        v.saveInBackgroundWithBlock { (success, error) in
            AnimatingViewController.hide()
        }
    }
    
    func refreshSelection() {
        selectionView.backgroundColor = (variant?.correct ?? false) ? UIColor.greenColor() : UIColor.whiteColor()
    }

}
