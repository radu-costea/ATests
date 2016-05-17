//
//  SelectContentLayoutViewController.swift
//  ATests
//
//  Created by Radu Costea on 15/05/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit

protocol SelectContentLayoutViewControllerDelegate: class {
    func layoutViewControllerDidSelectLayout(controller: SelectContentLayoutViewController) -> Void
}

class SelectContentLayoutViewController: UITableViewController {
    var layoutType: LayoutTypeEnum!
    weak var delegate: SelectContentLayoutViewControllerDelegate?
    
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
        
        if let safeDelegate = delegate {
            safeDelegate.layoutViewControllerDidSelectLayout(self)
        }
    }
}
