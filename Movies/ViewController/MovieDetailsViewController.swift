//
//  MovieDetailsViewController.swift
//  Movies
//
//  Created by SYED FARAN GHANI on 29/05/21.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var desclabel: UILabel!
    
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let viewModel = MovieViewModel(movie: movie!)
        
        titleLabel.text = viewModel.title
        desclabel.text = viewModel.desc
        dateLabel.text = viewModel.date
        posterImageView.kf.setImage(with: viewModel.imageURL, placeholder: UIImage.Movie.placeHolder)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
