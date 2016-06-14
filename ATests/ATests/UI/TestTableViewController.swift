//
//  TestTableViewController.swift
//  ATests
//
//  Created by Radu Costea on 09/06/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit

class TestTableViewController: UITableViewController {
    var test: LiteTest!
    var keyboardAvoider: ScrollViewKeyboardAvoider!
    @IBOutlet var titleTextField: UITextField!
    var questions: [LiteQuestion] = []
    var selectedIndex: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if test == nil {
            test = LiteTest(with: ["title" : "My Test", "sortedQuestions" : []])
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        questions = test.sortedQuestions ?? []
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
        test.tryPersit()
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
        
        if let imageContent = content as? LiteImageContent {
            if let cell = tableView.dequeueReusableCellWithIdentifier("imageCell") as? ImageContentTableViewCell {
                cell.content = imageContent
                return cell
            }
        }
        
        if let textContent = content as? LiteTextContent {
            if let cell = tableView.dequeueReusableCellWithIdentifier("textCell") as? TextContentTableViewCell {
                cell.content = textContent
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
                let idx = selectedIndex{
                controller.question = questions[idx]
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
    
    @IBAction func didTapAddQuestion(sender: AnyObject?) {
        let answerContent = LiteVariantsAnswerContent(with: [
            "identifier": NSUUID().UUIDString,
            "variants": []
        ])!
        
        let answer = LiteAnswer(with: ["content": answerContent])!
        let question = LiteQuestion(with: ["answer": answer])!
        question.creationDate = NSDate().timeIntervalSinceReferenceDate
        let idx = questions.count
        
        questions.append(question)
        test.sortedQuestions = questions
        
        selectedIndex = idx
        tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: idx, inSection: 0)], withRowAnimation: .Automatic)
        performSegueWithIdentifier("goToEditQuestion", sender: self)
    }
    
}
