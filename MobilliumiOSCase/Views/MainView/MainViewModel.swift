//
//  MainViewModel.swift
//  MobilliumiOSCase
//
//  Created by Said Çankıran on 10.04.2022.
//

import UIKit


class MainViewModel {

    // MARK: Private Properties
    private let movieNetwork = MovieAPINetwork()
    private var playingNowData: [BaseMovieModel] = []
    private var upcomingData: [BaseMovieModel] = []

    //MARK: Closures
    var sendDataToView: (([BaseMovieModel], [BaseMovieModel]) -> ())?

    func getMovieDatas(isRefresh: Bool, pageCount: Int) {
        let dispatchGroup = DispatchGroup()


        dispatchGroup.enter()
        movieNetwork.getPlayingNow { [weak self] responseModel in
            if let movieData = responseModel.results {
                self?.playingNowData = movieData
            }
            dispatchGroup.leave()
        }

        dispatchGroup.enter()
        movieNetwork.getUpComingMovies(pageCount: pageCount) { [weak self] responseModel in
            if let movieData = responseModel.results {
                if isRefresh {
                    self?.upcomingData = movieData
                } else {
                    self?.upcomingData.append(contentsOf: movieData)
                }
            }
            dispatchGroup.leave()
        }

        dispatchGroup.notify(queue: .main) {
            self.sendDataToView?(self.playingNowData, self.upcomingData)
        }
    }
}
