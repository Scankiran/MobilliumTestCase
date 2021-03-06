//
//  MovieAPINetwork.swift
//  MobilliumiOSCase
//
//  Created by Said Çankıran on 10.04.2022.
//

import Foundation
import ProgressHUD
import Alamofire

class MovieAPINetwork {
    
    private let apiKey = "99fe6c6ab1a8bc88bd754ff5aa598e23"
    private let baseUrl = "https://api.themoviedb.org/3/movie/"
    
    
    func getUpComingMovies(pageCount: Int, completion: @escaping ((BaseMovieDataResponseModel) -> Void)) {
        ProgressHUD.show()

        let parameters: [String: String] = [
            "api_key": apiKey,
            "page": "\(pageCount)"
        ]
        
        AF.request("\(baseUrl)upcoming",
            method: .get,
            parameters: parameters).responseDecodable(of: BaseMovieDataResponseModel.self, completionHandler: { result in

            if let responseValue = result.value {
                ProgressHUD.dismiss()
                completion(responseValue)
            } else {
                ProgressHUD.showError(result.error?.localizedDescription, image: nil, interaction: false)
            }
        })
    }
    

    func getPlayingNow( completion: @escaping ((BaseMovieDataResponseModel) -> Void)) {
        ProgressHUD.show()

        let parameters: [String: String] = [
            "api_key": apiKey
        ]
        
        AF.request("\(baseUrl)now_playing",
            method: .get,
            parameters: parameters).responseDecodable(of: BaseMovieDataResponseModel.self, completionHandler: { result in

            if let responseValue = result.value {

                ProgressHUD.dismiss()
                completion(responseValue)
            } else {
                ProgressHUD.showError(result.error?.localizedDescription, image: nil, interaction: false)
            }
        })
    }
    
    
    func getMovieDetail(with id: Int, completion: @escaping ((MovieDetailModel) -> Void)) {
            ProgressHUD.show()

            let parameters: [String: String] = [
                "api_key": apiKey
            ]
            
            AF.request("\(baseUrl)\(id)",
                method: .get,
                parameters: parameters).responseDecodable(of: MovieDetailModel.self, completionHandler: { result in

                if let responseValue = result.value {
                    ProgressHUD.dismiss()
                    completion(responseValue)
                } else {
                    ProgressHUD.showError(result.error?.localizedDescription, image: nil, interaction: false)
                }
            })
        }
}
