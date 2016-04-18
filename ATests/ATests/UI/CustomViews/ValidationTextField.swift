//
//  ValidationTextField.swift
//  ATests
//
//  Created by Radu Costea on 11/04/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation
import UIKit

protocol ValidationTextFieldDelegate: class {
    func validationFieldTextDidChanged(validationField: ValidationTextField)
    func validationFieldTextDidEndEditing(validationField: ValidationTextField)
    func validationFieldTextDidBeginEditing(validationField: ValidationTextField)
}

class ValidationTextField: UIStackView, UITextFieldDelegate {
    @IBOutlet var textField: UITextField!
    @IBOutlet var validationIcon: UIImageView!
    weak var delegate: ValidationTextFieldDelegate?
    
    // MARK: - Getters & Setters
    
    var text: String? {
        set { self.textField.text = newValue }
        get { return self.textField.text }
    }
    
    override func didMoveToWindow() {
        guard let _ = window else {
            unregisterNotifications()
            return
        }
        registerNotifications()
    }
    
    deinit {
        self.unregisterNotifications()
    }
    
    // MARK: - Notifications
    
    lazy var notificationCenter = NSNotificationCenter.defaultCenter()
    lazy var notificationCallbacks: [String: (NSNotification) -> ()] = [
        UITextFieldTextDidChangeNotification: { [unowned self] _ in self.delegate?.validationFieldTextDidChanged(self) },
        UITextFieldTextDidBeginEditingNotification: { [unowned self] _ in  self.delegate?.validationFieldTextDidBeginEditing(self) },
        UITextFieldTextDidEndEditingNotification: { [unowned self] _ in self.delegate?.validationFieldTextDidEndEditing(self) }
    ]
    
    var observers: [String: NSObjectProtocol] = [:]

    func registerNotifications() -> Void {
        unregisterNotifications()
        observers = notificationCallbacks.reduce([String: NSObjectProtocol]()) {
            $0.join([$1.0: notificationCenter.addObserverForName($1.0, object: textField, queue: nil, usingBlock: $1.1)])
        }
    }
    
    func unregisterNotifications() -> Void {
        observers.forEach { notificationCenter.removeObserver($0.1) }
        observers = [:]
    }
    
    // MARK: - Validation icon visibility
    
    func setValidationIconVisible(visible: Bool) -> Void {
        let isVisible = !visible
        UIView.animateWithDuration(0.25, animations: { 
            self.validationIcon.hidden = isVisible
            self.layoutIfNeeded()
            }) { _ in
                self.validationIcon.hidden = isVisible
        }
    }
    
    // MARK: - Text validation
    
    func setTextIsValid(valid: Bool) -> Void {
        if (valid) {
            showSuccessIcon()
        } else {
            showErrorIcon()
        }
    }
    
    func showErrorIcon() -> Void {
        self.validationIcon.backgroundColor = UIColor.redColor()
    }
    
    func showSuccessIcon() -> Void {
        self.validationIcon.backgroundColor = UIColor.greenColor()
    }
}
