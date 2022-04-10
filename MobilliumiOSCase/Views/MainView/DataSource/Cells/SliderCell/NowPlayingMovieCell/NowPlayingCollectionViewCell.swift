//
//  NowPlayingCollectionViewCell.swift
//  MobilliumiOSCase
//
//  Created by Said Çankıran on 10.04.2022.
//

import UIKit

class NowPlayingCollectionViewCell: BaseCollectionViewCell {

    @IBOutlet private weak var mContentView: UIView!
    
    @IBOutlet private weak var imageViewMoviePoster: UIImageView!
    @IBOutlet private weak var labelDescription: UILabel!
    @IBOutlet private weak var labelTitle: UILabel!
    
    func configureView(movieModel: BaseMovieModel) {
        
        handleTaps()
    }
    
    func handleTaps() {
        
    }
    
}
