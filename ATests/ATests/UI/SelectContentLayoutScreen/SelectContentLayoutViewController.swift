//
//  SelectContentLayoutViewController.swift
//  ATests
//
//  Created by Radu Costea on 15/05/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit

class SelectContentLayoutViewController: UITableViewController {
    var layoutType: LayoutTypeEnum!
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.row {
        case 0:
            layoutType = .ImageAtTop
        case 1:
            layoutType = .ImageAtBottom
        case 2:
            layoutType = .ImageAtLeft
        default:
            layoutType = .ImageAtRight
        }
        performSegueWithIdentifier("goBack", sender: self)
    }
}
