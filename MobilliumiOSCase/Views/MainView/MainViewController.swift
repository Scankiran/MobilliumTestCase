//
//  MainViewController.swift
//  MobilliumiOSCase
//
//  Created by Said Çankıran on 10.04.2022.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: Outlets -
    @IBOutlet private weak var tableView: UITableView!


    // MARK: ViewModel -
    private lazy var viewModel: MainViewModel = {
        return MainViewModel()
    }()

    // MARK: Variables
    var dataSource: MainViewDataSource?
    let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeTableView()
        bindViewModel()
    }


    //MARK: Bind View Model
    private func bindViewModel() {

        viewModel.sendDataToView = { [weak self] (playingNowData, upComingData) in
            self?.dataSource?.updateDataSource(playingNowMovieData: playingNowData)
            self?.dataSource?.updateDataSource(upComingMovieData: upComingData)
            self?.tableView.reloadData()
            self?.refreshControl.endRefreshing()
        }
        
        // Check connection 
        Reachability.isConnectedToNetwork() ? viewModel.getMovieDatas(isRefresh: false, pageCount: 1) : showConnectionAlert()
    }



}

private extension MainViewController {

    func initializeTableView() {
        tableView.registerCell(SliderTableViewCell.self)
        tableView.registerCell(MovieTableCell.self)

        dataSource = MainViewDataSource(outputDelegate: self)
        tableView.delegate = dataSource
        tableView.dataSource = dataSource

        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }

    @objc func refresh(_ sender: AnyObject) {
        viewModel.getMovieDatas(isRefresh: true, pageCount: 1)
    }
    
    func showConnectionAlert() {
        let uiAlert = UIAlertController(title: "No Connection", message: "Please check your connection", preferredStyle: .alert)
        let action = UIAlertAction(title: "Okey", style: .default) { [unowned self] _ in
            Reachability.isConnectedToNetwork() ? self.viewModel.getMovieDatas(isRefresh: false, pageCount: 1) : self.showConnectionAlert()
        }
        uiAlert.addAction(action)
        self.present(uiAlert, animated: true)
    }
}

extension MainViewController: TableViewDataSourceOutputDelegate {
    func openMovieDetailPage(with ID: Int) {
        let movieDetailViewController = MovieDetailViewController()
        movieDetailViewController.setMovieIdToViewModel(movieId: ID)
        movieDetailViewController.modalPresentationStyle = .fullScreen
        self.present(movieDetailViewController, animated: true, completion: nil)
    }
    
    func fetchNextPageData(pageCount: Int) {
        viewModel.getMovieDatas(isRefresh: false, pageCount: pageCount)
    }

}
