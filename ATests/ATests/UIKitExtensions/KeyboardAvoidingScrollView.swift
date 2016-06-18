//
//  KeyboardAvoidingScrollView.swift
//  ATests
//
//  Created by Radu Costea on 11/04/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import Foundation
import UIKit
import Parse
class KeyboardAvoidingScrollView: UIScrollView {
    var avoider: ScrollViewKeyboardAvoider!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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