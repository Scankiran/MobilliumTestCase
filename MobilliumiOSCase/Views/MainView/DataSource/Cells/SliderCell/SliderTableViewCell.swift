//
//  SliderTableViewCell.swift
//  MobilliumiOSCase
//
//  Created by Said Çankıran on 10.04.2022.
//

import UIKit

protocol SliderTableViewCellOutputDelegate: AnyObject {
    
    func sliderMovieTapped(movieId: Int)
}

class SliderTableViewCell: BaseTableViewCell {

    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var pageControl: UIPageControl!

    private var movieData: [BaseMovieModel] = []

    class override var defaultHeight: CGFloat {
        return 256
    }
    
    weak var outputDelegate: SliderTableViewCellOutputDelegate?

    func configureView(nowPlayingMovieData: [BaseMovieModel]) {
        self.movieData = nowPlayingMovieData
        initializeCollectionView()
        
    }

}

private extension SliderTableViewCell {

    func initializeCollectionView() {
        collectionView.registerNibCell(NowPlayingCollectionViewCell.self)

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
    }
    
    func initializePageControl() {
        pageControl.numberOfPages = 5
        pageControl.pageIndicatorTintColor = .gray
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.backgroundColor = .blue
    }
}

// MARK: UICollectionViewDelegates
extension SliderTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
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

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSet = scrollView.contentOffset.x
        let width = scrollView.frame.width
        let horizontalCenter = width / 2

        pageControl.currentPage = Int(offSet + horizontalCenter) / Int(width)
    }

}

extension SliderTableViewCell: NowPlayingCollectionViewCellOutputDelegate {

    func movieTapped(movieID: Int) {
        self.outputDelegate?.sliderMovieTapped(movieId: movieID)
    }
}
