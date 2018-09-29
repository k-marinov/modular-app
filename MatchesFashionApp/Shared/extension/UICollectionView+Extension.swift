import UIKit

extension UICollectionView {

    func registerCellNib(with identifier: String) {
        self.register(UINib(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
    }

}


