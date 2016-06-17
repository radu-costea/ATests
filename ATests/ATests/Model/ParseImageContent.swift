//
//  ParseImageContent.swift
//  ATests
//
//  Created by Radu Costea on 16/06/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit
import Parse

extension ParseImageContent {
    @NSManaged var image: PFFile?
    @NSManaged var size: Int
}

extension ParseImageContent {
    func getImageInBackgroundWithBlock(block: (image: UIImage?, error: NSError?) -> Void) {
        guard let imgFile = image else {
            block(image: nil, error: NSError(domain: "QuizzBuilder", code: 0, userInfo: [NSLocalizedDescriptionKey: "Image file not found"]))
            return
        }
        imgFile.getImageInBackgroundWithBlock(block)
        
    }
    
    func updateWithImage(image: UIImage, inBackgroundWithBlock block: (sucess: Bool, error: NSError?) -> Void) {
        let imageFile = PFFile(image: image)
        
        imageFile?.saveInBackgroundWithBlock({ [unowned self] (success, error) in
            if success {
                self.image = imageFile
                self.size = Int.max
                self.saveInBackgroundWithBlock(block)
            } else {
                block(sucess: success, error: error)
            }
        })
    }
    
    override func isValid() -> Bool {
        return size > 0
    }
}

class ParseImageContent: PFObject, PFSubclassing {
    static func parseClassName() -> String {
        return "ParseImageContent"
    }
}
