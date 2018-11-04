import UIKit

public extension UICollectionView {

    func registerCellNib<CELL: UICollectionViewCell>(with type: CELL.Type) {
   // func registerCellNib(with identifier: String, type: ) {
        let split = "\(type)".split(separator: ".").last ?? ""
        let name: String = String(describing: split)
        let bundle = Bundle(for: type)
        self.register(UINib(nibName: name, bundle: bundle), forCellWithReuseIdentifier: name)
    }

}


