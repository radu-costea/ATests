//
//  KeyboardAvoidingTableView.swift
//  ATests
//
//  Created by Radu Costea on 11/04/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation
import UIKit

class KeyboardAvoidingTableView: UITableView {
    var avoider: ScrollViewKeyboardAvoider!
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.avoider = ScrollViewKeyboardAvoider(scrollView: self)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.avoider = ScrollViewKeyboardAvoider(scrollView: self)
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        if let _ = self.window {
            self.avoider.startListeningForKeyboardNotifications()
        } else {
            self.avoider.stopListeningForKeyboardNotifications()
        }
    }
}