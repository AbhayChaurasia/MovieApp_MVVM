//
//  FavoriteListVC.swift
//  MovieAppMVVM
//
//  Created by Abhay Chaurasia on 15/06/25.
//

import UIKit
import Combine

class FavoriteListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
        //when run test case call this
  // var viewModel: FavoriteListViewModelProtocol!
    lazy var viewModel: FavoriteListViewModelProtocol = FavoriteListViewModel()
    // var viewModel = FavoriteListViewModel()
     var bag = Set<AnyCancellable>()
    var coordinator: SearchCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favorites List"
        tableView.dataSource = self
        tableView.delegate   = self
        viewModel.onFavoritesChanged = { [weak self] in
            DispatchQueue.main.async { self?.tableView.reloadData() }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.load()                  // refresh every time screen appears
    }
}

