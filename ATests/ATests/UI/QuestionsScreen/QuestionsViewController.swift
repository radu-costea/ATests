//
//  QuestionsViewController.swift
//  ATests
//
//  Created by Radu Costea on 15/04/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit

class QuestionsViewController: BaseViewController, UITableViewDataSource {
    @IBOutlet var tableView: UITableView!
    var test: Test!
    var dataSource: [QuestionObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        test = Test.new(["title" : "My test"]) as? Test
        let questions = test.questions?.allObjects ?? []
        dataSource = questions as? [QuestionObject] ?? []
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    /// MARK: -
    /// MARK: TableViewDelegate
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        cell.textLabel?.text = "\(dataSource[indexPath.row])"
        return cell
    }
    
    /// MARK: -
    /// MARK: Navigation
    
    @IBAction func backFromCreateQuestion(segue: UIStoryboardSegue) -> Void {
        if let source = segue.sourceViewController as? SelectQuestionFormatViewController {
            print("source controller: \(source)")
            let configurator = source.configurator
            let newQuestion = configurator.makeQuestion()
            if let question = newQuestion {
                dataSource.append(question)
                test.questions = test.questions != nil ? test.questions?.setByAddingObject(question) : NSSet(object: question)
                tableView.reloadData()
            }
        }
    }
}
