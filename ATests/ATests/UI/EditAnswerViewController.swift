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
    
    var content: LiteVariantsAnswerContent?
    var variants: [LiteAnswerVariant] { return content?.variants.sort{ $0.index < $1.index } ?? [] }
    
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
        stackView.insertArrangedSubview(controller.view, atIndex: stackView.arrangedSubviews.count - 1) ///insertSubview(controller.view, aboveSubview: addAnswerView)
        self.addChildViewController(controller)
        controller.didMoveToParentViewController(self)
        controller.delegate = self
        controller.presenter = self
    }
    
    @IBAction func didTapAddAnswer(sender: AnyObject?) {
        let variant = LiteAnswerVariant(content: LiteImageContent(identifier: NSUUID().UUIDString, image: nil))
        addVariant(variant)
    }
    
    /// MARK: -
    /// MARK: Edit Variant Controller Delegate 
    
    func addVariant(variant: LiteAnswerVariant) {
        content?.variants = variants + [variant]
        if let controller = EditVariantController.controllerWithVariant(variant) {
            setupVariantController(controller)
        }
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
