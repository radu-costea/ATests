//
//  TestTableViewController.swift
//  ATests
//
//  Created by Radu Costea on 09/06/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit
import Parse

class TestTableViewController: UITableViewController {
    var test: ParseDomain!
    var keyboardAvoider: ScrollViewKeyboardAvoider!
    @IBOutlet var titleTextField: UITextField!
    var questions: [ParseQuestion] = []
    var selectedIndex: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if test == nil {
//            test = LiteTest(with: ["title" : "My Test", "sortedQuestions" : []])
//        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        test.fetchQuestionsInBackgroundWithBlock { (q, error) in
            self.questions = q ?? []
            self.tableView.reloadData()
        }
        keyboardAvoider = ScrollViewKeyboardAvoider(scrollView: tableView)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        keyboardAvoider.startListeningForKeyboardNotifications()
        
        titleTextField.text = test.title
        if let idx = selectedIndex {
            tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: idx, inSection: 0)], withRowAnimation: .Automatic)
        }
        observeTextChanges()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        keyboardAvoider.stopListeningForKeyboardNotifications()
        stopObservingTextFieldChanges()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let question = questions[indexPath.row]
        guard let content = question.content else {
            return tableView.dequeueReusableCellWithIdentifier("undefined")!
        }
        
        if let _ = content as? ParseImageContent {
            if let cell = tableView.dequeueReusableCellWithIdentifier("imageCell") as? ImageContentQuestionTableViewCell {
                cell.question = question
                return cell
            }
        }
        
        if let _ = content as?ParseTextContent {
            if let cell = tableView.dequeueReusableCellWithIdentifier("textCell") as? TextContentQuestionTableViewCell {
                cell.question = question
                return cell
            }
        }
        fatalError("dafuq is this index")
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedIndex = indexPath.row
        performSegueWithIdentifier("goToEditQuestion", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier where identifier == "goToEditQuestion" {
            if let controller = segue.destinationViewController as? EditQuestionViewController,
                let idx = selectedIndex {
                
                let question = questions[idx]
                controller.provideContentBlock = { _ in question.content }
                controller.provideAnswerBlock = { _ in question.answer! }
                controller.onSaveBlock = { editQuestionController in
                    question.content = editQuestionController.content
                    (question.answer as? ParseAnswer)?.updateValidState()
                    question.answer = editQuestionController.answer
                    AnimatingViewController.showInController(editQuestionController, status: "Saving changes..")
                    question.saveInBackgroundWithBlock({ (success, error) in
                        AnimatingViewController.hide({ 
                            self.navigationController?.popViewControllerAnimated(true)
                        })
                    })
                }
            }
        }
        view.endEditing(true)
    }
    
    /// MARK: -
    /// MARK: Text change
    
    func observeTextChanges() {
        textFieldObserver = NSNotificationCenter.defaultCenter().addObserverForName(UITextFieldTextDidChangeNotification, object: titleTextField, queue: nil, usingBlock: { [unowned self] _ in
            self.textFieldValueChanged()
        })
    }
    
    func stopObservingTextFieldChanges() {
        guard let observer = textFieldObserver else {
            return
        }
        NSNotificationCenter.defaultCenter().removeObserver(observer)
    }
    
    var textFieldObserver: NSObjectProtocol?
    func textFieldValueChanged() {
        self.test.title = titleTextField.text
    }
    
    /// MARK: -
    /// MARK: Add Question
    
    @IBAction func didTapSave(sender: AnyObject?) {
        AnimatingViewController.showInController(self, status: "Saving domain...")
        test.saveInBackgroundWithBlock { (success, error) in
            AnimatingViewController.hide({ 
                self.navigationController?.popViewControllerAnimated(true)
            })
        }
    }
    
    @IBAction func didTapAddQuestion(sender: AnyObject?) {
        AnimatingViewController.showInController(self, status: "Preparing question..")
        let answer = ParseAnswer()
        
        AnimatingViewController.setStatus("Preparing answer ..")
        answer.saveInBackgroundWithBlock({ (success2, error2) in
            AnimatingViewController.setStatus("Saving answer ..")
            let question = ParseQuestion()
            question.answer = answer
            let idx = self.questions.count
            self.questions.append(question)
            
            question.domain = self.test
            
            AnimatingViewController.setStatus("Saving question ..")
            question.saveInBackgroundWithBlock { (success, error) in
                self.test.saveInBackgroundWithBlock({ (success2, err2) in
                    AnimatingViewController.hide({ 
                        self.selectedIndex = idx
                        self.tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: idx, inSection: 0)], withRowAnimation: .Automatic)
                        self.performSegueWithIdentifier("goToEditQuestion", sender: self)
                    })
                })
            }
        })
    }
    
}
