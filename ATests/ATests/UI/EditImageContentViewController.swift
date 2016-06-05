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
    var contentProvider: PhotoViewController!
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var ratioConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        contentProvider = PhotoViewController.photoProvider(nil)
        contentProvider.delegate = self
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
                self.content?.base64Image = UIImageJPEGRepresentation(img, 0.8)?.toBase64String()
                currentProvider.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
                correctRatio()
        
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