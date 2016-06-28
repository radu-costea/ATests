//
//  EditAnswerViewController.swift
//  ATests
//
//  Created by Radu Costea on 30/05/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit
import Parse

class EditAnswerViewController: EditContentController, EditVariantControllerDelegate {
    @IBOutlet var stackView: UIStackView!
    @IBOutlet var addAnswerView: UIView!
    @IBOutlet var activityView: UIActivityIndicatorView!
    
    var allowedTypes: [ContentType] = [.Text, .Image]
    
    var content: ParseAnswer?
    var variants: [ParseAnswerVariant] = []
    
    override class var storyboardName: String { return "EditQuestionStoryboard" }
    override class var storyboardId: String { return "editAnswer" }
    
    class func controllerWithContent(content: ParseAnswer?) -> EditAnswerViewController? {
        let controller = self.controller() as? EditAnswerViewController
        controller?.content = content
        return controller
    }
    
    override func loadWith(content: PFObject?) {
        if let content = content as? ParseAnswer {
            self.content = content
        }
    }
    
    override func startEditing() { /* STUB */ }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Load variants
        addAnswerView.hidden = true
        content?.fetchIfNeededInBackgroundWithBlock { (success, error) in
            self.activityView.stopAnimating()
            self.addAnswerView.hidden = !self.editingEnabled
            self.variants = self.content?.variants ?? []
            let controllers = self.variants.flatMap{ EditVariantController.controllerWithVariant($0) }
            
            for controller in controllers {
                self.setupVariantController(controller)
            }
        }
    }
    
    func setupVariantController(controller: EditVariantController) {
        controller.editingEnabled = editingEnabled
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        addChildViewController(controller)
        
        let idx = stackView.arrangedSubviews.count - 1
        stackView.insertArrangedSubview(controller.view, atIndex: idx) ///insertSubview(controller.view, aboveSubview: addAnswerView)
        controller.didMoveToParentViewController(self)
        controller.delegate = self
        
        print("insert at index: \(idx)")
    }
    
    @IBAction func didTapAddAnswer(sender: AnyObject?) {
        guard let answer = content else {
            return
        }
        
        showSelectContentType {  [unowned self] type in
            let variantContent = type.createNewParseContent()
            
            let variant = ParseAnswerVariant()
            variant.index = Int32(self.variants.count)
            variant.content = variantContent
            self.variants.append(variant)
            answer.variants = self.variants
            AnimatingViewController.hide {
                let controller = self.addVariant(variant)
                controller?.startEditing()
            }
        }
    }
    
    func showSelectContentType(completion: (type: ContentType) -> Void) {
        let alert = UIAlertController(title: nil, message: "Please select content type", preferredStyle: .ActionSheet)
        var actions = allowedTypes.map { type in
            return UIAlertAction(title: type.name(), style: .Default, handler: { _ in completion(type: type) })
        }
        actions.append(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        actions.forEach{ alert.addAction($0) }
        presentViewController(alert, animated: true, completion: nil)
    }
    
    /// MARK: -
    /// MARK: Edit Variant Controller Delegate 
    
    func addVariant(variant: ParseAnswerVariant) -> EditVariantController? {
        guard let controller = EditVariantController.controllerWithVariant(variant) else {
            return nil
        }
        setupVariantController(controller)
        return controller
    }

    func editVariantControllerDidSelectDeleteVariant(controller: EditVariantController) {
        var answerVariants = variants
        guard let variant = controller.variant,
                let idx = answerVariants.indexOf({ $0.objectId == variant.objectId }) else {
                return
        }
        for i in (idx + 1)..<(answerVariants.count) {
            answerVariants[i - 1].index = answerVariants[i].index
        }
        answerVariants.removeAtIndex(idx)
        controller.removeFromParentViewController()
        controller.view.removeFromSuperview()
        
        if let answer = content {
            answer.variants = answerVariants
            AnimatingViewController.showInController(self, status: "Cleaning up data")
            variant.deleteInBackgroundWithBlock { (success, err) in
                AnimatingViewController.hide()
            }
        }
    }
}


extension EditContentFabric {
    class func variantsController(variants: ParseAnswer?) -> EditAnswerViewController? {
        return EditAnswerViewController.controllerWithContent(variants)
    }
}
