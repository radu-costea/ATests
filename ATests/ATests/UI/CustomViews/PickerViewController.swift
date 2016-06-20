//
//  PickerViewController.swift
//  ATests
//
//  Created by Radu Costea on 19/06/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit

class PickerViewControllerColumn {
    var count: Int
    var titleBuilder: (Int) -> String
    var selected: Int
    
    init(count: Int, selected: Int, titleBuilder: (Int) -> String) {
        self.count = count
        self.titleBuilder = titleBuilder
        self.selected = selected
    }
}

class PickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet var picker: UIPickerView!
    var columns: [PickerViewControllerColumn]!
    var onCompletion: ((PickerViewController) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        (0..<columns.count).forEach{ picker.selectRow(columns[$0].selected, inComponent: $0, animated: false) }
    }
    
    /// MARK: -
    /// MARK: PickerViewDelegate
    
    // returns the number of 'columns' to display.
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return columns.count;
    }
    
    // returns the # of rows in each component..
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return columns[component].count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return columns[component].titleBuilder(row)
    }

    /// MARK: -
    /// MARK: Actions
    
    @IBAction func didTapDone(sender: AnyObject?) {
        (0..<columns.count).forEach{ columns[$0].selected = picker.selectedRowInComponent($0) }
        onCompletion?(self)
    }
}
