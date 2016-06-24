//
//  QuizWaitingViewController.swift
//  ATests
//
//  Created by Radu Costea on 15/06/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit
import Parse
class QuizWaitingViewController: UIViewController {
    @IBOutlet var joinIdField: UITextField!
    
    var quizz: ParseExam?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("user: \(ParseUser.currentUser()?.objectId), join id: \(quizz?.joinId)")

        // Do any additional setup after loading the view.
        joinIdField.text = quizz?.joinId
       
        

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        quizz?.state = .WaitingForClients
        
        AnimatingViewController.showInController(self, status: "Preparing...")
        quizz?.saveInBackgroundWithBlock({ (success, err) in
            AnimatingViewController.hide()
        })
    }

}
