//
//  UIImageViewExtension.swift
//  Movies
//
//  Created by SYED FARAN GHANI on 29/05/21.
//


import Foundation
import UIKit

extension UIImageView {
    func makeCircle() {
        layer.cornerRadius = bounds.height / 2
        layer.masksToBounds = true
    }
}
