//
//  ParseImage.swift
//  ATests
//
//  Created by Radu Costea on 16/06/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit
import Parse

extension PFFile {
    convenience init?(image: UIImage) {
        let data = UIImageJPEGRepresentation(image, 0.8)!
        self.init(data: data, contentType: "image/jpeg")
    }
    
    func getImage() throws -> UIImage? {
        let data = try self.getData()
        return UIImage(data: data)
    }
    
    func getImageInBackgroundWithBlock(block: ((UIImage?, NSError?) -> Void)?) {
        getDataInBackgroundWithBlock { (data, error) in
            var img: UIImage? = nil
            if let fetchedData = data {
                img = UIImage(data: fetchedData)
            }
            block?(img, error)
        }
    }
}
