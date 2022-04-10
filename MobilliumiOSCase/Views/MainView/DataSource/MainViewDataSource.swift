//
//  MainViewDataSource.swift
//  MobilliumiOSCase
//
//  Created by Said Çankıran on 10.04.2022.
//

import UIKit

protocol TableViewDataSourceOutputDelegate: AnyObject {
    func openMovieDetailPage(with ID:Int)
}

class MainViewDataSource: NSObject, UITableViewDelegate, UITableViewDataSource {

    private var playingNowMovieData: [BaseMovieModel] = []
    private var upComingMovieData: [BaseMovieModel] = []
    private weak var outputDelegate: TableViewDataSourceOutputDelegate? = nil

    init(outputDelegate: TableViewDataSourceOutputDelegate) {
        self.outputDelegate = outputDelegate
    }

    func updateDataSource(playingNowMovieData: [BaseMovieModel]) {
        self.playingNowMovieData = playingNowMovieData
    }
    
    func updateDataSource(upComingMovieData: [BaseMovieModel]) {
        self.upComingMovieData = upComingMovieData
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if playingNowMovieData.isEmpty {
           return 0
        }
        return upComingMovieData.count + 1
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0, !playingNowMovieData.isEmpty {
            let cell = tableView.generateReusableCell(SliderTableViewCell.self, indexPath: indexPath)
            cell.outputDelegate = self
            cell.configureView(nowPlayingMovieData: playingNowMovieData)
            return cell
        }
        
        let cell = tableView.generateReusableCell(MovieTableCell.self, indexPath: indexPath)
        cell.outputDelegate = self
        cell.configureView(baseMovieModel: upComingMovieData[indexPath.row - 1])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return SliderTableViewCell.defaultHeight
        }
        
        return MovieTableCell.defaultHeight
    }

}

// MARK: BaseMovieInformationCellOutputDelegate
extension MainViewDataSource: SliderTableViewCellOutputDelegate, MovieTableCellOutputDelegate {
    func sliderMovieTapped(movieId: Int) {
        self.outputDelegate?.openMovieDetailPage(with: movieId)
    }
    
    func movieTapped(id: Int) {
        self.outputDelegate?.openMovieDetailPage(with: id)
    }
    
}


enum DataType {
    case playingNow
    case upcoming
}
