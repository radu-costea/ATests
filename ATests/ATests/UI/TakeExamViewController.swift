//
//  TakeExamViewController.swift
//  ATests
//
//  Created by Radu Costea on 20/06/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit

class TakeExamViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    @IBOutlet var previousButton: UIButton!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var labelCurrentIdx: UILabel!
    
    weak var pagingViewController: UIPageViewController!
    var exam: ParseClientExam?
    var answers: [ParseExamAnswer] = []
    var currentIdx: Int?
    var current: EditQuestionViewController?
    var currentAnswer: ParseExamAnswer?
    
    var timeout: NSTimer?
    
    var seenOnce: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let allAnswers = exam?.answers where allAnswers.count > 0 {
            self.answers = allAnswers
        }
        
        if let dt = exam?.source.duration where dt > 0 {
            let elapsed = NSDate().timeIntervalSinceDate(exam?.startDate ?? NSDate())
            let remaining = Double(dt) - elapsed
            
            timeout = NSTimer.scheduledTimerWithTimeInterval(remaining, target: self, selector: #selector(TakeExamViewController.timedOut(_:)), userInfo: nil, repeats: false)
        }
    }
    
    deinit {
        timeout?.invalidate()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if !seenOnce {
            loadControllerForIdx(0)
            seenOnce = true
        }
    }
    
    func loadControllerForIdx(index: Int, direction: UIPageViewControllerNavigationDirection = .Forward, animated: Bool = false) -> Void {
        saveIfNeeded {
            guard 0..<self.answers.count ~= index else {
                return
            }
            
            self.currentIdx = index
            self.refreshIdx()
            let answer = self.answers[index]
            self.currentAnswer = answer
            if let controller = EditQuestionViewController.controller() {
                controller.editingEnabled = false
                controller.provideContentBlock = { _ in answer.question.content }
                controller.provideAnswerBlock = { _ in answer.answer }
                self.pagingViewController.setViewControllers([controller], direction: direction, animated: animated, completion: { success in
                    print("new controllers: \(self.pagingViewController.viewControllers) success \(success)")
                })
            }
        }
    }
    
    func refreshIdx() {
        guard let index = currentIdx else {
            previousButton.enabled = false
            nextButton.enabled = false
            labelCurrentIdx.text = ""
            return
        }
        
        self.previousButton.enabled = index > 0
        self.nextButton.enabled = index < (self.answers.count - 1)
        self.labelCurrentIdx.text = "\(index + 1) / \(answers.count)"
    }
    
    func saveIfNeeded(completion: () -> Void) {
        if let idx = currentIdx where answers[idx].dirty {
            AnimatingViewController.showInController(self, status: "Saving state")
            answers[idx].saveInBackgroundWithBlock( { (success, err) in
                self.exam?.saveInBackgroundWithBlock({ (success, err) in
                    AnimatingViewController.hide(completion)
                })
            })
        } else {
            completion()
        }
    }

    /// MARK: -
    /// MARK: Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let identifier = segue.identifier {
            switch identifier {
            case "embedSegue":
                let pageViewController = segue.destinationViewController as! UIPageViewController
                pageViewController.delegate = self
                pageViewController.dataSource = self
                self.pagingViewController = pageViewController
            default:
                break;
            }
        }
    }
    
    /// MARK: -
    /// MARK: Actions
    
    @IBAction func didTapNext(sender: AnyObject?) -> Void {
        validateAnswer(currentAnswer)
        loadControllerForIdx(currentIdx?.successor() ?? 0, direction: .Forward, animated: true)
    }
    
    @IBAction func didTapPrevious(sender: AnyObject?) -> Void {
        validateAnswer(currentAnswer)
        loadControllerForIdx(currentIdx?.predecessor() ?? 0, direction: .Reverse, animated: true)
    }
    
    @IBAction func didTapDone(sender: AnyObject?) -> Void {
        validateAnswer(currentAnswer)
        exam?.endDate = NSDate()
        saveIfNeeded { [unowned self] _ in
            UIAlertController.showIn(self,
                style: .Alert,
                title: "Exam over",
                message: "You scored \(self.exam?.grade ?? 0) out of \(self.exam?.source.totalPoints ?? 0)",
                actions: [(title: "View results", action: { _ in
                    self.performSegueWithIdentifier("backToMyAccount", sender: nil)
                })],
                cancelAction: (title: "Go Back", action: { _ in
                    self.performSegueWithIdentifier("backToMyAccount", sender: nil)
                })
            )
        }
    }
    
    /// MARK: -
    /// MARK: PAgeViewController delegate
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        return nil
    }
    
    /// MARK: -
    /// MARK: Answers validtaion
    
    func timedOut(sender: NSTimer?) -> Void {
        didTapDone(nil)
    }
    
    func validateAnswer(answer: ParseExamAnswer?) -> Bool {
        let correct = answer?.question.answer
        let current = answer?.answer
        let isCorrect = correct?.equalTo(current) ?? false
        answer?.result = isCorrect ? 1.0 : 0.0
        computeScore()
        return isCorrect
    }

    func computeScore() -> Void {
        let grade = answers.reduce(Float(exam?.source.freePoints ?? 0.0), combine: { $0 + $1.result * Float($1.question.points)})
        exam?.grade = grade
    }
}
