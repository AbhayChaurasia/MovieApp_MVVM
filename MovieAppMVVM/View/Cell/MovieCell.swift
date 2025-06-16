//
//  MovieCell.swift
//  MovieAppMVVM
//
//  Created by iMacRaja on 14/06/25.
//

import UIKit
import SDWebImage
class MovieCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!

    @IBOutlet weak var backView: UIView!
    func configure(with movie: Movie) {
        self.backView.round()
        self.backView.addBorder(color: UIColor.black, width: 0.5)
        self.backView.clipsToBounds = true
        titleLabel.text = movie.title ?? ""
        if let relaeseDate = movie.releaseDate {
            releaseLabel.text =  "Release Date: \(relaeseDate)"

        }
        else {
            releaseLabel.text = ""
        }
        if let path = movie.posterPath {
            let url = URL(string: "https://image.tmdb.org/t/p/w500\(path)")
            posterImageView.setImage(with: url)
 
        } else {
        
            posterImageView.image = UIImage(systemName: "film")
        }
    }
    
     

  

}


