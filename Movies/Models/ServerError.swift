//
//  ServerError.swift
//  Movies
//
//  Created by SYED FARAN GHANI on 29/05/21.
//


import Foundation

struct ServerError: Decodable {
    let status: String?
    let error: String?
}
