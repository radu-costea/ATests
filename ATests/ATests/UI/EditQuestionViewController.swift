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

class EditQuestionViewController: UIViewController {
    @IBOutlet var stackView: UIStackView!
    @IBOutlet var questionContentView: UIView!
    @IBOutlet var questionAnswerView: UIView!
    
    var editContentController: EditContentController!
    var editTextController: ContainedViewController!
    
    var question: LiteQuestion?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let _ = question { }
        else {
            let content = LiteTextContent(identifier: NSUUID().UUIDString, text: nil)
            let answer = LiteAnswer(content: LiteVariantsAnswerContent(identifier: NSUUID().UUIDString, variants: []))
            question = LiteQuestion(content: content, answer: answer, evaluator: nil)
        }

        // Do any additional setup after loading the view.
        editContentController = EditContentFabric.editController((question?.content)!)
        addEditController(editContentController, toView: questionContentView)
        
        editTextController = EditContentFabric.editController((question?.answer?.content)!)
        addEditController(editTextController, toView: questionAnswerView)
        
        showQuestion()
    }
    
    func showQuestion() {
        print("\(question)")
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), { [unowned self] _ in
            self.showQuestion()
        })
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
