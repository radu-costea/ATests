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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        passwordField.delegate = self
        emailField.delegate = self
        
        emailField.text = "radu.costea@mail.com"
        passwordField.text = "password"
        
        validationFieldTextDidChanged(emailField)
        validationFieldTextDidChanged(passwordField)
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
        self.view.endEditing(true)
        AnimatingViewController.showInController(self, status: "Logging in ..")
        ParseUser.logInWithUsernameInBackground(emailVM.text!, password: passwordVM.text!) { [unowned self] currentUser, error in
            if let usr = currentUser as? ParseUser {
                self.loginSuccedeedWithUser(usr)
                return
            }
            self.loginEncounteredAnError(error!)
        }
    }
    
    func loginSuccedeedWithUser(user: ParseUser) {
        self.user = user
        
        if let avatar = self.user?.avatar {
            avatar.getImageInBackgroundWithBlock{ [unowned self] (image, error) in
                AnimatingViewController.hide()
                self.animateAvatarAndProceed(image)
            }
            return
        }
        
        AnimatingViewController.hide()
        animateAvatarAndProceed(nil)
    }
    
    func animateAvatarAndProceed(image: UIImage?) {
        guard let img = image else {
            self.performSegueWithIdentifier("toMyAccount", sender: nil)
            return
        }

        UIView.animateWithDuration(0.5,
        animations: { [unowned self] _ in
            self.avatarContainer.hidden = false
            self.imageView.image = img
            self.view.layoutIfNeeded()
        },
        completion: { success in
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1.0 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), {
                self.performSegueWithIdentifier("toMyAccount", sender: nil)
            })
        })
    }
    
    
    func loginEncounteredAnError(error: NSError) {
        AnimatingViewController.hide()
        UIAlertController.showIn(self, message: "An error occured while trying to login: \(error.localizedDescription)", style: .Alert, actions: [], cancelAction: (title: "Ok", action: nil))
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
