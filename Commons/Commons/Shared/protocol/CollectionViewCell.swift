import UIKit

public protocol CollectionViewCell {

    static var identifier: String { get }

    func configureCell(with collectionViewItem: CollectionViewItem)

}


open class CollectionCell: UICollectionViewCell {

    open func reuseIdentifier() -> String {
        fatalError("override in subclass")
    }

    open func configureCell(with collectionViewItem: CollectionViewItem) {
        fatalError("override in subclass")
    }

}
