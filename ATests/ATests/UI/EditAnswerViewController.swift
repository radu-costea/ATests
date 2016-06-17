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
    var allowedTypes: [ContentType] = [.Text, .Image]
    
    var content: NewVariantsAnswerContent?
    var variants: [AnswerVariant] = []
    
    override class var storyboardName: String { return "EditQuestionStoryboard" }
    override class var storyboardId: String { return "editAnswer" }
    
    class func controllerWithContent(content: NewVariantsAnswerContent?) -> EditAnswerViewController? {
        let controller = self.controller() as? EditAnswerViewController
        controller?.content = content
        return controller
    }
    
    override func loadWith(content: ContentModel?) {
        if let content = content as? NewVariantsAnswerContent {
            self.content = content
        }
    }
    
    override func startEditing() { /* STUB */ }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Load variants
        content?.loadVariantsInBackgroundWithBlock{ (objects, error) in
            if let v = objects {
                self.variants = v.flatMap{ $0 as? AnswerVariant }
                let controllers = self.variants.flatMap{ EditVariantController.controllerWithVariant($0) }
                controllers.forEach { self.setupVariantController($0) }
            }
        }
    }
    
    func setupVariantController(controller: EditVariantController) {
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        addChildViewController(controller)
        stackView.insertArrangedSubview(controller.view, atIndex: stackView.arrangedSubviews.count - 1) ///insertSubview(controller.view, aboveSubview: addAnswerView)
        controller.didMoveToParentViewController(self)
        controller.delegate = self
        controller.presenter = self
    }
    
    @IBAction func didTapAddAnswer(sender: AnyObject?) {
        showSelectContentType {  [unowned self] type in
            let variant = ParseAnswerVariant()
            variant.index = Int32(self.variants.count)
            let variantContent = type.createNewParseContent()
            variant.content = variantContent
            
            print("variant content: \(variant.content)")
            variant.answerContent = self.content
            
            AnimatingViewController.showInController(self, status: "Preparing new variant..")
            variant.saveInBackgroundWithBlock({ (success, error) in
                AnimatingViewController.hide({
                    let controller = self.addVariant(variant)
                    controller?.startEditing()
                })
            })
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
    
    func addVariant(variant: AnswerVariant) -> EditVariantController? {
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
        content?.variants = answerVariants
    }
}


extension EditContentFabric {
    class func variantsController(variants: NewVariantsAnswerContent?) -> EditAnswerViewController? {
        return EditAnswerViewController.controllerWithContent(variants)
    }
}
