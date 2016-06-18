//
//  EditImageContentViewController.swift
//  ATests
//
//  Created by Radu Costea on 29/05/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit
import Parse
class EditImageContentViewController: EditContentController, ContentProviderDelegate {
    var content:ParseImageContent?
    var image: UIImage?
    var contentProvider = PhotoViewController.photoProvider(nil)!
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var ratioConstraint: NSLayoutConstraint!
    @IBOutlet var errorView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        contentProvider.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        errorView.hidden = content?.isValid() ?? false
        loadImage()
    }
    
    override func loadWith(content: PFObject?) {
        guard let img = content as?ParseImageContent else {
            return
        }
        self.content = img
        loadImage()
    }

    func loadImage() {
        content?.getImageInBackgroundWithBlock{ [weak self] (img, error) in
            self?.image = img
            self?.imageView?.image = img
            self?.contentProvider.loadWith(img)
            self?.correctRatio()
            self?.errorView?.hidden = (error == nil)
        }
    }
    
    /// MARK: -
    /// MARK: Class functions
    
    override static var storyboardName: String { return "EditQuestionStoryboard" }
    override static var storyboardId: String { return "editImage" }

    /// MARK: -
    /// MARK: Actions
    
    @IBAction func didTapOnContent(sender: AnyObject?) {
        startEditing()
    }
    
    override func startEditing() {
        presentViewController(self.contentProvider, animated: true, completion: nil)
    }
    
    /// MARK: -
    /// MARK: Conten Provider Delegate
    
    func contentProvider<Provider: ContentProvider>(provider: Provider, finishedLoadingWith content: Provider.ContentType?) -> Void {
        if let currentProvider = provider as? PhotoViewController,
            let img = content as? UIImage,
            let imgContent = self.content {
                imageView.image = img
                correctRatio()
            
                AnimatingViewController.showInController(currentProvider, status: "Preparing image..")
                imgContent.updateWithImage(img, inBackgroundWithBlock: { (sucess, error) in
                    AnimatingViewController.hide()
                    currentProvider.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
                    self.errorView.hidden = imgContent.isValid() ?? false
                })
        }
    }
    
    func correctRatio() {
        ratioConstraint?.active = false
        let newRatio = CGFloat((imageView?.image?.size.width ?? 2.0) / (imageView?.image?.size.height ?? 1.0))
        ratioConstraint = imageView?.widthAnchor.constraintEqualToAnchor(imageView?.heightAnchor, multiplier: newRatio)
        ratioConstraint?.active = true
    }
}

extension EditContentFabric {
    class func imageController(image:ParseImageContent?) -> EditImageContentViewController? {
        return EditImageContentViewController.editController(image) as? EditImageContentViewController
    }
}