//
//  EditQuestionViewController.swift
//  ATests
//
//  Created by Radu Costea on 27/05/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit

protocol ContainedController {
    var presenter: UIViewController? { get set }
}

class EditQuestionViewController: UIViewController {
    @IBOutlet var stackView: UIStackView!
    @IBOutlet var questionContentView: UIView!
    @IBOutlet var questionAnswerView: UIView!
    
    var editContentController: EditRawContentController!
    var editTextController: ContainedViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        editContentController = EditContentFabric.imageController(nil)
        addEditController(editContentController, toView: questionContentView)
        
        editTextController = EditAnswerViewController.controller()
        addEditController(editTextController, toView: questionAnswerView)
    }
    
    func addEditController<T: ContainedController where T: UIViewController>(var controller: T, toView view: UIView) {
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        controller.presenter = self
        
        view.addSubview(controller.view)
        controller.didMoveToParentViewController(self)
        
        NSLayoutConstraint.activateConstraints([
            controller.view.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor),
            controller.view.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor),
            controller.view.topAnchor.constraintEqualToAnchor(view.topAnchor),
            controller.view.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor)
        ])
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

}
