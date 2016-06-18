//
//  ImageSimulationQuestionTableViewCell.swift
//  ATests
//
//  Created by Radu Costea on 15/06/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit
import Parse
class ImageSimulationQuestionTableViewCell: SimulationQuestionTableViewCell {
    @IBOutlet var questionImage: UIImageView!
//
//    var imageContent: LiteImageContent?
//    var img: UIImage? = nil {
//        didSet {
//            questionImage?.image = img
//        }
//    }
//    
//    override var builder: SimulationQuestionBuilder? {
//        didSet {
//            imageContent = builder?.question.content as? LiteImageContent
//            getImage(imageContent)
//            refresh()
//        }
//    }
//    
//    override func refresh() {
//        super.refresh()
//        questionImage?.image = img
//    }
//    
//    /// MARK: -
//    /// MARK: Download image
//    
//    var getImageOperation: NSBlockOperation?
//    func getImage(content: LiteImageContent?) {
//        getImageOperation?.cancel()
//        guard let currentContent = content else {
//            return;
//        }
//        
//        var loadedImg: UIImage?
//        let operation = NSBlockOperation{ _ in
//            let data = currentContent.base64Image?.toBase64Data()
//            if let loadedData = data {
//                loadedImg = UIImage(data: loadedData)
//            }
//        }
//        operation.completionBlock = { [weak operation, unowned self] _ in
//            if let finishContent = self.imageContent,
//                let isCancelled = operation?.cancelled
//                where finishContent == currentContent && !isCancelled {
//                self.img = loadedImg
//            }
//        }
//        getImageOperation = operation
//        getImageOperation?.start()
//    }
}
