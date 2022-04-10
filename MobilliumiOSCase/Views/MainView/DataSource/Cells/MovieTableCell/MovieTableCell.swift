//
//  MovieTableCell.swift
//  MobilliumiOSCase
//
//  Created by Said Çankıran on 10.04.2022.
//

import UIKit

protocol MovieTableCellOutputDelegate: AnyObject {
    
    func movieTapped(id: Int)
}

class MovieTableCell: BaseTableViewCell {
    
    class override var defaultHeight: CGFloat {
        return 136
    }

    @IBOutlet private weak var imageViewMoviePoster: UIImageView!
    @IBOutlet private weak var labelMovieTitle: UILabel!
    @IBOutlet private weak var labelMovieOverview: UILabel!
    @IBOutlet private weak var labelMovieDate: UILabel!
    
    private let activityIndicator = UIActivityIndicatorView()
    weak var outputDelegate: NowPlayingCollectionViewCellOutputDelegate?
    
    func configureView(baseMovieModel: BaseMovieModel) {
        
        if let url = baseMovieModel.posterPath {
            fetchMoviePoster(url: url)
        }
        
        labelMovieTitle.text = baseMovieModel.title ?? ""
        labelMovieOverview.text = baseMovieModel.overview ?? ""
        labelMovieDate.text = baseMovieModel.releaseDate ?? ""
        
        labelMovieOverview.textColor = UIColor(red: 141.0 / 255.0, green: 153.0 / 255.0, blue: 174.0 / 255.0, alpha: 1)
        labelMovieDate.textColor = UIColor(red: 141.0 / 255.0, green: 153.0 / 255.0, blue: 174.0 / 255.0, alpha: 1)
        
        handleTap(movieId: baseMovieModel.id)
    }
    
   
}

private extension MovieTableCell {
    
    func handleTap(movieId: Int?) {
        if let movieId = movieId {
            self.contentView.onTap { _ in
                self.outputDelegate?.movieTapped(movieID: movieId)
            }
        }
        
    }
}


// MARK: Private UI Extension
private extension MovieTableCell {
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
        if let url = URL(string: url) {
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

