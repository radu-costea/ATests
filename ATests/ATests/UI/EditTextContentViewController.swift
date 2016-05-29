//
//  EditTextContentViewController.swift
//  ATests
//
//  Created by Radu Costea on 29/05/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit

class EditTextContentViewController: UIViewController, ContentProviderDelegate, ContainedController {
    var textObject: TextContentObject?
    var text: String?
    var contentProvider: TextProviderViewController!
    
    weak var presenter: UIViewController?
    @IBOutlet var textView: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        contentProvider = TextProviderViewController.textProvider(nil)
        contentProvider.delegate = self
    }
    
    func loadText() {
        if let txt = textObject?.text {
            text = txt
            contentProvider.loadWith(txt)
        }
    }
    
    static func editContentController() -> EditTextContentViewController? {
        return UIStoryboard(name: "EditQuestionStoryboard", bundle: nil).instantiateViewControllerWithIdentifier("editText") as? EditTextContentViewController
    }
    
    /// MARK: -
    /// MARK: Actions
    
    @IBAction func didTapOnContent(sender: AnyObject?) {
        presenter?.presentViewController(self.contentProvider, animated: true, completion: nil)
    }
    
    /// MARK: -
    /// MARK: Conten Provider Delegate
    
    func contentProvider<Provider: ContentProvider>(provider: Provider, finishedLoadingWith content: Provider.ContentType?) -> Void {
        if let currentProvider = provider as? TextProviderViewController,
            let txt = content as? String {
                currentProvider.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
                textView.text = txt
        }
    }

}
