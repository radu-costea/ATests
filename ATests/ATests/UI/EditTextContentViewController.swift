//
//  EditTextContentViewController.swift
//  ATests
//
//  Created by Radu Costea on 29/05/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit

class EditTextContentViewController: EditContentController, ContentProviderDelegate {
    var content: LiteTextContent?
    var text: String?
    var contentProvider: TextProviderViewController!

    @IBOutlet var textView: UILabel!
    @IBOutlet var errorView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        contentProvider = TextProviderViewController.textProvider(nil)
        contentProvider.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        loadText()
        let contentValid = content?.isValid() ?? false
        errorView.hidden = contentValid
        textView.hidden = !contentValid
    }
    
    func loadText() {
        if let txt = content?.text {
            text = txt
            contentProvider?.loadWith(txt)
            textView?.text = txt
        }
    }
    
    override func loadWith<T : LiteContent>(content: T?) {
        if let txt = content as? LiteTextContent {
            self.content = txt
            loadText()
        }
    }
    
    /// MARK: -
    /// MARK: Class
    
    override static var storyboardName: String { return "EditQuestionStoryboard" }
    override static var storyboardId: String { return "editText" }
    
    /// MARK: -
    /// MARK: Actions
    
    @IBAction func didTapOnContent(sender: AnyObject?) {
        startEditing()
    }
    
    override func startEditing() {
        presentViewController(self.contentProvider, animated: true, completion: nil)
    }
    
    /// MARK: -
    /// MARK: Conten Provider Delegate
    
    func contentProvider<Provider: ContentProvider>(provider: Provider, finishedLoadingWith content: Provider.ContentType?) -> Void {
        if let currentProvider = provider as? TextProviderViewController,
            let txt = content as? String {
                textView.text = txt
                self.content?.text = txt
                currentProvider.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
                self.errorView.hidden = self.content?.isValid() ?? false
        }
    }
}

extension EditContentFabric {
    class func textController(text: LiteTextContent?) -> EditTextContentViewController? {
        return EditTextContentViewController.editController(text) as? EditTextContentViewController
    }
}
