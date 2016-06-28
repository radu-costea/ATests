//
//  TestsTableViewController.swift
//  ATests
//
//  Created by Radu Costea on 11/06/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit
import Parse

class TestsTableViewController: UITableViewController, TestTableViewCellDelegate {
    var tests: [ParseDomain] = []
    var selectedIndex: Int?
    let currentUser = ParseUser.currentUser()!
    var contentLoaded: Bool = false
    

    /// MARK: -
    /// MARK: Lifecycle
    
    override func viewDidAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if contentLoaded == false {
            contentLoaded = true
            // Fetching all domains
            AnimatingViewController.showInController(self, status: "Fetching domains.. ")
            currentUser.fetchSubEntities("ParseDomain", key: "owner"){ (objects, error) in
                AnimatingViewController.hide()
                self.tests = objects?.flatMap{ $0 as? ParseDomain } ?? []
                self.tableView.reloadData()
            }
            return
        }
        
        if let idx = selectedIndex {
            tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: idx, inSection: 0)], withRowAnimation: .Automatic)
        }
    }

    /// MARK: -
    /// MARK: Table View Data Source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tests.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
        if let testCell = cell as? TestTableViewCell {
            testCell.test = tests[indexPath.row]
            testCell.delegate = self
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedIndex = indexPath.row
        performSegueWithIdentifier("goToEditTest", sender: self)
    }
    
    /// MARK: -
    /// MARK: Actions
    
    @IBAction func didTapCreateTest() {
        AnimatingViewController.showInController(self, status: "Preparing domain..")
        
        let test = ParseDomain(className: ParseDomain.parseClassName())
        let user = ParseUser.currentUser()!
        test.owner = user
        
        AnimatingViewController.setStatus("Creating new test")
        test.saveInBackgroundWithBlock { (sucess, error) in
            AnimatingViewController.setStatus("Saving changes")
            user.saveInBackgroundWithBlock { (success, error) in
                AnimatingViewController.hide()
                print("user saved \(success)")
                test.owner = user
                
                // Proceed
                let idx = self.tests.count
                self.selectedIndex = idx
                self.tests.append(test)
                self.tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: idx, inSection: 0)], withRowAnimation: .Automatic)
                self.performSegueWithIdentifier("goToEditTest", sender: self)
            }
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let identifier = segue.identifier {
            switch identifier {
            case "goToEditTest":
                if let idx = selectedIndex,
                    let destination = segue.destinationViewController as? TestTableViewController {
                    destination.test = tests[idx]
                }
            case "goToCreateSimulation":
//                break;
                if let cell = sender as? TestTableViewCell,
                    test = cell.test,
                    let destination = segue.destinationViewController as? CreateSimulationTableViewController {
                    destination.domain = test
                }
            default:
                break
            }
        }
        
        if let identifier = segue.identifier,
            let idx = selectedIndex,
            let destination = segue.destinationViewController as? TestTableViewController where identifier == "goToEditTest" {
            destination.test = tests[idx]
        }
    }
    
    /// MARK: -
    /// MARK: TestQuestionTableViewCellDelegate
    
    func testCellDidSelectCreateTest(cell: UITableViewCell) {
        performSegueWithIdentifier("goToCreateSimulation", sender: cell)
    }

}
