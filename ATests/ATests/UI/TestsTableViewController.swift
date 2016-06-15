//
//  TestsTableViewController.swift
//  ATests
//
//  Created by Radu Costea on 11/06/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit

class TestsTableViewController: UITableViewController, TestTableViewCellDelegate {
    var tests: [LiteTest] = []
    var selectedIndex: Int?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        do {
            tests = try LiteTest.all().flatMap{ $0 as? LiteTest }
        } catch {}
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let idx = selectedIndex {
            tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: idx, inSection: 0)], withRowAnimation: .Automatic)
        }
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tests.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! TestTableViewCell
        cell.test = tests[indexPath.row]
        cell.delegate = self
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedIndex = indexPath.row
        performSegueWithIdentifier("goToEditTest", sender: self)
    }
    
    /// MARK: -
    /// MARK: Actions
    
    @IBAction func didTapCreateTest() {
        if let test = LiteTest(with: ["title" : "New Test"]) {
            selectedIndex = tests.count
            tests.append(test)
            tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: selectedIndex!, inSection: 0)], withRowAnimation: .Automatic)
            test.tryPersit()
            performSegueWithIdentifier("goToEditTest", sender: self)
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
                    let destination = segue.destinationViewController as? TestTableViewController{
                    destination.test = tests[idx]
                }
            case "goToCreateSimulation":
                if let cell = sender as? TestTableViewCell,
                    let destination = segue.destinationViewController as? CreateSimulationTableViewController {
                    destination.test = cell.test
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
    
    func testCellDidSelectCreateTest(cell: TestTableViewCell) {
        performSegueWithIdentifier("goToCreateSimulation", sender: cell)
    }

}
