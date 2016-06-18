//
//  EditTestViewController.swift
//  ATests
//
//  Created by Radu Costea on 06/06/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit
import Parse
class EditTestViewController: UIViewController {
    @IBOutlet var stackView: UIStackView!
    var questions: [ParseQuestion] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        (0..<questions.count).forEach { addQuestion(questions[$0], atIndex: $0) }
    }
    
    func addQuestion(question: ParseQuestion, atIndex: Int) {
        guard let editController = EditQuestionViewController.controller() else {
            return
        }
        addChildViewController(editController)
        editController.question = question
        editController.view.translatesAutoresizingMaskIntoConstraints = false
        stackView.insertArrangedSubview(editController.view, atIndex: atIndex)
        editController.didMoveToParentViewController(self)
    }
    
    @IBAction func didTapAddQuestion(sender: AnyObject?) {
        AnimatingViewController.showInController(self, status: "Preparing question...")
        
        let answer = ParseAnswer()
        
        AnimatingViewController.showInController(self, status: "Preparing answer...")
        answer.saveInBackgroundWithBlock({ (success2, error2) in
            let question = ParseQuestion()
            question.answer = answer
        
            AnimatingViewController.showInController(self, status: "Finalizing ...")
            question.saveInBackgroundWithBlock({ (success3, error3) in
                AnimatingViewController.hide()
                self.addQuestion(question, atIndex: self.questions.count)
                self.questions.append(question)
            })
        })
    }
}
