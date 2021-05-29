//
//  Bindable.swift
//  Movies
//
//  Created by SYED FARAN GHANI on 29/05/21.
//


import Foundation

class Bindable<T> {
    typealias Listener = (T) -> Void
    var listener: Listener?
    
    var value: T {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {
                    return
                }
                self.listener?(self.value)
            }
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
