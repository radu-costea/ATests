//
//  EditImageContentViewController.swift
//  ATests
//
//  Created by Radu Costea on 29/05/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit

class EditImageContentViewController: EditRawContentController, ContentProviderDelegate {
    var imageObject: ImageContentObject?
    var content: UIImage?
    var contentProvider: PhotoViewController!
    
    @IBOutlet var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        contentProvider = PhotoViewController.photoProvider(nil)
        contentProvider.delegate = self
    }
    
    override func loadWith<T : RawContent>(content: T?) {
        guard let img = content as? UIImage else {
            return
        }
        
        self.content = img
        contentProvider.loadWith(img)
    }

    func loadImage() {
        if let data = imageObject?.base64Image?.toBase64Data(),
            let img = UIImage(data: data) {
                content = img
                contentProvider.loadWith(content)
        }
    }
    
    /// MARK: -
    /// MARK: Class functions
    
    override static var storyboardName: String { return "EditQuestionStoryboard" }
    override static var storyboardId: String { return "editImage" }

    /// MARK: -
    /// MARK: Actions
    
    @IBAction func didTapOnContent(sender: AnyObject?) {
        presentViewController(self.contentProvider, animated: true, completion: nil)
    }
    
    /// MARK: -
    /// MARK: Conten Provider Delegate
    
    func contentProvider<Provider: ContentProvider>(provider: Provider, finishedLoadingWith content: Provider.ContentType?) -> Void {
        if let currentProvider = provider as? PhotoViewController,
            let img = content as? UIImage {
            currentProvider.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
                imageView.image = img
        }
    }
}

extension EditContentFabric {
    class func imageController(image: UIImage?) -> EditImageContentViewController? {
        return EditImageContentViewController.editController(image) as? EditImageContentViewController
    }
}