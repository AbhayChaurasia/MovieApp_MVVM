//
//  MovieDetailsViewController.swift
//  MovieAppMVVM
//
//  Created by iMacRaja on 14/06/25.
//

import UIKit
import Combine

class MovieDetailsViewController: UIViewController {
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!

    var viewModel: MovieDetailsViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        viewModel.onFavoriteStatusChanged = { [weak self] in
            self?.updateFavoriteButton()
        }
    }

    private func configureUI() {
        favoriteButton.round()
        titleLabel.text = viewModel.movie.title ?? ""
        if let description = viewModel.movie.overview {
            overviewLabel.text =   "Description \n \(String(describing: description ))"
        }
        else {
            overviewLabel.text =    ""
        }
        

        if let path = viewModel.movie.posterPath {
            let url = URL(string: "https://image.tmdb.org/t/p/w500\(path)")!
             DispatchQueue.global().async {
                 self.posterImageView.setImage(with: url)
               
            }
        }

        updateFavoriteButton()
    }

    private func updateFavoriteButton() {
        let title = viewModel.isFavorite ? "Unfavorite" : "Favorite"
        favoriteButton.setTitle(title, for: .normal)
    }

    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        viewModel.toggleFavorite()
    }
}
