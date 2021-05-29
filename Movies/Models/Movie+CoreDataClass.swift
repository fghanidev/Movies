//
//  Movie+CoreDataClass.swift
//  Movies
//
//  Created by SYED FARAN GHANI on 29/05/21.
//


import Foundation
import CoreData

extension Movie {
    
    @objc public var sectionTitle: String {
        let firstCharString = title?.first?.uppercased() ?? ""
        if firstCharString >= "A" && firstCharString <= "Z" {
            return firstCharString
        }
        return "#"
    }
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: Movie.name)
    }
    
    public class func getMovie(id: Int) -> Movie? {
        let fetchRequest: NSFetchRequest<Movie> = Movie.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id=%ld", id)
        fetchRequest.fetchLimit = 1
        do {
            let movies: [Movie] = try CoreDataManager.shared.managedObjectContext.fetch(fetchRequest)
            return movies.first
        } catch {
            Log.error("Unable to fetch Movie with id \(id).", error: error)
        }
        return nil
    }
    
    public class func deleteAllMovies() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Movie.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        deleteRequest.resultType = .resultTypeObjectIDs
        
        // perform the delete
        do {
            let managedObjectContext = CoreDataManager.shared.managedObjectContext
            let result = try managedObjectContext.execute(deleteRequest) as? NSBatchDeleteResult
            let managedObjectIds = result?.result as? [NSManagedObjectID] ?? []
            let changes: [AnyHashable: Any] = [NSDeletedObjectsKey: managedObjectIds]
            NSManagedObjectContext.mergeChanges(fromRemoteContextSave: changes, into: [managedObjectContext])
        } catch let error as NSError {
            Log.error("Unable to delete existing movies.", error: error)
        }
    }
    
}
