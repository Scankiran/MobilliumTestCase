//
//  MovieDetailViewModel.swift
//  MobilliumiOSCase
//
//  Created by Said Çankıran on 10.04.2022.
//

import UIKit

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

//MARK: UI Functions
extension MovieDetailViewModel {
    
    func calculateLabelHeight(text: String, width: CGFloat) -> CGFloat {
        return text.height(withConstrainedWidth: width, font: UIFont(name: "SF-Pro-Text-Regular.tff", size: 15) ?? .systemFont(ofSize: 15))
    }

    func createPointLabelAttibutedString(text: String) -> NSAttributedString {
        let range = text.count
        var tempText = text
        tempText.append(contentsOf: "/10")
        let grayColor = UIColor(red: 141.0 / 255.0, green: 153.0 / 255.0, blue: 174.0 / 255.0, alpha: 1)

        let mutableString = NSMutableAttributedString(string: tempText)
        mutableString.addAttribute(.foregroundColor, value: grayColor, range: .init(location: 0, length: tempText.count))
        mutableString.addAttribute(.foregroundColor, value: UIColor.black, range: .init(location: 0, length: range))

        return mutableString
    }

    func getYearOfMovie(text: String?) -> String {
        if let text = text {
            return "(\(text.split(separator: "-").first ?? ""))"
        }
        return ""
    }
}
