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
    var questions: [LiteQuestion] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        (0..<questions.count).forEach { addQuestion(questions[$0], atIndex: $0) }
    }
    
    func addQuestion(question: LiteQuestion, atIndex: Int) {
        guard let editController = EditQuestionViewController.controller() else {
            return
        }
        addChildViewController(editController)
        editController.question = question
        editController.view.translatesAutoresizingMaskIntoConstraints = false
        editController.presenter = self
        stackView.insertArrangedSubview(editController.view, atIndex: atIndex)
        editController.didMoveToParentViewController(self)
    }
    
    @IBAction func didTapAddQuestion(sender: AnyObject?) {
        let answerContent = LiteVariantsAnswerContent.new([
            "identifier": NSUUID().UUIDString,
            "variants": []
        ]) as! LiteVariantsAnswerContent
        
        let answer = LiteAnswer.new(["content": answerContent]) as! LiteAnswer
        let question = LiteQuestion.new(["answer": answer]) as! LiteQuestion
        addQuestion(question, atIndex: questions.count)
        questions.append(question)
    }
}
