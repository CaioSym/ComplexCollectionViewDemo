//
//  BaseAdapter.swift
//  SkyScannerApp
//
//  Created by Caio Freitas Sym on 5/11/18.
//  Copyright © 2018 Caio Sym. All rights reserved.
//

import Foundation
import UIKit

/// Base for adapter classes. Provides functionality for updating an internal collection of items
open class BaseAdapter<T>: NSObject {
    private(set) var items: [T] = []
    
    var isLoading: Bool = false
    
    func update(items: [T]) {
        self.items = items
    }
}
