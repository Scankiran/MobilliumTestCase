//
//  MovieDetailViewController.swift
//  MobilliumiOSCase
//
//  Created by Said Çankıran on 10.04.2022.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    // MARK: Outlets -
        @IBOutlet private weak var tableView: UITableView!

        // MARK: ViewModel -
        private lazy var viewModel: MovieDetailViewModel = {
            return MovieDetailViewModel()
        }()

        // MARK: Variables

        override func viewDidLoad() {
            super.viewDidLoad()
            
            bindViewModel()
        }


        //MARK: Bind View Model
        private func bindViewModel() {


        }


   
}
