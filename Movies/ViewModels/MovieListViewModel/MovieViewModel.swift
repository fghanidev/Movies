//
//  CarViewModel.swift
//  Movies
//
//  Created by SYED FARAN GHANI on 29/05/21.
//


import Foundation

class MovieViewModel {
    private let movie: Movie!
    
    let title: String
    let imageURL: URL?
    let desc: String
    let date: String
    
    init(movie: Movie) {
        self.movie = movie
        
        title = movie.title ?? ""
        imageURL = URL(string: "\(String.kBaseUrl)\(movie.posterPath ?? "")" )
        desc = movie.movieDesciption ?? ""
        date = movie.date ?? ""
    }
}
