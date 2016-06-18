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
        content?.loadVariantsInBackgroundWithBlock{ (objects, error) in
            if let v = objects {
                self.variants = v.flatMap{ $0 as? ParseAnswerVariant }
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
            let variantContent = type.createNewParseContent()
            
            AnimatingViewController.showInController(self, status: "Preparing new variant..")
            variantContent.saveInBackgroundWithBlock({ (success, error) in
                print("variant content saved \(success)")
                let variant = ParseAnswerVariant()
                variant.index = Int32(self.variants.count)
                variant.content = variantContent
                variant.owner = self.content
                
                variant.saveInBackgroundWithBlock({ (success2, error2) in
                    print("variant saved \(success2)")
                    AnimatingViewController.hide({
                        let controller = self.addVariant(variant)
                        controller?.startEditing()
                    })
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
        do {
            try variant.delete()
        } catch { }
        // FIXME: this needs to be fixed
    }
}


extension EditContentFabric {
    class func variantsController(variants: ParseAnswer?) -> EditAnswerViewController? {
        return EditAnswerViewController.controllerWithContent(variants)
    }
}
