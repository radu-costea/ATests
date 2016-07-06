//
//  CustomizeViewController.swift
//  ATests
//
//  Created by Radu Costea on 05/07/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit

class CustomizeViewController: UIViewController, ColorPickerViewControllerDelegate {
    var user: ParseUser!
    @IBOutlet var normalColorButton: UIButton!
    @IBOutlet var alternateColorButton: UIButton!
    var updateColor: ((color: String) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        normalColorButton.backgroundColor = AppearenceCustomizer.primaryColor
        alternateColorButton.backgroundColor = AppearenceCustomizer.alternateColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if let identifier = segue.identifier where identifier == "pickNormalColor" {
            if let destination = segue.destinationViewController as? ColorPickerViewController {
                destination.delegate = self
                destination.selectedColor = AppearenceCustomizer.primaryColor.hex
                updateColor = { AppearenceCustomizer.primaryColor = UIColor(hex: $0)! }
            }
        }
        
        if let identifier = segue.identifier where identifier == "pickAlternateColor" {
            if let destination = segue.destinationViewController as? ColorPickerViewController {
                destination.delegate = self
                destination.selectedColor = AppearenceCustomizer.alternateColor.hex
                updateColor = { AppearenceCustomizer.alternateColor = UIColor(hex: $0)! }
            }
        }
    }
    
    /// MARK: -
    /// MARK: ColorPickerDelegate
    
    func colorPickerDidCancelPickingColor(picker: ColorPickerViewController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    func colorPicker(picker: ColorPickerViewController, didFinishPickingColor color: String) {
        let picked = color
        picker.dismissViewControllerAnimated(true, completion: { [unowned self] _ in
            self.updateColor?(color: picked)
            AppearenceCustomizer.setupAppearence()
        })
    }
}
