//
//  EditTextContentViewController.swift
//  ATests
//
//  Created by Radu Costea on 29/05/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit
import Parse
class EditTextContentViewController: EditContentController, ContentProviderDelegate {
    var content:ParseTextContent?
    var text: String?
    var contentProvider: TextProviderViewController!
    
    override func getContent() -> PFObject? { return content }

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
        let contentValid = true;//content?.isValid() ?? false
        errorView.hidden = contentValid
        textView.hidden = !contentValid
    }
    
    func loadText() {
        content?.fetchIfNeededInBackgroundWithBlock({ (c, error) in
            if let txt = self.content?.text {
                UIView.animateWithDuration(0.3, animations: { 
                    self.text = txt
                    self.errorView?.hidden = txt.length > 0
                    self.contentProvider?.loadWith(txt)
                    self.textView?.text = txt
                })
            }
        })
    }
    
    override func loadWith(content: PFObject?) {
        if let txt = content as? ParseTextContent {
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
        if editingEnabled {
            presentViewController(self.contentProvider, animated: true, completion: nil)
        }
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
    class func textController(text:ParseTextContent?) -> EditTextContentViewController? {
        return EditTextContentViewController.editController(text) as? EditTextContentViewController
    }
}
