//
//  EditMixedContentViewController.swift
//  ATests
//
//  Created by Radu Costea on 29/05/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit

class EditMixedContentViewController: UIViewController, ContainedController, ContentProviderDelegate {

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    var imageObject: MixedContentObject?
    weak var presenter: UIViewController?
    
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
    
    static func editContentController() -> EditMixedContentViewController? {
        return UIStoryboard(name: "EditQuestionStoryboard", bundle: nil).instantiateViewControllerWithIdentifier("editMixed") as? EditMixedContentViewController
    }
    
    /// MARK: -
    /// MARK: Actions
    
    @IBAction func didTapOnImageContent(sender: AnyObject?) {
        presenter?.presentViewController(self.imageProvider, animated: true, completion: nil)
    }
    
    @IBAction func didTapOnTextContent(sender: AnyObject?) {
        presenter?.presentViewController(self.textProvider, animated: true, completion: nil)
    }
    
    /// MARK: -
    /// MARK: Conten Provider Delegate
    
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
