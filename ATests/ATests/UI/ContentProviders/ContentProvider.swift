//
//  BaseContentProviderViewController.swift
//  ATests
//
//  Created by Radu Costea on 20/05/16.
//  Copyright © 2016 Radu Costea. All rights reserved.
//

import UIKit

protocol RawContent { }
extension String: RawContent { }
extension UIImage: RawContent { }

class MixedRawContent {
    var image: UIImage?
    var text: String?
}

extension MixedRawContent: RawContent { }

class EmptyRawContent: RawContent { }

protocol ContentProviderDelegate: class {
    func contentProvider<Provider: ContentProvider>(provider: Provider, finishedLoadingWith content: Provider.ContentType?) -> Void
}

protocol ContentProvider {
    associatedtype ContentType: RawContent
    func loadWith(content: ContentType?) -> Void
}
