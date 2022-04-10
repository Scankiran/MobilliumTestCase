//
//  MainViewDataSource.swift
//  MobilliumiOSCase
//
//  Created by Said Çankıran on 10.04.2022.
//

import UIKit

protocol TableViewDataSourceOutputDelegate: AnyObject {
    func openMovieDetailPage(with imdbID:String)
}

class TableViewDataSource: NSObject, UITableViewDelegate, UITableViewDataSource {

    private var baseMovieModelData: [BaseMovieModel] = []
    private weak var outputDelegate: TableViewDataSourceOutputDelegate? = nil

    init(outputDelegate: TableViewDataSourceOutputDelegate) {
        self.outputDelegate = outputDelegate
    }

    func updateDataSource(baseMovieModelData: [BaseMovieModel]) {
        self.baseMovieModelData = baseMovieModelData
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return baseMovieModelData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }

}

// MARK: BaseMovieInformationCellOutputDelegate
extension TableViewDataSource {
    
}
