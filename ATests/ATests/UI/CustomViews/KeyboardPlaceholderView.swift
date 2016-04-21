//
//  KeyboardPlaceholderView.swift
//  ATests
//
//  Created by Radu Costea on 19/04/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit

class KeyboardPlaceholderView: UIView {
    var heightConstraint: NSLayoutConstraint!
    
    private func setup() {
        heightConstraint = heightAnchor.constraintEqualToConstant(0.0)
        heightConstraint.priority = 900
        heightConstraint.active = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    deinit {
        if let observer = keyboardObserver {
            notificationCenter.removeObserver(observer)
        }
    }
    
    var keyboardObserver: NSObjectProtocol?
    lazy var notificationCenter = NSNotificationCenter.defaultCenter()
    
    override func didMoveToWindow() {
        if let _ = window {
            let callback = { [unowned self] (notification: NSNotification) in
                let duration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey]?.doubleValue ?? 0.0
                let option: UInt = notification.userInfo?[UIKeyboardAnimationCurveUserInfoKey]?.unsignedIntegerValue ?? 0
                var value: CGFloat = 0.0
                
                if let keyboardFrame = notification.userInfo?[UIKeyboardFrameEndUserInfoKey]?.CGRectValue(), let keyboardFrameToSuperview = self.superview?.convertRect(keyboardFrame, fromView: nil) {
                    let minY = CGRectGetMinY(keyboardFrameToSuperview)
                    let maxY = CGRectGetMaxY(self.frame)
                    if minY < maxY {
                        value = maxY - minY
                    }
                }
                
                UIView.animateWithDuration(duration, delay: 0.0, options: UIViewAnimationOptions(rawValue: option) as UIViewAnimationOptions, animations: { [unowned self] in
                    self.heightConstraint.constant = value
                    self.superview?.layoutIfNeeded()
                    }, completion: nil)
            }
            keyboardObserver = notificationCenter.addObserverForName(UIKeyboardWillChangeFrameNotification, object: nil, queue: nil, usingBlock: callback)
        } else if let observer = keyboardObserver {
            notificationCenter.removeObserver(observer)
        }
    }
}
