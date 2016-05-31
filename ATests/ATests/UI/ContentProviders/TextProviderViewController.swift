//
//  TextProviderViewController.swift
//  ATests
//
//  Created by Radu Costea on 20/05/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit

class TextProviderViewController: UIViewController, ContentProvider, UITextViewDelegate {
    @IBOutlet var keyboardPlaceholderHeightConstraint: NSLayoutConstraint!
    @IBOutlet var textView: UITextView!
    weak var delegate: ContentProviderDelegate?
   
    var content: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        textView.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        registerForKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unregisterFromKeyboardNotifications()
    }
    
    static func textProvider(text: String?) -> TextProviderViewController? {
        let provider = UIStoryboard(name: "ContentProvidersStoryboard", bundle: nil).instantiateViewControllerWithIdentifier("textProvider") as? TextProviderViewController
        provider?.loadWith(text)
        return provider
    }
    
    /// MARK: -
    /// MARK: Keyboard related
    private var keyboardObserver: NSObjectProtocol?
    
    func registerForKeyboardNotifications() -> Void {
        keyboardObserver = NSNotificationCenter.defaultCenter().addObserverForName(UIKeyboardWillChangeFrameNotification, object: nil, queue: nil) { [unowned self] (notif) -> Void in
            self.keyboardWillChangeFrameWith(notif.userInfo)
        }
    }
    
    func unregisterFromKeyboardNotifications() -> Void {
        if let observer = keyboardObserver {
            NSNotificationCenter.defaultCenter().removeObserver(observer)
        }
    }
    
    func keyboardWillChangeFrameWith(infoDict: [NSObject: AnyObject]?) -> Void {
        guard let info = infoDict else {
            return
        }
        let finalFrame = info[UIKeyboardFrameEndUserInfoKey]?.CGRectValue ?? CGRectZero
        let viewFrame = self.view.convertRect(self.view.bounds, toView: nil) ?? CGRectZero
        let intersection = CGRectIntersection(viewFrame, finalFrame)
        if intersection.size.height != self.keyboardPlaceholderHeightConstraint.constant {
            let curve = infoDict?[UIKeyboardAnimationCurveUserInfoKey]?.integerValue ?? 0
            let option = UIViewAnimationOptions(rawValue: UInt(curve) << 16)
            let duration = info[UIKeyboardAnimationDurationUserInfoKey]?.timeInterval ?? 0.0
            UIView.animateWithDuration(duration, delay: 0.0, options: option, animations: { [unowned self] _ in
                self.keyboardPlaceholderHeightConstraint.constant = intersection.size.height
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    /// MARK: -
    /// MARK: UITextView Delegate 

    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        if content == nil {
            textView.text = ""
            return true
        }
        return true
    }
    
    /// MARK: -
    /// MARK: Content Provider
    
    func loadWith(content: String?) {
        self.content = content
        if let txtView = self.textView {
            txtView.text = (content ?? "")
        }
    }
    
    /// MARK: -
    /// MARK: Actions
    
    @IBAction func done() {
        content = textView.text
        delegate?.contentProvider(self, finishedLoadingWith: content)
    }
    
    @IBAction func clear() {
        textView.text = ""
    }

}
