//
//  QuizWaitingViewController.swift
//  ATests
//
//  Created by Radu Costea on 15/06/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit
import MessageUI
import Parse

class QuizWaitingViewController: UIViewController, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet var joinIdField: UITextField!
    @IBOutlet var connected: ConnectedUsersController?
    
    var quizz: ParseExam?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("user: \(ParseUser.currentUser()?.objectId), join id: \(quizz?.joinId)")

        // Do any additional setup after loading the view.
        joinIdField.text = quizz?.joinId
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        quizz?.state = .WaitingForClients
        
        AnimatingViewController.showInController(self, status: "Preparing...")
        quizz?.saveInBackgroundWithBlock({ (success, err) in
            AnimatingViewController.hide()
        })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier where identifier == "embedController" {
            self.connected = segue.destinationViewController as? ConnectedUsersController
            self.connected?.exam = quizz
        }
    }
    
    /// MARK: -
    /// MARK: Actions
    
    @IBAction func shaareButtonPressed(sender: AnyObject?) -> Void {
        UIAlertController.showIn(self,
            title: "Share exam",
            message: "Select sharing method",
            actions: [
                (
                    title: "E-mail",
                    action: { _ in
                        let composer = MFMailComposeViewController()
                        let signed = /*Encryption.SHA256.sign(*/self.quizz?.joinId ?? ""/*, key: "Cei mai bravi fii a getodacilor 2016")*/
                        let url = "quizapp://test?testId=\(signed ?? "")&userId=\(ParseUser.currentUser()?.objectId ?? "")"
                        
                        composer.setMessageBody("You have been invited to take a test. Please use the following code to access it: <a href=\"\(url)\">Test</a>", isHTML: true)
                        composer.setSubject("New exam invitation")
                        composer.mailComposeDelegate = self
                        self.presentViewController(composer, animated: true, completion: nil)
                    }
                ),
                (
                    title: "Sms",
                    action: { _ in
                        let smsComposer = MFMessageComposeViewController()
                        let signed = /*Encryption.SHA256.sign(*/self.quizz?.joinId ?? ""/*, key: "Cei mai bravi fii a getodacilor 2016")*/
                        
                        let url = "quizapp://test?testId=\(signed ?? "")&userId=\(ParseUser.currentUser()?.objectId ?? "")"
                        smsComposer.body = "You have been invited to take a test. Please use the following code to access it: \(url)"
                        smsComposer.subject = "New exam invitation"
                        smsComposer.messageComposeDelegate = self
                        self.presentViewController(smsComposer, animated: true, completion: nil)
                    }
                )
            ],
            cancelAction: (title: "Cancel", action: nil)
        )
    }
    
    /// MARK: -
    /// MARK: Delegate

    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
}
