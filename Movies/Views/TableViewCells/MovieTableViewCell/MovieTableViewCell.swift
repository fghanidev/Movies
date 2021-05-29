//
//  MovieTableViewCell.swift
//  Movies
//
//  Created by SYED FARAN GHANI on 29/05/21.
//


import UIKit
import Kingfisher

class MovieTableViewCell: UITableViewCell {
  
    @IBOutlet var cellbackgroundView: UIView!
    @IBOutlet var moviePosterView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var descLabel: UILabel!
    
    
    
    static let identifier = "movieTableViewCell"
    static let nib = UINib(nibName: MovieTableViewCell.name, bundle: nil)

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func config(movie: Movie) {
        let viewModel = MovieViewModel(movie: movie)
        
        titleLabel.text = viewModel.title
        descLabel.text = viewModel.desc
        dateLabel.text = viewModel.date
        moviePosterView.kf.setImage(with: viewModel.imageURL, placeholder: UIImage.Movie.placeHolder)

    }
}
