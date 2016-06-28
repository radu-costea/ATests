//
//  EditQuestionViewController.swift
//  ATests
//
//  Created by Radu Costea on 27/05/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit
import Parse

class EditQuestionViewController: UIViewController, EditContentViewControllerDelegate {
    var provideContentBlock:((EditQuestionViewController) -> PFObject?)!
    var provideAnswerBlock:((EditQuestionViewController) -> PFObject?)!
    var onSaveBlock:((EditQuestionViewController) -> Void)?
    
//    var question: ParseQuestion?
    var content: PFObject?
    var answer: PFObject!
    var editingEnabled: Bool = true
    
    // Outlets
    @IBOutlet var stackView: UIStackView!
    @IBOutlet var questionContentView: UIView!
    @IBOutlet var questionAnswerView: UIView!
    
    // Contained controllers
    var editContentController: EditContentViewController!
    var editAnswerController: EditContentController!
    
    /// MARK: -
    /// MARK: Class
    
    static var storyboardName: String { return "EditQuestionStoryboard" }
    static var storyboardId: String { return "editQuestion" }
    class func controller() -> EditQuestionViewController? {
        return UIStoryboard(name: storyboardName, bundle: nil).instantiateViewControllerWithIdentifier(storyboardId) as? EditQuestionViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
        content = provideContentBlock(self)
        var contentController = EditContentViewController.controller()!
        contentController.content = content
        contentController.delegate = self
        
        addEditController(&contentController, toView: questionContentView)
        editContentController = contentController
        editContentController.editingEnabled = editingEnabled
        
        answer = provideAnswerBlock(self)
        var answerController = EditContentFabric.editController(answer)
        answerController.editingEnabled = editingEnabled
        addEditController(&answerController, toView: self.questionAnswerView)
        editAnswerController = answerController
    }
    
    func addEditController<T: ContainedViewController>(inout controller: T, toView view: UIView) {
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        
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
            content = controller.content
        }
    }
    
    /// MARK: -
    /// MARK: Actions
    
    @IBAction func didTapSave(sender: AnyObject?) {
        self.content = editContentController.content
        onSaveBlock?(self)
        
//        guard let q = question else {
//            self.navigationController?.popViewControllerAnimated(true)
//            return
//        }
//        AnimatingViewController.showInController(self, status: "Saving question..")
//        q.parseContent = [editContentController.content!]
//        q.saveInBackgroundWithBlock { (success, error) in
//            if let err = error {
//                AnimatingViewController.setStatus("Error: \(err.localizedDescription)")
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(2.0 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), {
//                    AnimatingViewController.hide()
//                    self.navigationController?.popViewControllerAnimated(true)
//                })
//                return
//            }
//            AnimatingViewController.hide { 
//                self.navigationController?.popViewControllerAnimated(true)
//            }
//        }
    }
}
