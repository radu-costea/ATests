//
//  EditTestViewController.swift
//  ATests
//
//  Created by Radu Costea on 06/06/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit

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
//        editController.presenter = self
        stackView.insertArrangedSubview(editController.view, atIndex: atIndex)
        editController.didMoveToParentViewController(self)
    }
    
    @IBAction func didTapAddQuestion(sender: AnyObject?) {
        let answerContent = ParseVariantsAnswerContent()
        let answer = ParseAnswer()
        answer.content = answerContent
        let question = ParseQuestion()
        question.answer = answer
        addQuestion(question, atIndex: questions.count)
        
        questions.append(question)
    }
}
