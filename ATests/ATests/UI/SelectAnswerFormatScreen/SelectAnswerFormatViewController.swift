//
//  SelectAnswerFormatViewController.swift
//  ATests
//
//  Created by Radu Costea on 15/05/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit

class SelectAnswerFormatViewController: UITableViewController {
    var answersType: ContentTypeEnum!
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.row {
        case 0:
            answersType = .Image
            performSegueWithIdentifier("goBack", sender: self)
        case 1:
            answersType = .Text
            performSegueWithIdentifier("goBack", sender: self)
        default: break
        }
    }
    
    @IBAction func backFromContentLayoutSelection(segue: UIStoryboardSegue) {
        if let source = segue.sourceViewController as? SelectContentLayoutViewController {
            answersType = .Mixed(layout: source.layoutType)
            dispatch_async(dispatch_get_main_queue(), { [unowned self] () -> Void in
                self.performSegueWithIdentifier("goBack", sender: self)
            })
        }
    }
}
