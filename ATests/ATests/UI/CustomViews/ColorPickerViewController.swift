//
//  ColorPickerViewController.swift
//  ATests
//
//  Created by Radu Costea on 06/07/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit

class ColorCollectionViewCell: UICollectionViewCell {
    var color: String? {
        didSet {
            if let c = color {
                colorView.backgroundColor = UIColor(hex: c)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func awakeAfterUsingCoder(aDecoder: NSCoder) -> AnyObject? {
        let obj = super.awakeAfterUsingCoder(aDecoder)
        
        let view = UIView()
        view.backgroundColor = UIColor.clearColor()
        view.borderWidth = 2.0;
        view.backgroundColor = UIColor.greenColor()
        self.selectedBackgroundView = view
        
        return obj
    }
    
    @IBOutlet var colorView: UIView!
}

protocol ColorPickerViewControllerDelegate: class {
    func colorPicker(picker: ColorPickerViewController, didFinishPickingColor color: String)
    func colorPickerDidCancelPickingColor(picker: ColorPickerViewController)
}

func rgbToHex(rgb: (red: Int, green: Int, blue: Int)) -> String {
    return String(format: "#%02X%02X%02X", arguments: [rgb.red, rgb.green, rgb.blue])
}

class ColorPickerViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    var colors: [String] = AppearenceCustomizer.allColors
    var selectedColor: String!
    @IBOutlet var collectionView: UICollectionView!
    weak var delegate: ColorPickerViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.allowsMultipleSelection = false
        collectionView.reloadData()
        
        let selectionIdx = colors.indexOf(self.selectedColor) ?? 0
        collectionView.selectItemAtIndexPath(NSIndexPath(forItem: selectionIdx, inSection: 0), animated: true, scrollPosition: .CenteredVertically)
    }

    /// MARK: -
    /// MARK: Colection View Data soure
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath)
        if let c = cell as? ColorCollectionViewCell {
            let color = colors[indexPath.item]
            c.color = color
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let oldSelectionIdx = colors.indexOf(self.selectedColor)!
        self.selectedColor = colors[indexPath.item]
        self.collectionView.reloadItemsAtIndexPaths([NSIndexPath(forItem: oldSelectionIdx, inSection: 0)])
    }

    /// MARK: -
    /// MARK: Actions
    
    @IBAction func didTapUse(sender: AnyObject?) {
        delegate?.colorPicker(self, didFinishPickingColor: selectedColor)
    }
    
    @IBAction func didTapCancel(sender: AnyObject?) {
        delegate?.colorPickerDidCancelPickingColor(self)
    }

}
