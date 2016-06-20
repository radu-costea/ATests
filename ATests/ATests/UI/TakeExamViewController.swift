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
    
    var seenOnce: Bool = false
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let allAnswers = exam?.answers where allAnswers.count > 0 {
            self.answers = allAnswers
        }
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
                AnimatingViewController.hide()
                completion()
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
        loadControllerForIdx(currentIdx?.successor() ?? 0, direction: .Forward, animated: true)
    }
    
    @IBAction func didTapPrevious(sender: AnyObject?) -> Void {
        loadControllerForIdx(currentIdx?.predecessor() ?? 0, direction: .Reverse, animated: true)
    }
    
    /// MARK: -
    /// MARK: PAgeViewController delegate
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        return nil
    }

    func computeScore() -> Void {
//        let score = answers.reduce(0){
//            return $0 + ($1.answer?.isEqual($1.question.answer) ? $1.question.points : 0)
//        }
    }
}
