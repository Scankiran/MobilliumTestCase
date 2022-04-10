//
//  MovieDetailViewModel.swift
//  MobilliumiOSCase
//
//  Created by Said Çankıran on 10.04.2022.
//

import Foundation

class MovieDetailViewModel {

    private let movieNetwork = MovieAPINetwork()
    var movieId: Int = 0 {
        didSet {
            getMovieDetail()
        }
    }

    //MARK: Closures
    var sendDataToView: ((MovieDetailModel) -> ())?
    
    func getMovieDetail() {
        movieNetwork.getMovieDetail(with: movieId) { [weak self] movieDetailModelResult in
            self?.sendDataToView?(movieDetailModelResult)
        }
    }
}




