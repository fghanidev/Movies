//
//  UIViewExtension.swift
//  Movies
//
//  Created by SYED FARAN GHANI on 29/05/21.
//

import Foundation
import UIKit
import ProgressHUD

extension UIView {
    func showLoader(show: Bool, text: String = .kLoading) {
        if show {
            
            ProgressHUD.show(.kLoading)
            
        } else {

            ProgressHUD.dismiss()
        }
    }
}
