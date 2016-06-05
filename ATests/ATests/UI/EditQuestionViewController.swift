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

class EditQuestionViewController: ContainedViewController, EditContentViewControllerDelegate {
    @IBOutlet var stackView: UIStackView!
    @IBOutlet var questionContentView: UIView!
    @IBOutlet var questionAnswerView: UIView!
    
    var editContentController: EditContentViewController!
    var editTextController: ContainedViewController!
    
    /// MARK: -
    /// MARK: Class
    
    override static var storyboardName: String { return "EditQuestionStoryboard" }
    override static var storyboardId: String { return "editQuestion" }
    override class func controller() -> EditQuestionViewController? {
        return super.controller() as? EditQuestionViewController
    }
    
    var question: LiteQuestion?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let _ = question { }
        else {
            let answer = LiteAnswer(content: LiteVariantsAnswerContent(identifier: NSUUID().UUIDString, variants: []))
            question = LiteQuestion(content: nil, answer: answer, evaluator: nil)
        }

        // Do any additional setup after loading the view.
        editContentController = EditContentViewController.controller()
        editContentController.content = question?.content
        editContentController.delegate = self
        
        addEditController(editContentController, toView: questionContentView)
        
        editTextController = EditContentFabric.editController((question?.answer?.content)!)
        addEditController(editTextController, toView: questionAnswerView)
    }
    
    func addEditController<T: ContainedController where T: UIViewController>(var controller: T, toView view: UIView) {
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        controller.presenter = self
        
        view.addSubview(controller.view)
        controller.didMoveToParentViewController(self)
        
        NSLayoutConstraint.activateConstraints([
            controller.view.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor),
            controller.view.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor),
            controller.view.topAnchor.constraintEqualToAnchor(view.topAnchor),
            controller.view.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor)
        ])
    }
    
    func editContentViewControllerDidUpdateContent(controller: EditContentViewController) {
        if controller === editContentController {
            question?.content = controller.content
        }
    }
}
