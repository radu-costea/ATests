//
//  JoinViewController.swift
//  ATests
//
//  Created by Radu Costea on 19/06/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit
import Parse

class JoinViewController: UIViewController {
    @IBOutlet var textField: UITextField!
    var exam: ParseClientExam?
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }

    /// MARK: -
    /// MARK: Actions
    
    @IBAction func didTapJoin(sender: AnyObject?) {
        // Find exam
        let id = textField.text ?? "A7E2383D-8896-477F-9262-99211338203B"
        let query = PFQuery(className: "ParseExam", predicate: NSPredicate(format: "joinId = \"\(id)\" AND state = \(ParseExamState.WaitingForClients.rawValue)"))
        
        AnimatingViewController.showInController(self, status: "Pairing..")
        query.getFirstObjectInBackgroundWithBlock { (exam, error) in
            guard let parseExam = exam as? ParseExam else {
                AnimatingViewController.setStatus("An error occured while trying to join: \(error?.localizedDescription)")
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(2.0 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), {
                    AnimatingViewController.hide()
                })
                return
            }
            self.createClientExam(parseExam)
        }
    }
    
    func createClientExam(exam: ParseExam) -> Void {
        guard let questions = exam.questions,
            let user = ParseUser.currentUser() else {
            AnimatingViewController.hide()
            return
        }
        
        var task = BFTask(result:nil)
        let max = questions.count + 1
        var current = 0.0
        questions.forEach { (question) in
            task = task.continueWithBlock({ _ -> AnyObject? in
                current = current + 0.5
                self.updateStatusProgress(current / Double(max))
                return question.fetchInBackground()
            }).continueWithBlock( { _ -> AnyObject? in
                current = current + 0.5
                self.updateStatusProgress(current / Double(max))
                return question.answer?.fetchInBackground()
            })
        }
        
        task.continueWithBlock ({ (t) -> AnyObject? in
            current = current + 0.5
            self.updateStatusProgress(current / Double(max))
            let newAnswers = questions.flatMap{ ParseExamAnswer(question: $0, answer: $0.answer?.cleanCopyObject()) }

            let clientExam = ParseClientExam()
            clientExam.answers = newAnswers
            clientExam.owner = user
            clientExam.source = exam
            self.exam = clientExam
            return clientExam.saveInBackground()
        }).continueWithBlock { (t) -> AnyObject? in
            current = current + 0.5
            self.updateStatusProgress(current / Double(max))
            if t.completed {
                dispatch_async(dispatch_get_main_queue(), {
                    AnimatingViewController.hide({
                        self.performSegueWithIdentifier("startExam", sender: nil)
                    })
                })
            }
            return nil
        }
    }
    
    func updateStatusProgress(progress: Double) {
        dispatch_async(dispatch_get_main_queue(), { AnimatingViewController.setStatus(NSString(format:"Preparing .. %00.2f%", progress * 100) as String) })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "startExam":
                let examController = segue.destinationViewController as! TakeExamViewController
                examController.exam = self.exam
            default:
                break
            }
        }
    }
}
