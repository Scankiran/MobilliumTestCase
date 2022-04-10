//
//  MainViewModel.swift
//  MobilliumiOSCase
//
//  Created by Said Çankıran on 10.04.2022.
//

import Foundation


class MainViewModel {

    // MARK: Private Properties
    private let movieNetwork = MovieAPINetwork()

    //MARK: Closures
    var sendDataToView: (([BaseMovieModel], [BaseMovieModel]) -> ())?

    func getMovieDatas() {
        let dispatchGroup = DispatchGroup()
        var playingNowData: [BaseMovieModel] = []
        var upcomingData: [BaseMovieModel] = []
        
        dispatchGroup.enter()
        movieNetwork.getPlayingNow { responseModel in
            if let movieData = responseModel.results {
                playingNowData = movieData
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        movieNetwork.getUpComingMovies { responseModel in
            if let movieData = responseModel.results {
                upcomingData = movieData
            }
            dispatchGroup.leave()
        }

        dispatchGroup.notify(queue: .main) {
            self.sendDataToView?(playingNowData, upcomingData)
        }
    }
}
