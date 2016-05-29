//
//  EditImageContentViewController.swift
//  ATests
//
//  Created by Radu Costea on 29/05/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit

class EditImageContentViewController: UIViewController, ContentProviderDelegate, ContainedController {
    var imageObject: ImageContentObject?
    var image: UIImage?
    var contentProvider: PhotoViewController!
    
    weak var presenter: UIViewController?
    @IBOutlet var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        contentProvider = PhotoViewController.photoProvider(nil)
        contentProvider.delegate = self
    }

    func loadImage() {
        if let data = imageObject?.base64Image?.toBase64Data(),
            let img = UIImage(data: data) {
                image = img
                contentProvider.loadWith(image)
        }
    }
    
    static func editContentController() -> EditImageContentViewController? {
        return UIStoryboard(name: "EditQuestionStoryboard", bundle: nil).instantiateViewControllerWithIdentifier("editImage") as? EditImageContentViewController
    }

    /// MARK: -
    /// MARK: Actions
    
    @IBAction func didTapOnContent(sender: AnyObject?) {
        presenter?.presentViewController(self.contentProvider, animated: true, completion: nil)
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