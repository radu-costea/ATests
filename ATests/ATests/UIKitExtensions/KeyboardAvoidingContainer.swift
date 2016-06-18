//
//  UIScrollView-Extensions.swift
//  ATests
//
//  Created by Radu Costea on 08/04/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation
import UIKit
import Parse
protocol KeyboardAvoidingContainer: AnyObject {
    var insetsOffset: Float { get set }
    var observer: NSObjectProtocol? { get set }
    var adjustScrollerInsetsForNotification: (notification: NSNotification) -> Void { get }
    
    func startListeningForKeyboardNotifications() -> Void
    func stopListeningForKeyboardNotifications() -> Void
}

extension KeyboardAvoidingContainer {
    func startListeningForKeyboardNotifications() -> Void {
        observer = NSNotificationCenter.defaultCenter().addObserverForName(UIKeyboardWillChangeFrameNotification, object: nil, queue: NSOperationQueue.mainQueue(), usingBlock: adjustScrollerInsetsForNotification)
    }
    
    func stopListeningForKeyboardNotifications() -> Void {
        guard let addedObserver = observer else {
            return
        }
        NSNotificationCenter.defaultCenter().removeObserver(addedObserver, name: UIKeyboardWillChangeFrameNotification, object: nil)
        observer = nil
    }
}

class ScrollViewKeyboardAvoider: KeyboardAvoidingContainer {
    unowned var scrollView: UIScrollView
    var observer: NSObjectProtocol?
    var insetsOffset: Float = 0.0
    
    init(scrollView: UIScrollView) {
        self.scrollView = scrollView
    }
    
    deinit {
        self.stopListeningForKeyboardNotifications()
    }
    
    lazy var adjustScrollerInsetsForNotification: (notification: NSNotification) -> Void = { [unowned self] notification in
        guard let info = notification.userInfo else {
            return
        }
        
        let finalFrame = info[UIKeyboardFrameEndUserInfoKey]?.CGRectValue ?? CGRectZero
        let scrollViewFrame = self.scrollView.superview?.convertRect(self.scrollView.frame, toView: nil) ?? CGRectZero
        let intersection = CGRectIntersection(scrollViewFrame, finalFrame)
        
        var scrollerInsets = self.scrollView.scrollIndicatorInsets
        var contentInsets = self.scrollView.contentInset
        
        scrollerInsets.bottom -= CGFloat(self.insetsOffset)
        contentInsets.bottom -= CGFloat(self.insetsOffset)
        
        self.insetsOffset = Float(intersection.height)
        scrollerInsets.bottom += CGFloat(self.insetsOffset)
        contentInsets.bottom += CGFloat(self.insetsOffset)
        
        let curve = notification.userInfo?[UIKeyboardAnimationCurveUserInfoKey]?.integerValue ?? 0
        let option = UIViewAnimationOptions(rawValue: UInt(curve) << 16)
        
        let duration = info[UIKeyboardAnimationDurationUserInfoKey]?.floatValue ?? 0.0
        
        let animationBlock = { [unowned self] in
            self.scrollView.contentInset = contentInsets
            self.scrollView.scrollIndicatorInsets = scrollerInsets
        }
        
        UIView.animateWithDuration(NSTimeInterval(duration), delay: 0.0, options: option, animations: animationBlock) { _ in animationBlock() }
    }
}