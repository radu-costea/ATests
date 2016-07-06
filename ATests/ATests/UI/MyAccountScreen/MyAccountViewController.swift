//
//  MyAccountViewController.swift
//  ATests
//
//  Created by Radu Costea on 12/04/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit
import Parse
class MyAccountViewController: UIViewController {
    var user: ParseUser!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if NSUserDefaults.standardUserDefaults().URLForKey("launchURL") != nil {
            performSegueWithIdentifier("goToExam", sender: nil)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier where identifier == "goToExam" {
            let join = segue.destinationViewController as! JoinViewController
            join.url = NSUserDefaults.standardUserDefaults().URLForKey("launchURL")
            NSUserDefaults.standardUserDefaults().removeObjectForKey("launchURL")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func backFromQuiz(segue: UIStoryboardSegue) -> Void { }
}
