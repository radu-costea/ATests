//
//  PhotoViewController.swift
//  ATests
//
//  Created by Radu Costea on 20/05/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit
import MobileCoreServices

extension UIImagePickerControllerSourceType {
    func toString() -> String {
        switch self {
        case .Camera: return "Camera"
        case .PhotoLibrary: return "Photo Library"
        case .SavedPhotosAlbum: return "Saved Shotos Album"
        }
    }
}


class PhotoViewController: UIViewController, ContentProvider, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var content: UIImage?
    @IBOutlet var imageView: UIImageView!
    weak var delegate: ContentProviderDelegate?
    
    func loadWith(content: UIImage?) {
        displayImage(content)
    }
    
    static func photoProvider(image: UIImage?) -> PhotoViewController? {
        let provider = UIStoryboard(name: "ContentProvidersStoryboard", bundle: nil).instantiateViewControllerWithIdentifier("photoProvider") as? PhotoViewController
        provider?.loadWith(image)
        return provider
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        displayImage(self.content)
    }
    
    func displayImage(image: UIImage?) {
        self.content = image
        if let img = image {
            imageView.image = img
        }
    }
    

    /// MARK: -
    /// MARK: Actions
    
    @IBAction func loadImage() {
        let alertController = UIAlertController(title: "Select source", message: "Where you want to load the photo from?", preferredStyle: .ActionSheet)
        [UIImagePickerControllerSourceType.Camera, UIImagePickerControllerSourceType.PhotoLibrary].forEach { (type) -> () in
            if UIImagePickerController.isSourceTypeAvailable(type) {
                alertController.addAction(UIAlertAction(title: type.toString(), style: .Default, handler: { [unowned self] _ in
                    self.loadImageFrom(type)
                }))
            }
        }
        alertController.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { _ in }))
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    @IBAction func done() {
        delegate?.contentProvider(self, finishedLoadingWith: content)
    }
    
    /// MARK: -
    /// MARK: Private actions
    
    func loadImageFrom(source: UIImagePickerControllerSourceType) {
        let picker = UIImagePickerController()
        picker.mediaTypes = [String(kUTTypeImage)]
        picker.sourceType = source
        picker.delegate = self
        presentViewController(picker, animated: true, completion: nil)
    }
    
    /// MARK: -
    /// MARK: ImagePickerDelegate
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        displayImage(info[UIImagePickerControllerOriginalImage] as? UIImage)
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
}
