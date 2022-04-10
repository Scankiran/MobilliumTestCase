//
//  MovieDetailViewController.swift
//  MobilliumiOSCase
//
//  Created by Said Çankıran on 10.04.2022.
//

import UIKit

class MovieDetailViewController: UIViewController {

    // MARK: Outlets -
    @IBOutlet private weak var labelMovieTitleOnBar: UILabel!
    @IBOutlet private weak var imageViewMoviePoster: UIImageView!
    @IBOutlet private weak var labelMovieRatePoint: UILabel!
    @IBOutlet private weak var labelMovieReleaseDate: UILabel!
    @IBOutlet private weak var labelMovieTitle: UILabel!
    @IBOutlet private weak var labelMovieOverview: UILabel!
    @IBOutlet weak var buttonCloseView: UIButton!
    
    // MARK: ViewModel -
    private lazy var viewModel: MovieDetailViewModel = {
        return MovieDetailViewModel()
    }()

    // MARK: Variables
    private let activityIndicator = UIActivityIndicatorView()


    override func viewDidLoad() {
        super.viewDidLoad()
        handleTap()
        bindViewModel()
    }


    //MARK: Bind View Model
    private func bindViewModel() {

        viewModel.sendDataToView = { [weak self] movieData in
            self?.fillTheViewComponents(with: movieData)
        }

    }
    
    func setMovieIdToViewModel(movieId: Int) {
        viewModel.movieId = movieId
    }

    func fillTheViewComponents(with movieDetailModel: MovieDetailModel) {
        if let url = movieDetailModel.posterPath {
            fetchMoviePoster(url: url)
        }
        labelMovieTitleOnBar.text = movieDetailModel.title ?? ""
        labelMovieTitle.text = movieDetailModel.title ?? ""
        labelMovieOverview.text = movieDetailModel.overview ?? ""
        labelMovieOverview.frame = CGRect(origin: labelMovieOverview.frame.origin,
                                          size: CGSize(width: labelMovieOverview.frame.width,
                                                       height: viewModel.calculateLabelHeight(text: movieDetailModel.overview ?? "",
                                                                                              width: labelMovieOverview.frame.width)))
        labelMovieReleaseDate.text = movieDetailModel.releaseDate ?? ""
        labelMovieRatePoint.attributedText = viewModel.createPointLabelAttibutedString(text: "\(movieDetailModel.voteAverage ?? 0)")
    }
    
    func handleTap() {
        buttonCloseView.onTap { _ in
            self.dismiss(animated: true, completion: nil)
        }
    }

}

private extension MovieDetailModel {


}

// MARK: Private UI Extension
private extension MovieDetailViewController {
    func showLoaderAnimation() {
        self.imageViewMoviePoster.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: imageViewMoviePoster.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: imageViewMoviePoster.centerYAnchor).isActive = true
        activityIndicator.startAnimating()
    }
    
    func hideLoaderAnimation() {
        self.activityIndicator.removeFromSuperview()
        activityIndicator.stopAnimating()
    }
    
    func fetchMoviePoster(url:String) {
        if let url = URL(string: "http://image.tmdb.org/t/p/w185/\(url)") {
            showLoaderAnimation()
            imageViewMoviePoster.kf.setImage(with: url) { result in
                self.hideLoaderAnimation()
                
                switch result {
                case .success(let imageResult):
                    self.imageViewMoviePoster.image = imageResult.image
                case .failure(let error):
                    self.imageViewMoviePoster.image = UIImage(named: "no_image_placeholder")
                    print(error.localizedDescription)
                }
            }
        }
    }
}

