import UIKit
import RxSwift

public class CollectionViewDataSource<ITEM: CollectionViewItem, CELL: UICollectionViewCell>: NSObject,
UICollectionViewDataSource where CELL: CollectionViewCell {

    public private(set) var items: [CollectionViewItem] = [CollectionViewItem]()

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CELL = collectionView.dequeueReusableCell(withReuseIdentifier: CELL.identifier, for: indexPath) as! CELL
        cell.configureCell(with: items[indexPath.row])
        return cell
    }

    public func appendOnce(contentsOf newItems: [CollectionViewItem]) {
        items.removeAll()
        items.append(contentsOf: newItems)
    }

    public func count() -> Int {
        return items.count
    }

}
