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

        // Do any additional setup after loading the view.
        print("received user: \(user)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
