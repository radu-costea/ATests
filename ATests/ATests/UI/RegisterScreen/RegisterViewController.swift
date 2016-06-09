//
//  RegisterViewController.swift
//  ATests
//
//  Created by Radu Costea on 11/04/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//
import Foundation
import UIKit
import MobileCoreServices

protocol ImagePickerDelegate: UINavigationControllerDelegate, UIImagePickerControllerDelegate {}

class RegisterViewController: ValidationFormViewController, ImagePickerDelegate {
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
    @IBOutlet var avatarImageView: UIImageView!
    
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
    var image: UIImage?
    var user: User!
    
    @IBAction func register(sender: UIButton?) -> Void {
        guard User.count(with: "email ==\"\(emailVM.text!)\"") == 0 else {
            return
        }
        guard let password = passwordVM.text?.sign(with: .MD5, key: "MyAwsomePassword") else {
            return
        }
        let userInfo: [String: AnyObject] = [
            "email" : emailVM.text!,
            "password" : password,
            "firstName" : firstNameVM.text!,
            "lastName" : lastNameVM.text!,
            "avatar" : UserAvatar(with: image?.base64String.map{["base64String" : $0]} ?? [:])!
        ]
        
        guard let created = User(with: userInfo) else {
            return
        }
        user = created
        user.tryPersit()
        performSegueWithIdentifier("toMyAccount", sender: nil)
    }
    
    /// MARK: -
    /// MARK: Navigation
    
    override var navigationCallbacks: [String: (UIViewController) -> Void] {
        return [
            "toMyAccount" : { [unowned self] next in
                self.view.endEditing(true)
                let myAccountScreen = next as! MyAccountViewController
                myAccountScreen.user = self.user!
            }
        ]
    }
    
    /// MARK: -
    /// MARK: Actions
    
    @IBAction func loadImage(sender: UIButton?) -> Void {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .PhotoLibrary
        imagePicker.mediaTypes = [kUTTypeImage as String]
        imagePicker.delegate = self
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let img = info[UIImagePickerControllerOriginalImage] as? UIImage
        image = img
        avatarImageView.image = img
        picker.dismissViewControllerAnimated(true) { }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true) { }
    }
}
