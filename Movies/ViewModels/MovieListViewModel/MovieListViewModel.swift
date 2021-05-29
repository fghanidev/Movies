//
//  CarListViewModel.swift
//  Movies
//
//  Created by SYED FARAN GHANI on 29/05/21.
//

import Foundation

class MovieListViewModel {
    
    
    let title = NSLocalizedString("Movies", comment: "")
    let groupBarButtonTitle = NSLocalizedString("Groups", comment: "")
    
    var isBusy: Bindable<Bool> = Bindable(false)
    var movies: Bindable<[Movie]?> = Bindable(nil)
    
    func getMovies() {
        isBusy.value = true
        
        if let path = Bundle.main.path(forResource: "movies", ofType: "json") {
            do {
                  let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)

                    Movie.deleteAllMovies()
                    let movies = try JSONDecoder().decode([Movie].self, from: data)
                    CoreDataManager.shared.saveContext()
                    self.movies.value = movies
                    Log.info("movies sync successfully.")
                    self.isBusy.value = false

              } catch {
                   // handle error
                
                Log.error("Unable to decode movie List", error: error)

              }
        }

    }
}
