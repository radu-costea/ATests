//
//  CreateSimulationTableViewController.swift
//  ATests
//
//  Created by Radu Costea on 15/06/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit
import Parse

class ParseExamQuestionBuilder {
    var question: ParseQuestion
    var points: Int = 1
    var include: Bool = false
    
    init(question: ParseQuestion) {
        self.question = question
    }
    
    func build() -> ParseExamQuestion? {
        guard include else {
            return nil
        }
        return ParseExamQuestion(question: question, points: points)
    }
}


class CreateSimulationTableViewController: UITableViewController, SimulationQuestionTableViewCellDelegate {
    @IBOutlet var selectFreePoints: UIButton!
    @IBOutlet var selectDuration: UIButton!
    @IBOutlet var total: UIButton!
    @IBOutlet var buttonNeXT: UIButton!
    
    var freePoints = 0 { didSet { refreshPoints() } }
    var totalPoints = 0
    var duration = 1800 { didSet { refreshDuration() } }
    var domain: ParseDomain!
    var dataSource: [ParseExamQuestionBuilder] = []
    var setupPicker: ((PickerViewController) -> Void)?
    
    var quizz: ParseExam?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let d = domain else {
            return
        }
        
        domain.fetchQuestionsInBackgroundWithBlock { (questions, error) in
            self.dataSource = questions?.flatMap{ ParseExamQuestionBuilder(question: $0) } ?? []
            self.tableView.reloadData()
            self.refresh()
        }
        refresh()
    }
    
    /// MARK: -
    /// MARK: Update UI
    
    func refreshDuration() {
        let hours = duration / 3600
        let minutes = (duration % 3600) / 60
        selectDuration?.setTitle("\(hours):\(minutes)", forState: .Normal)
    }
    
    func refreshPoints() {
        totalPoints = self.dataSource.reduce(freePoints) { $0 + ($1.include ? $1.points : 0) }
        selectFreePoints?.setTitle("\(freePoints)", forState: .Normal)
        total.setTitle("\(totalPoints)", forState: .Normal)
    }
    
    func refreshNextButtonState() -> Void {
        let atLeastOneQuestion = self.dataSource.contains { $0.include == true }
        self.buttonNeXT.enabled = atLeastOneQuestion
    }
    
    func refresh() {
        refreshDuration()
        refreshPoints()
        refreshNextButtonState()
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let builder = dataSource[indexPath.row]
        if builder.question.isValid() {
            if let _ = builder.question.content as? ParseImageContent {
                let cell = tableView.dequeueReusableCellWithIdentifier("imageQuestion", forIndexPath: indexPath) as! SimulationQuestionTableViewCell
                cell.builder = builder
                cell.delegate = self
                return cell
            } else if let _ = builder.question.content as? ParseTextContent {
                let cell = tableView.dequeueReusableCellWithIdentifier("textQuestion", forIndexPath: indexPath) as! SimulationQuestionTableViewCell
                cell.builder = builder
                cell.delegate = self
                return cell
            }
        }
        return tableView.dequeueReusableCellWithIdentifier("invalidQuestion", forIndexPath: indexPath)
    }
    
//    /// MARK: -
//    /// MARK: Navigation
//    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if let identifier = segue.identifier {
//            switch identifier {
//            case "goToWaitQuiz":
//                if let destiation = segue.destinationViewController as? QuizWaitingViewController {
//                    destiation.quiz = createQuiz()
//                }
//            default:
//                break;
//            }
//        }
//    }
//    
//    func createQuiz() -> LiteSimulationTest? {
//        let questions = builders.flatMap{ $0.buildSimulationQuestion() }
//        let params = [
//            "testDuration" : NSNumber(float: 60),
//            "questions" : NSSet(array: questions),
//            "joinId": NSUUID().UUIDString
//        ]
//        return LiteSimulationTest(with: params)
//    }
//    
    /// MARK: -
    /// MARK: SimulationQuestionTableViewCellDelegate
    
    func simulationQuestionCellDidUpdateWeight(cell: SimulationQuestionTableViewCell) {
        refreshPoints()
    }
    
    func simulationQuestionCellDidUpdateInclude(cell: SimulationQuestionTableViewCell) {
        refreshPoints()
        refreshNextButtonState()
    }
    
    
    /// MARK: -
    /// MARK: Actions
    
    @IBAction func didTapSelectFreePoints(sender: UIButton?) -> Void {
        self.setupPicker = {
            $0.columns = [PickerViewControllerColumn(count: 100, selected: self.freePoints) { "\($0) Points" }]
            $0.onCompletion = {
                self.freePoints = $0.columns[0].selected
                self.dismissViewControllerAnimated(true, completion: nil)
                self.setupPicker = nil
            }
        }
        
        self.performSegueWithIdentifier("pickValue", sender: sender)
    }
    
    @IBAction func didTapSelectDuration(sender: UIButton?) -> Void {
        self.setupPicker = {
            let hours = self.duration / 3600
            let minutes = (self.duration % 3600) / 60
            $0.columns = [
                PickerViewControllerColumn(count: 12, selected: hours) { "\($0) Hour\($0 == 1 ? "" : "s")" },
                PickerViewControllerColumn(count: 60, selected: minutes) { "\($0) Minute\($0 == 1 ? "" : "s")" },
            ]
            $0.onCompletion = {
                let hours = $0.columns[0].selected
                let minutes = $0.columns[1].selected
                self.duration = hours * 3600 + minutes * 60
                self.dismissViewControllerAnimated(true, completion: nil)
                self.setupPicker = nil
            }
        }
        
        self.performSegueWithIdentifier("pickValue", sender: sender)
    }
    
    @IBAction func didTapCreateQuizz(sender: AnyObject?) {
        let quizzQuestions = dataSource.flatMap{ $0.build() }
        let exam = ParseExam()
        exam.questions = quizzQuestions
        exam.duration = duration
        exam.state = .NotStarted
        exam.joinId = NSUUID().UUIDString
        exam.freePoints = freePoints
        exam.totalPoints = totalPoints
        
        AnimatingViewController.showInController(self, status: "Preparing questions..")
        exam.saveInBackgroundWithBlock { (success, error) in
            print("\(error)")
            self.quizz = exam
            AnimatingViewController.hide{
                self.performSegueWithIdentifier("goToWaitQuiz", sender: sender)
            }
        }
    }
    
    /// MARK: -
    /// MARK: Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "pickValue":
                let destination = segue.destinationViewController as! PickerViewController
                setupPicker?(destination)
            case "goToWaitQuiz":
                if let destiation = segue.destinationViewController as? QuizWaitingViewController {
                    destiation.quizz = quizz!
                }
            default:
                break
            }
        }
    }
}
