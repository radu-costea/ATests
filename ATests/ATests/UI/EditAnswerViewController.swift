//
//  EditAnswerViewController.swift
//  ATests
//
//  Created by Radu Costea on 30/05/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit

class EditAnswerViewController: EditContentController, EditVariantControllerDelegate {
    @IBOutlet var stackView: UIStackView!
    @IBOutlet var addAnswerView: UIView!
    var allowedTypes: [LiteContentType] = [.Text, .Image]
    
    var content: LiteVariantsAnswerContent?
    var variants: [LiteAnswerVariant] { return content?.sortedVariants ?? [] }
    
    override class var storyboardName: String { return "EditQuestionStoryboard" }
    override class var storyboardId: String { return "editAnswer" }
    
    class func controllerWithContent(content: LiteVariantsAnswerContent?) -> EditAnswerViewController? {
        let controller = self.controller() as? EditAnswerViewController
        controller?.content = content
        return controller
    }
    
    override func loadWith<T: LiteContent>(content: T?) {
        if let content = content as? LiteVariantsAnswerContent {
            self.content = content
        }
    }
    
    override func startEditing() {
        // STUB
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let controllers = self.variants.flatMap{ EditVariantController.controllerWithVariant($0) }
        controllers.forEach { setupVariantController($0) }
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
            let variant = LiteAnswerVariant(with: ["content": type.createNewContent(NSUUID().UUIDString)])! //as! LiteAnswerVariant
            let controller = self.addVariant(variant)
            controller?.startEditing()
        }
    }
    
    func showSelectContentType(completion: (type: LiteContentType) -> Void) {
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
    
    func addVariant(variant: LiteAnswerVariant) -> EditVariantController? {
        content?.variants = variants + [variant]
        guard let controller = EditVariantController.controllerWithVariant(variant) else {
            return nil
        }
        setupVariantController(controller)
        return controller
    }

    func editVariantControllerDidSelectDeleteVariant(controller: EditVariantController) {
        var answerVariants = variants
        guard let variant = controller.variant,
                let idx = answerVariants.indexOf(variant) else {
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
    class func variantsController(variants: LiteVariantsAnswerContent?) -> EditAnswerViewController? {
        return EditAnswerViewController.controllerWithContent(variants)
    }
}
