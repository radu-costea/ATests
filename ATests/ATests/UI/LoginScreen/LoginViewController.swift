//
//  LoginViewController.swift
//  ATests
//
//  Created by Radu Costea on 11/04/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: ValidationFormViewController {
    lazy var passwordVM: FieldValidationViewModel = WordLengthValidationFieldViewModel(length: 6)
    lazy var emailVM: FieldValidationViewModel = ValidationFieldViewModel(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}")
    var user: ParseUser?
    
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var passwordField: ValidationTextField!
    @IBOutlet var emailField: ValidationTextField!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var avatarContainer: UIView!
    let defaults = NSUserDefaults.standardUserDefaults()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        passwordField.delegate = self
        emailField.delegate = self
        
        if let email = defaults.stringForKey("username") {
            let keychain = KeychainItemWrapper(identifier: email)
            if let password = keychain["password"] as? String {
                emailField.text = email
                passwordField.text = password
                
                validationFieldTextDidChanged(emailField)
                validationFieldTextDidChanged(passwordField)
            }
        }
    }
    
    // MARK: - Overrides
    override func createBindings() -> [ValidationTextField: FieldValidationViewModel] {
        return [
            self.passwordField : self.passwordVM,
            self.emailField : self.emailVM
        ]
    }
    
    override func createViewModels() -> [FieldValidationViewModel] {
        return [self.passwordVM, self.emailVM]
    }
    
    override func validationFieldTextDidChanged(validationField: ValidationTextField) {
        super.validationFieldTextDidChanged(validationField)
        loginButton.enabled = formIsValid
    }
    
    // MARK: - Actions
    
    @IBAction func login(sender: UIButton?) {
        self.view.endEditing(true)
        
        if let _ = self.user {
            logout()
            return
        }
        
        guard   let email = emailVM.text,
                let password = passwordVM.text else {
            return
        }
        
        AnimatingViewController.showInController(self, status: "Logging in ..")
        
        ParseUser.logInWithUsernameInBackground(email, password: password) { [unowned self] currentUser, error in
            if let usr = currentUser as? ParseUser {
                self.loginSuccedeedWithUser(usr)
                self.defaults.setObject(email, forKey: "username")
                self.defaults.synchronize()
                
                let keychain = KeychainItemWrapper(identifier: email)
                keychain["password"] = password

                return
            }
            self.loginEncounteredAnError(error!)
        }
    }
    
    func logout() -> Void {
        AnimatingViewController.showInController(self, status: "Logging out ..")
        ParseUser.logOutInBackgroundWithBlock{ err in
            AnimatingViewController.hide {
                self.emailField.textField.enabled = true
                self.passwordField.textField.enabled = true
                self.loginButton.setTitle("Log in", forState: .Normal)
                self.user = nil
            }
        }
    }
    
    // MARK: - Helper methods
    
    func loginSuccedeedWithUser(user: ParseUser) {
        self.user = user
        let completion: (UIImage?) -> Void = { [unowned self] image in
            AnimatingViewController.hide{ self.animateAvatarAndProceed(image) }
        }
        
        if let avatar = user.avatar {
            avatar.getImageInBackgroundWithBlock { (img, err) in completion(img) }
        } else {
            completion(nil)
        }
    }
    
    func animateAvatarAndProceed(image: UIImage?) {
        emailField.textField.enabled = false
        passwordField.textField.enabled = false
        loginButton.setTitle("Log out", forState: .Normal)
        
        guard let img = image else {
            self.performSegueWithIdentifier("toMyAccount", sender: nil)
            return
        }
        
        UIView.animateWithDuration(0.5,
            animations: { [unowned self] _ in
                self.avatarContainer.hidden = false
                self.imageView.image = img
                self.view.layoutIfNeeded()
            }
        ){ success in
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1.0 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), {
                self.performSegueWithIdentifier("toMyAccount", sender: nil)
            })
        }
    }
    
    
    func loginEncounteredAnError(error: NSError) {
        AnimatingViewController.hide { [unowned self] in
            UIAlertController.showIn(self, message: "An error occured while trying to login: \(error.localizedDescription)", style: .Alert, actions: [], cancelAction: (title: "Ok", action: nil))
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
    
    @IBAction func unwindToLogin(segue: UIStoryboardSegue) -> Void {
        if let source = segue.sourceViewController as? RegisterViewController {
            // Back from register
            user = source.user
            emailField.text = user?.username
            passwordField.text = user?.password
            dispatch_async(dispatch_get_main_queue(), { 
                self.animateAvatarAndProceed(source.image)
            })
        }
    }
}
