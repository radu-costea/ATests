//
//  EditMixedContentViewController.swift
//  ATests
//
//  Created by Radu Costea on 29/05/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit

class EditMixedContentViewController: EditRawContentController, ContentProviderDelegate {
    var imageObject: MixedContentObject?
    
    var image: UIImage?
    var text: String?
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var textView: UILabel!
    
    lazy var imageProvider: PhotoViewController! = { [unowned self] in
        let provider = PhotoViewController.photoProvider(self.image)
        provider?.delegate = self
        return provider
    }()
    
    lazy var textProvider: TextProviderViewController! = {
        let provider = TextProviderViewController.textProvider(self.text)
        provider?.delegate = self
        return provider
    }()

    func loadImage() {
        if let data = imageObject?.base64Image?.toBase64Data(),
            let img = UIImage(data: data) {
                image = img
                imageProvider.loadWith(img)
        }
    }
    
    override func loadWith<T : RawContent>(content: T?) {
        if let mixed = content as? MixedRawContent {
            image = mixed.image
            text = mixed.text
        }
    }
    
    /// MARK: -
    /// MARK: Class 
    
    override static var storyboardName: String { return "EditQuestionStoryboard" }
    override static var storyboardId: String { return "editMixed" }
    
    /// MARK: -
    /// MARK: Actions
    
    @IBAction func didTapOnImageContent(sender: AnyObject?) {
        presentViewController(self.imageProvider, animated: true, completion: nil)
    }
    
    @IBAction func didTapOnTextContent(sender: AnyObject?) {
        presentViewController(self.textProvider, animated: true, completion: nil)
    }
    
    /// MARK: -
    /// MARK: Content Provider Delegate
    
    func contentProvider<Provider: ContentProvider>(provider: Provider, finishedLoadingWith content: Provider.ContentType?) -> Void {        
        if let currentProvider = provider as? PhotoViewController,
            let img = content as? UIImage {
                currentProvider.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
                imageView.image = img
        }
        
        if let currentProvider = provider as? TextProviderViewController,
            let txt = content as? String {
                currentProvider.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
                textView.text = txt
        }
    }
}

extension EditContentFabric {
    class func mixedController(mixed: MixedRawContent?) -> EditMixedContentViewController? {
        return EditMixedContentViewController.editController(mixed) as? EditMixedContentViewController
    }
}
