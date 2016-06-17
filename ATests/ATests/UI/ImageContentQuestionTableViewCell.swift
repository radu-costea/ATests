//
//  ImageContentTableViewCell.swift
//  ATests
//
//  Created by Radu Costea on 11/06/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit

class ImageContentQuestionTableViewCell: UITableViewCell {
    @IBOutlet var questionImageView: UIImageView!
    @IBOutlet var validIcon: UIImageView!

    /// MARK: -
    /// MARK: Overrides
    
    override func prepareForReuse() {
        questionImageView?.image = nil
    }
    
    /// MARK: -
    /// MARK: Image download
    
    var question: ParseQuestion? {
        didSet {
            content = question?.content as? ImageContent
            refreshValidState()
        }
    }
    
    var content: ImageContent? {
        didSet {
            let current = content
            current?.getImageInBackgroundWithBlock{ [unowned self] (image, error) in
                if let img = image where error == nil && current?.objectId == self.content?.objectId {
                    self.questionImageView?.image = img
                }
            }
        }
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        refreshValidState()
    }
    
    func refreshValidState() {
        validIcon?.image = (question?.isValid() ?? false) ? UIImage(named: "icon_correct") : UIImage(named: "icon_incorrect")
    }
}
