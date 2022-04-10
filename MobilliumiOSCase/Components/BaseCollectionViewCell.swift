//
//  BaseCollectionViewCell.swift
//  MobilliumiOSCase
//
//  Created by Said Çankıran on 10.04.2022.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {

    class var reuseIdentifier: String {
        return "\(self)"
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeCell()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeCell()
    }

    open override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        initializeCell()
    }

    internal func initializeCell() { }
    
    func calculateBaseDynamicWidth(height: CGFloat) -> CGSize {
        setNeedsLayout()
        layoutIfNeeded()
        let size: CGSize = contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        return CGSize(width: size.width, height: height)
    }

}

class BaseCollectionReusableView: UICollectionReusableView {

    class var reuseIdentifier: String {
        return "\(self)"
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    internal func initializeView() { }

}

 
extension UICollectionView {

    func deselectAllItems(animated: Bool = false) {
        for indexPath in self.indexPathsForSelectedItems ?? [] {
            self.deselectItem(at: indexPath, animated: animated)
        }
    }

    func registerCells<T: BaseCollectionViewCell>(_ instances: [T.Type]) {
        for instance in instances {
            self.registerCell(instance)
        }
    }
    
    func registerNibCell<T: BaseCollectionViewCell>(_ instance: T.Type) {
        self.register(UINib(nibName:"\(instance.self)",bundle:nil), forCellWithReuseIdentifier: instance.reuseIdentifier)
    }

    func registerCell<T: BaseCollectionViewCell>(_ instance: T.Type) {
        self.register(instance.self, forCellWithReuseIdentifier: instance.reuseIdentifier)
    }

    

    func generateReusableCell<T: BaseCollectionViewCell>(_ instance: T.Type, indexPath: IndexPath) -> T {
        guard let cell =
            self.dequeueReusableCell(withReuseIdentifier: instance.reuseIdentifier, for: indexPath) as? T else {
                fatalError("cell not found -> \(instance.reuseIdentifier)")
        }

        return cell
    }

}
