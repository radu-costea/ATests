//
//  SelectAnswerFormatViewController.swift
//  ATests
//
//  Created by Radu Costea on 15/05/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit

protocol AnswerFormatViewControllerDelegate: class {
    func answerFormatViewControllerDidSelectFormat(controller: SelectAnswerFormatViewController) -> Void
}

class SelectAnswerFormatViewController: UITableViewController, SelectContentLayoutViewControllerDelegate {
    var answersType: ContentTypeEnum!
    weak var delegate: AnswerFormatViewControllerDelegate?
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.row {
        case 0:
            answersType = .Image
            notifiSelection()
        case 1:
            answersType = .Text
            notifiSelection()
        default:
            break
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goToSelectLayout" {
            if let destination = segue.destinationViewController as? SelectContentLayoutViewController {
                destination.delegate = self
            }
        }
    }
    
    private func notifiSelection() {
        if let safeDelegate = delegate {
            safeDelegate.answerFormatViewControllerDidSelectFormat(self)
        }
    }
    
    /// MARK: -
    /// MARK: SelectContentLayoutViewControllerDelegate
    
    func layoutViewControllerDidSelectLayout(controller: SelectContentLayoutViewController) {
        answersType = .Mixed(layout: controller.layoutType)
        dismissViewControllerAnimated(true) { [unowned self] in
            self.notifiSelection()
        }
    }
}
