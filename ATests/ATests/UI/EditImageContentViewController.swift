//
//  EditImageContentViewController.swift
//  ATests
//
//  Created by Radu Costea on 29/05/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit

class EditImageContentViewController: EditContentController, ContentProviderDelegate {
    var content: LiteImageContent?
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
        loadImage()
        errorView.hidden = content?.isValid() ?? false
    }
    
    override func loadWith<T : LiteContent>(content: T?) {
        guard let img = content as? LiteImageContent else {
            return
        }
        self.content = img
        loadImage()
    }

    func loadImage() {
        if let data = content?.base64Image?.toBase64Data(),
            let img = UIImage(data: data) {
                image = img
                imageView?.image = img
                contentProvider.loadWith(img)
        }
        
        correctRatio()
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
            let img = content as? UIImage {
                imageView.image = img
                let string = UIImageJPEGRepresentation(img, 0.8)?.toBase64String()
                self.content?.base64Image = string
                self.content?.imageHash = Int64(string?.hash ?? 0)
                self.content?.tryPersit()
                currentProvider.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
                correctRatio()
                self.errorView.hidden = self.content?.isValid() ?? false
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
    class func imageController(image: LiteImageContent?) -> EditImageContentViewController? {
        return EditImageContentViewController.editController(image) as? EditImageContentViewController
    }
}