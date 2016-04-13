//
//  LoginViewController.swift
//  ATests
//
//  Created by Radu Costea on 11/04/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit

class LoginViewController: ValidationFormViewController {
    lazy var passwordVM: FieldValidationViewModel = WordLengthValidationFieldViewModel(length: 6)
    lazy var emailVM: FieldValidationViewModel = ValidationFieldViewModel(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}")
    var user: User?
    
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var passwordField: ValidationTextField!
    @IBOutlet var emailField: ValidationTextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        passwordField.delegate = self
        emailField.delegate = self
    }
    
    // MARK: - Overrides
    override func createBindings() -> [ValidationTextField: FieldValidationViewModel] {
        return [
            self.passwordField : self.passwordVM,
            self.emailField : self.emailVM
        ]
    }
    
    override func createViewModels() -> [FieldValidationViewModel] {
        return [
            self.passwordVM,
            self.emailVM
        ]
    }
    
    override func validationFieldTextDidChanged(validationField: ValidationTextField) {
        super.validationFieldTextDidChanged(validationField)
        loginButton.enabled = formIsValid
    }
    
    // MARK: - Actions
    
    @IBAction func login(sender: UIButton?) {
        do {
            let encryptedPassword = passwordVM.text?.sign(with: .MD5, key: "MyAwsomePassword")
            if let usr = try User.find(with: "email == \"\(emailVM.text!)\" AND password == \"\(encryptedPassword!)\"") as? User {
                user = usr
                // do login
                print("found")
                performSegueWithIdentifier("toMyAccount", sender: nil)
            }
        } catch {
            print("exception")
        }
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toMyAccount" {
            let myAccountScreen = segue.destinationViewController as! MyAccountViewController
            myAccountScreen.user = user!
        }
    }
    
}
