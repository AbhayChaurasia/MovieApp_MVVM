//
//  FavoriteViewController+Extension.swift
//  MovieAppMVVM
//
//  Created by Abhay Chaurasia on 16/06/25.
//
import UIKit

// MARK: – UITableViewDataSource / Delegate
extension FavoriteListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    func tableView(_ tv: UITableView, numberOfRowsInSection _: Int) -> Int {
        viewModel.count
    }

    func tableView(_ tv: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tv.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieCell else {
            return UITableViewCell()
        }
        cell.configure(with: viewModel.movie(at: indexPath.row))
        return cell
    }

    func tableView(_ tv: UITableView, didSelectRowAt indexPath: IndexPath) {
        tv.deselectRow(at: indexPath, animated: true)
        let movie = viewModel.movie(at: indexPath.row)
    
     //    Instantiate details VC from storyboard
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let detailsVC = sb.instantiateViewController(
            withIdentifier: "MovieDetailsViewController"
        ) as! MovieDetailsViewController
        detailsVC.viewModel = MovieDetailsViewModel(movie: movie)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}
