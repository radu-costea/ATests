//
//  SelectQuestionFormatViewController.swift
//  ATests
//
//  Created by Radu Costea on 15/05/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit

class SelectQuestionFormatViewController: UITableViewController, SelectContentLayoutViewControllerDelegate, AnswerFormatViewControllerDelegate {
    var configurator: VariantsQuestionConfiguration!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator = VariantsQuestionConfiguration()
    }
    
    /// MARK: -
    /// MARK: Table View Delegate Implementation
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.row {
        case 0:
            configurator.questionContentType = .Image
            goToAnswerSelection()

        case 1:
            configurator.questionContentType = .Text
            goToAnswerSelection()
            
        default: break
        }
    }
    
    private func goToAnswerSelection() {
        if let _ = presentedViewController {
            dismissViewControllerAnimated(true) { [unowned self] in
                self.performSegueWithIdentifier("goToAnswerTypeSelection", sender: nil)
            }
        } else {
            self.performSegueWithIdentifier("goToAnswerTypeSelection", sender: nil)            
        }
    }
    
    /// MARK: -
    /// MARK: Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier {
        case let identifier where identifier == "goToLayoutTypeSelection":
            if let destination = segue.destinationViewController as? SelectContentLayoutViewController {
                destination.delegate = self
            }
        case let identifier where identifier == "goToAnswerTypeSelection":
            if let destination = segue.destinationViewController as? SelectAnswerFormatViewController {
                destination.delegate = self
            }
        default:
            break
        }
    }
    
    /// MARK: -
    /// MARK: SelectContentLayoutViewControllerDelegate
    
    func layoutViewControllerDidSelectLayout(controller: SelectContentLayoutViewController) {
        configurator.questionContentType = .Mixed(layout: controller.layoutType)
        goToAnswerSelection()
    }
    
    /// MARK: -
    /// MARK: AnswerFormatViewControllerDelegate
    
    func answerFormatViewControllerDidSelectFormat(controller: SelectAnswerFormatViewController) {
        configurator.answerContentType = controller.answersType
        performSegueWithIdentifier("backToTest", sender: self)
    }
}
