//
//  NowPlayingCollectionViewCell.swift
//  MobilliumiOSCase
//
//  Created by Said Çankıran on 10.04.2022.
//

import UIKit
import Kingfisher

protocol NowPlayingCollectionViewCellOutputDelegate: AnyObject {
    
    func movieTapped(movieID: Int)
}

class NowPlayingCollectionViewCell: BaseCollectionViewCell {

    @IBOutlet private weak var mContentView: UIView!
    
    @IBOutlet private weak var imageViewMoviePoster: UIImageView!
    @IBOutlet private weak var labelDescription: UILabel!
    @IBOutlet private weak var labelTitle: UILabel!
    
    private let activityIndicator = UIActivityIndicatorView()
    weak var outputDelegate: NowPlayingCollectionViewCellOutputDelegate?
    
    func configureView(movieModel: BaseMovieModel) {
        
        if let posterString = movieModel.posterPath {
            fetchMoviePoster(url: posterString)
        }
        
        labelDescription.text = movieModel.overview ?? ""
        labelTitle.text = movieModel.title ?? ""
        
        handleTaps(movieId: movieModel.id)
    }
    
    func handleTaps(movieId: Int?) {
        if let id = movieId {
            self.mContentView.onTap { _ in
                self.outputDelegate?.movieTapped(movieID: id)
            }
        }
        
    }
    
}

// MARK: Private UI Extension
private extension NowPlayingCollectionViewCell {
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
