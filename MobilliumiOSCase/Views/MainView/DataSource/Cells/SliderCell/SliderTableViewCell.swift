//
//  SliderTableViewCell.swift
//  MobilliumiOSCase
//
//  Created by Said Çankıran on 10.04.2022.
//

import UIKit

class SliderTableViewCell: BaseTableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    class override var defaultHeight: CGFloat {
        return 256
    }
    
    func configureView(nowPlayingMovieData: [BaseMovieModel]?) {
        
    }
    
    func handleTaps() {
        
    }
}


extension SliderTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    
    
}
