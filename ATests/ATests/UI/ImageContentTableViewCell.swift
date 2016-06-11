//
//  ImageContentTableViewCell.swift
//  ATests
//
//  Created by Radu Costea on 11/06/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit

class ImageContentTableViewCell: UITableViewCell {
    var getImageOperation: NSBlockOperation?
    
    var content: LiteImageContent? {
        didSet {
            getImage(content)
        }
    }
    
    func getImage(content: LiteImageContent?) {
        getImageOperation?.cancel()
        questionImageView?.image = nil
        guard let currentContent = content else {
            return;
        }
        
        var img: UIImage?
        let operation = NSBlockOperation{ _ in
            let data = currentContent.base64Image?.toBase64Data()
            if let loadedData = data {
                img = UIImage(data: loadedData)
            }
        }
        operation.completionBlock = { [weak operation, unowned self] _ in
            if let finishContent = self.content,
                let isCancelled = operation?.cancelled
                where finishContent == currentContent && !isCancelled {
                self.questionImageView?.image = img
            }
        }
        getImageOperation = operation
        getImageOperation?.start()
    }
    
    @IBOutlet var questionImageView: UIImageView?

    override func prepareForReuse() {
        questionImageView?.image = nil
        getImageOperation?.cancel()
    }

}
