//
//  SliderTableViewCell.swift
//  MobilliumiOSCase
//
//  Created by Said Çankıran on 10.04.2022.
//

import UIKit

class SliderTableViewCell: BaseTableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private var movieData: [BaseMovieModel] = []
    
    class override var defaultHeight: CGFloat {
        return 256
    }
    
    func configureView(nowPlayingMovieData: [BaseMovieModel]?) {
        
    }
    
    
}

private extension SliderTableViewCell {
    func handleTaps() {
        
    }
    
    func initializeCollectionView() {
        collectionView.registerNibCell(NowPlayingCollectionViewCell.self)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

// MARK: UICollectionViewDelegates
extension SliderTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.generateReusableCell(NowPlayingCollectionViewCell.self, indexPath: indexPath)
        
        cell.configureView(movieModel: movieData[indexPath.row])
        cell.outputDelegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 375, height: 256)
    }
    
}

extension SliderTableViewCell: NowPlayingCollectionViewCellOutputDelegate {
    
    func movieTapped(movieID: Int) {
        print(movieID)
    }
}
