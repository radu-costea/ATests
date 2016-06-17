//
//  TextContentTableViewCell.swift
//  ATests
//
//  Created by Radu Costea on 11/06/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit

class TextContentQuestionTableViewCell: UITableViewCell {
    var question: ParseQuestion? {
        didSet {
            content = question?.content as? TextContent
            refreshValidState()
        }
    }
    
    var content: TextContent? {
        didSet {
            questionLabel?.text = content?.text
        }
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        refreshValidState()
    }
    
    func refreshValidState() {
        validIcon?.image = (question?.isValid() ?? false) ? UIImage(named: "icon_correct") : UIImage(named: "icon_incorrect")
    }
    
    @IBOutlet var questionLabel: UILabel?
    @IBOutlet var validIcon: UIImageView!
    
    override func prepareForReuse() {
        questionLabel?.text = ""
    }

}
