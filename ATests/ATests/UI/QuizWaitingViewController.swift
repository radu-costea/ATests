//
//  QuizWaitingViewController.swift
//  ATests
//
//  Created by Radu Costea on 15/06/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit

class QuizWaitingViewController: UIViewController {
    @IBOutlet var joinIdField: UITextField!
    
    var quiz: LiteSimulationTest?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        joinIdField.text = quiz?.joinId
    }

}
