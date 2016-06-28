//
//  ConnectedUsersController.swift
//  ATests
//
//  Created by Radu Costea on 28/06/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit
import Parse

class ConnectedUsersController: UITableViewController {
    var exam: ParseExam?
    var connected: [ParseClientExam] = []
    weak var timer: NSTimer?

    override func viewDidLoad() {
        super.viewDidLoad()
        refresh(nil)
    }

    deinit {
        timer?.invalidate()
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return connected.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("exam", forIndexPath: indexPath)

        cell.textLabel?.text = "\(connected[indexPath.row].displayName ?? "")"
        cell.detailTextLabel?.text = "\(connected[indexPath.row].grade)"

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */
    
    func refresh(timer: NSTimer?) -> Void {
        var query = PFQuery(className: "ParseClientExam")
        query = query.whereKey("source", equalTo: exam!)
//        query = query.whereKeyDoesNotExist("endDate")
//        query = query.whereKey("startDate", greaterThan: NSDate().dateByAddingTimeInterval(Double(-exam!.duration)))
        query.findObjectsInBackgroundWithBlock { [weak self] (exams, err) in
            guard let wSelf = self else {
                return
            }
            
            if let ex = exams?.flatMap({ $0 as? ParseClientExam }) {
                self?.connected = ex
                print("connected: \(self?.connected)")
                self?.tableView.reloadData()
            }
            
            wSelf.timer = NSTimer.scheduledTimerWithTimeInterval(10, target: wSelf, selector: #selector(ConnectedUsersController.refresh(_:)), userInfo: nil, repeats: false)
        }
    }

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
