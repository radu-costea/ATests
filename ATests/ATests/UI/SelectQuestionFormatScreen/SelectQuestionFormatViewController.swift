//
//  SelectQuestionFormatViewController.swift
//  ATests
//
//  Created by Radu Costea on 15/05/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit

class SelectQuestionFormatViewController: UITableViewController {
    var configurator: VariantsQuestionConfiguration!
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        configurator = VariantsQuestionConfiguration()
        switch indexPath.row {
        case 0:
            configurator.questionContentType = .Image
            performSegueWithIdentifier("goToAnswerTypeSelection", sender: nil)

        case 1:
            configurator.questionContentType = .Text
            performSegueWithIdentifier("goToAnswerTypeSelection", sender: nil)
            
        default: break
        }
    }
    
    @IBAction func backFromContentLayoutSelection(segue: UIStoryboardSegue) {
        if let source = segue.sourceViewController as? SelectContentLayoutViewController {
            configurator.questionContentType = .Mixed(layout: source.layoutType)
            
            dispatch_async(dispatch_get_main_queue(), { [unowned self] () -> Void in
                self.performSegueWithIdentifier("goToAnswerTypeSelection", sender: nil)
            })
            
//            performSelector(Selector("goToAnswers"), withObject: nil, afterDelay: 2.0)
        }
    }
    
    @IBAction func backFromAnswerTypeSelection(segue: UIStoryboardSegue) {
        if let source = segue.sourceViewController as? SelectAnswerFormatViewController {
            configurator.answerContentType = source.answersType
            print("configuration: \(configurator.description())")
            let question = configurator.makeQuestion()
            print("question: \(question)")
        }
    }
}
