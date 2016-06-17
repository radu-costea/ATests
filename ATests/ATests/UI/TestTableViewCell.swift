//
//  TestTableViewCell.swift
//  ATests
//
//  Created by Radu Costea on 15/06/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit

@objc protocol TestTableViewCellDelegate: class {
    func testCellDidSelectCreateTest(cell: UITableViewCell)
}

class TestTableViewCell: UITableViewCell {
    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var testIcon: UIImageView!
    @IBOutlet var labelSubtitle: UILabel!
    @IBOutlet var createSimulation: UIButton!
    @IBOutlet weak var delegate: TestTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        createSimulation.addTarget(self, action: #selector(TestTableViewCell.didTapCreateSimulation(_:)), forControlEvents: .TouchUpInside)
    }
    
    var test: ParseDomain? {
        didSet {
            refresh()
        }
    }
    
    func refresh() {
        labelTitle.text = test?.title
        let count = test?.questions?.count ?? 0
        labelSubtitle.text = "\(count) Question\(count != 1 ? "s" : "")"
    }
    
    override func didMoveToSuperview() {
        if let _ = superview {
            refresh()
        }
    }

    /// MARK: -
    /// MARK: Actions
    
    @IBAction func didTapCreateSimulation(sender: AnyObject?) {
        delegate?.testCellDidSelectCreateTest(self)
    }
}
