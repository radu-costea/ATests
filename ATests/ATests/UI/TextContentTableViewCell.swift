//
//  TextContentTableViewCell.swift
//  ATests
//
//  Created by Radu Costea on 11/06/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit

class TextContentTableViewCell: UITableViewCell {
    var getImageOperation: NSBlockOperation?
    
    var content: LiteTextContent? {
        didSet {
            questionLabel?.text = content?.text
        }
    }
    
    @IBOutlet var questionLabel: UILabel?
    
    override func prepareForReuse() {
        questionLabel?.text = ""
    }

}
