//
//  Movie+CoreDataProperties.swift
//  Movies
//
//  Created by SYED FARAN GHANI on 29/05/21.
//

import Foundation
import CoreData

@objc(Movie)
public class Movie: NSManagedObject, Codable {
    @NSManaged public var id: Int64
    @NSManaged public var title: String?
    @NSManaged public var movieDesciption: String?
    @NSManaged public var date: String?
    @NSManaged public var posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title = "title"
        case movieDesciption = "overview"
        case posterPath = "poster_path"
        case date = "release_date"
    }
    
    public required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let movieId = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        let title = try container.decodeIfPresent(String.self, forKey: .title)
        let movieDesciption = try container.decodeIfPresent(String.self, forKey: .movieDesciption)
        let posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
        let date = try container.decodeIfPresent(String.self, forKey: .date)
        
        let managedObjectContext = CoreDataManager.shared.managedObjectContext
        guard let entity = NSEntityDescription.entity(forEntityName: Movie.name, in: managedObjectContext) else {
            fatalError("Failed to decode Movie")
        }
        self.init(entity: entity, insertInto: nil)
        self.id = Int64(movieId)
        self.title = title
        self.movieDesciption = movieDesciption
        self.posterPath = posterPath
        self.date = date

        
        if let entity = Movie.getMovie(id: movieId) {
            entity.title = title
            entity.movieDesciption = movieDesciption
            entity.posterPath = posterPath
            entity.date = date
        } else {
            managedObjectContext.insert(self)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(movieDesciption, forKey: .movieDesciption)
        try container.encode(date, forKey: .date)
        try container.encode(posterPath, forKey: .posterPath)
    }
}
