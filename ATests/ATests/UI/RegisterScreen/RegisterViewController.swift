//
//  RegisterViewController.swift
//  ATests
//
//  Created by Radu Costea on 11/04/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit

class RegisterViewController: ValidationFormViewController {
    lazy var emailVM: FieldValidationViewModel = ValidationFieldViewModel(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}")
    lazy var firstNameVM: FieldValidationViewModel = WordLengthValidationFieldViewModel(length: 1)
    lazy var lastNameVM: FieldValidationViewModel = WordLengthValidationFieldViewModel(length: 1)
    lazy var passwordVM: FieldValidationViewModel = WordLengthValidationFieldViewModel(length: 6)
    lazy var passwordCheckVM: FieldValidationViewModel = BlockValidationFieldViewModel() { [unowned self] model in
        return (self.passwordVM.isValid && self.passwordVM.text == model.text)
    }
    
    // MARK: - Outlets
    
    @IBOutlet var firstNameField: ValidationTextField!
    @IBOutlet var lastNameField: ValidationTextField!
    @IBOutlet var passwordField: ValidationTextField!
    @IBOutlet var retypePasswordField: ValidationTextField!
    @IBOutlet var emailField: ValidationTextField!
    @IBOutlet var registerButton: UIButton!

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        firstNameField.delegate = self
        lastNameField.delegate = self
        passwordField.delegate = self
        retypePasswordField.delegate = self
        emailField.delegate = self
    }

    // MARK: - Overrides
    
    override func createBindings() -> [ValidationTextField : FieldValidationViewModel] {
        return [
            self.firstNameField : self.firstNameVM,
            self.lastNameField : self.lastNameVM,
            self.passwordField : self.passwordVM,
            self.retypePasswordField : self.passwordCheckVM,
            self.emailField : self.emailVM
        ]
    }
    
    override func createViewModels() -> [FieldValidationViewModel] {
        return [
            self.firstNameVM,
            self.lastNameVM,
            self.passwordVM,
            self.passwordCheckVM,
            self.emailVM
        ]
    }
    
    override func validationFieldTextDidChanged(validationField: ValidationTextField) {
        super.validationFieldTextDidChanged(validationField)
        registerButton.enabled = formIsValid
    }
    
    // MARK: - Actions
    
    @IBAction func register(sender: UIButton?) -> Void {
        if User.count(with: "email ==\"\(emailVM.text!)\"") == 0 {
            if let user = User.new([
                "email" : emailVM.text!,
                "password" : passwordVM.text!,
                "firstName" : firstNameVM.text!,
                "lastName" : lastNameVM.text!
                ]) as? User {
                user.tryPersit()
                performSegueWithIdentifier("toMyAccount", sender: nil)
            }
        }
    }
}
