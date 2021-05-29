//
//  NSObjectExtension.swift
//  Movies
//
//  Created by SYED FARAN GHANI on 29/05/21.
//

import Foundation

extension NSObject {
    class var name: String {
        return String(describing: self)
    }
}
