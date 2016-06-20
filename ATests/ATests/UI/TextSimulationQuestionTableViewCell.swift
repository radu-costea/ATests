//
//  TextSimulationQuestionTableViewCell.swift
//  ATests
//
//  Created by Radu Costea on 15/06/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit
import Parse
class TextSimulationQuestionTableViewCell: SimulationQuestionTableViewCell {
    @IBOutlet var questionTextLabel: UILabel!
    var textContent: ParseTextContent? {
        didSet {
            txt = textContent?.text
        }
    }
    
    var txt: String? {
        didSet {
            questionTextLabel?.text = txt
        }
    }
    
    override var builder: ParseExamQuestionBuilder? {
        didSet {
            textContent = builder?.question.content as? ParseTextContent
            refresh()
        }
    }
    
    override func refresh() {
        super.refresh()
        questionTextLabel.text = txt
    }

}
