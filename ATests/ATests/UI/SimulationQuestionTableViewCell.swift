//
//  SimulationQuestionTableViewCell.swift
//  ATests
//
//  Created by Radu Costea on 15/06/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit
import Parse
@objc protocol SimulationQuestionTableViewCellDelegate {
    func simulationQuestionCellDidUpdateWeight(cell: SimulationQuestionTableViewCell)
    func simulationQuestionCellDidUpdateInclude(cell: SimulationQuestionTableViewCell)
}

class SimulationQuestionTableViewCell: UITableViewCell {
    @IBOutlet var includeSwitch: UISwitch!
    @IBOutlet var weightLabel: UILabel!
    @IBOutlet var weightStepper: UIStepper!
    @IBOutlet var weightSettingsView: UIView!
    @IBOutlet var delegate: SimulationQuestionTableViewCellDelegate?
    
//    var builder: SimulationQuestionBuilder? {
//        didSet {
//            refresh()
//        }
//    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        weightStepper.addTarget(self, action: #selector(SimulationQuestionTableViewCell.didChangeStepper(_:)), forControlEvents: .ValueChanged)
        includeSwitch.addTarget(self, action: #selector(SimulationQuestionTableViewCell.didSwitched(_:)), forControlEvents: .ValueChanged)
        refresh()
    }

    func refresh() {
//        let weight = builder?.weight ?? 1
//        weightStepper.value = Double(weight)
//        weightLabel.text = "\(weight)"
//        includeSwitch.on = builder?.include ?? false
        weightSettingsView.hidden = !includeSwitch.on
    }
    
    /// MARK: -
    /// MARK: Actions
    
    @IBAction func didSwitched(sender: UISwitch?) {
        let include = sender?.on ?? false
//        builder?.include = include
        weightSettingsView.hidden = !include
        delegate?.simulationQuestionCellDidUpdateInclude(self)
    }
    
    @IBAction func didChangeStepper(sender: UIStepper?) {
        let newValue = Int(sender?.value ?? 1)
//        builder?.weight = newValue
        weightLabel.text = "\(newValue)"
        delegate?.simulationQuestionCellDidUpdateWeight(self)
    }
}
