//
//  ViewController.swift
//  Movies
//
//  Created by SYED FARAN GHANI on 29/05/21.
//


import UIKit
import CoreData

class MovieListViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    // MARK: - Private Properties
    private let viewModel = MovieListViewModel()
    var fetchedResultController: NSFetchedResultsController<Movie>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = viewModel.title

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 160.0
            
        tableView.dataSource = self
        tableView.delegate = self
        
        setupFetchedResultController()
        setupBindingAndGetMovies()
    }

    
    // MARK: - Helper Functions
    
    private func setupFetchedResultController() {
        let movieFetchRequest: NSFetchRequest<Movie> = Movie.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: #keyPath(Movie.title),
                                              ascending: true,
                                              selector: #selector(NSString.caseInsensitiveCompare(_:)))
        movieFetchRequest.sortDescriptors = [sortDescriptor]
        let managedObjectContext = CoreDataManager.shared.managedObjectContext
        
        fetchedResultController = .init(fetchRequest: movieFetchRequest,
                                        managedObjectContext: managedObjectContext, sectionNameKeyPath: #keyPath(Movie.sectionTitle),
                                        cacheName: nil)
        fetchedResultController?.delegate = self
    }
    
    private func performFetchRequest() {
        do {
            try fetchedResultController?.performFetch()
            tableView.reloadData()
        } catch {
            Log.error("Unable to perform fetch operation from DB.", error: error)
        }
    }
    
    private func setupBindingAndGetMovies() {
        //Binding
        viewModel.isBusy.bind { [unowned self] isBusy in
            self.view.showLoader(show: isBusy)
        }
        
        viewModel.movies.bind { [unowned self] (movies) in
            if movies != nil {
                self.performFetchRequest()
            }
        }        
        
        //Get Movies
        viewModel.getMovies()
    }

}


// MARK: - NSFetchResultController Delegate
extension MovieListViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .none)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .none)
        case .update:
            tableView.reloadRows(at: [indexPath!], with: .none)
        case .move:
            tableView.moveRow(at: indexPath!, to: newIndexPath!)
        default:
            break
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            tableView.insertSections(IndexSet(integer: sectionIndex), with: .none)
        case .delete:
            tableView.deleteSections(IndexSet(integer: sectionIndex), with: .none)
        case .update:
            tableView.reloadSections(IndexSet(integer: sectionIndex), with: .none)
        default:
            break
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
}

// MARK: - UITableView Data Source
extension MovieListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultController?.sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultController?.sections?[section].objects?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier,
                                                       for: indexPath) as? MovieTableViewCell else {
            fatalError("Unable to dequeue CarTableViewCell.")
        }
        cell.config(movie: fetchedResultController!.object(at: indexPath))
        return cell
    }
    
}

extension MovieListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let movieDetailVC = storyboard?.instantiateViewController(identifier: "MovieDetailsViewController") as! MovieDetailsViewController
        movieDetailVC.movie = fetchedResultController!.object(at: indexPath)
        self.navigationController?.pushViewController(movieDetailVC, animated: true)
    }
}
