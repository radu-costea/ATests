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
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var avatarContainer: UIView!

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
            self.view.endEditing(true)
            let encryptedPassword = passwordVM.text?.sign(with: .MD5, key: "MyAwsomePassword")
            if let usr = try User.find(with: "email == \"\(emailVM.text!)\" AND password == \"\(encryptedPassword!)\"") as? User {
                user = usr
                // do login
                self.view.endEditing(true)
                if let imgData = user?.avatar?.base64String?.toBase64Data() {
                    UIView.animateWithDuration(0.5, animations: { [unowned self] _ in
                        self.avatarContainer.hidden = false
                        self.imageView.image = UIImage(data: imgData)
                        self.view.layoutIfNeeded()
                    })
                }
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(2.0 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { [unowned self] _ in
                    self.performSegueWithIdentifier("toMyAccount", sender: nil)
                }
            }
        } catch {
            print("exception")
        }
    }
    
    // MARK: - Navigation
    
    override var navigationCallbacks: [String: (UIViewController) -> Void] {
        return [
            "toMyAccount" : { [unowned self] next in
                self.view.endEditing(true)
                let myAccountScreen = next as! MyAccountViewController
                myAccountScreen.user = self.user!
            }
        ]
    }
    
    @IBAction func unwindToLogin(segue: UIStoryboardSegue) -> Void { }
}
