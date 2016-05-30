//
//  EditAnswerViewController.swift
//  ATests
//
//  Created by Radu Costea on 30/05/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit

class EditAnswerViewController: ContainedViewController {
    typealias ContentType = RawContent
    @IBOutlet var stackView: UIStackView!
    var answer: VariantsAnswerObject!
    var variants: [ContentType] = []
    
    override class var storyboardName: String { return "EditQuestionStoryboard" }
    override class var storyboardId: String { return "editAnswer" }
    
    var controllers: [EditRawContentController] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func addVariant(variant: ContentType) {
        let v = variant
        let controller = EditContentFabric.editController(v)
        
        stackView.addArrangedSubview(controller.view)
        stackView.insertArrangedSubview(controller.view, atIndex: controllers.count)
        controller.didMoveToParentViewController(self)
        controller.presenter = self

        variants.append(variant)
        controllers.append(controller)
    }
    
    @IBAction func didTapAddAnswer(sender: AnyObject?) {
        let text = NSUUID().UUIDString
        addVariant(text)
    }
}

