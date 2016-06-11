//
//  EditQuestionViewController.swift
//  ATests
//
//  Created by Radu Costea on 27/05/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit

protocol ContainedController {
    var presenter: UIViewController? { get set }
}

class EditQuestionViewController: UIViewController, EditContentViewControllerDelegate {
    @IBOutlet var stackView: UIStackView!
    @IBOutlet var questionContentView: UIView!
    @IBOutlet var questionAnswerView: UIView!
    
    var editContentController: EditContentViewController!
    var editTextController: ContainedViewController!
    
    /// MARK: -
    /// MARK: Class
    
    static var storyboardName: String { return "EditQuestionStoryboard" }
    static var storyboardId: String { return "editQuestion" }
    class func controller() -> EditQuestionViewController? {
        return UIStoryboard(name: storyboardName, bundle: nil).instantiateViewControllerWithIdentifier(storyboardId) as? EditQuestionViewController
    }
    
    var question: LiteQuestion?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let _ = question { }
        else {
            let answerContent = LiteVariantsAnswerContent(with: [
                "identifier": NSUUID().UUIDString,
                "variants": []
            ])!
            let answer = LiteAnswer(with: ["content": answerContent])!
            question = LiteQuestion(with: ["answer": answer])!
        }

        // Do any additional setup after loading the view.
        var contentController = EditContentViewController.controller()!
        contentController.content = question?.content
        contentController.delegate = self
        
        addEditController(&contentController, toView: questionContentView)
        editContentController = contentController
        
        var answerController = EditContentFabric.editController((question?.answer?.content)!)
        addEditController(&answerController, toView: questionAnswerView)
        editTextController = answerController
    }
    
    func addEditController<T: ContainedViewController>(inout controller: T, toView view: UIView) {
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        controller.presenter = self
        
        addChildViewController(controller)
        view.addSubview(controller.view)
        NSLayoutConstraint.activateConstraints([
            controller.view.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor),
            controller.view.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor),
            controller.view.topAnchor.constraintEqualToAnchor(view.topAnchor),
            controller.view.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor)
        ])
        controller.didMoveToParentViewController(self)
    }
    
    func editContentViewControllerDidUpdateContent(controller: EditContentViewController) {
        if controller === editContentController {
            question?.content = controller.content
            question?.tryPersit()
        }
    }
}
