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

    var imageContent: ParseImageContent?
    var img: UIImage? = nil {
        didSet {
            questionImage?.image = img
        }
    }
    
    override var builder: ParseExamQuestionBuilder? {
        didSet {
            imageContent = builder?.question.content as? ParseImageContent
            getImage(imageContent)
            refresh()
        }
    }
    
    override func refresh() {
        super.refresh()
        questionImage?.image = img
    }
    
    /// MARK: -
    /// MARK: Download image
    
    var getImageOperation: NSBlockOperation?
    func getImage(content: ParseImageContent?) {
        content?.image?.cancel()
        let currentContent = content
        content?.image?.getImageInBackgroundWithBlock({ [weak self, weak currentContent] (img, error) in
            guard let wSelf =  self where currentContent === wSelf.imageContent else { return }
            wSelf.img = img
        })
    }
}
