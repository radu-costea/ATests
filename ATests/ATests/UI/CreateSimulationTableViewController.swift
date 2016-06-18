//
//  CreateSimulationTableViewController.swift
//  ATests
//
//  Created by Radu Costea on 15/06/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit
import Parse
class CreateSimulationTableViewController: UITableViewController, SimulationQuestionTableViewCellDelegate {
    @IBOutlet var pointsLabel: UILabel!
//    
//    var test: LiteTest!
//    var builders: [SimulationQuestionBuilder] = []
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        let questions = test.sortedQuestions ?? []
//        builders = questions.map{ SimulationQuestionBuilder(question: $0) }
//        refreshTotalPoints()
//    }
//
//    // MARK: - Table view data source
//
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//         #warning Incomplete implementation, return the number of rows
//        return builders.count
//    }
//
//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let builder = builders[indexPath.row]
//        if builder.question.isValid() {
//            if let _ = builder.question.content as? LiteImageContent {
//                let cell = tableView.dequeueReusableCellWithIdentifier("imageQuestion", forIndexPath: indexPath) as! SimulationQuestionTableViewCell
//                cell.builder = builder
//                cell.delegate = self
//                return cell
//            } else if let _ = builder.question.content as? LiteTextContent {
//                let cell = tableView.dequeueReusableCellWithIdentifier("textQuestion", forIndexPath: indexPath) as! SimulationQuestionTableViewCell
//                cell.builder = builder
//                cell.delegate = self
//                return cell
//            }
//        }
//        return tableView.dequeueReusableCellWithIdentifier("invalidQuestion", forIndexPath: indexPath)
//    }
//    
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
//    /// MARK: -
//    /// MARK: SimulationQuestionTableViewCellDelegate
//    
    func simulationQuestionCellDidUpdateWeight(cell: SimulationQuestionTableViewCell) {
        refreshTotalPoints()
    }
    
    func simulationQuestionCellDidUpdateInclude(cell: SimulationQuestionTableViewCell) {
        refreshTotalPoints()
    }
    
    func refreshTotalPoints() {
//        let points = builders.reduce(0){ $0 + ($1.include ? $1.weight : 0) }
//        pointsLabel.text = "\(points)"
    }
}
